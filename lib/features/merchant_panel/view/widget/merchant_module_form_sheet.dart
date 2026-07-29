import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/theme/app_context_colors.dart';
import 'package:lifeclient/core/theme/app_radius.dart';
import 'package:lifeclient/core/theme/app_spacing.dart';
import 'package:lifeclient/core/theme/app_text.dart';
import 'package:lifeclient/features/merchant_panel/model/merchant_showcase_module_model.dart';
import 'package:lifeclient/features/merchant_panel/model/merchant_showcase_type.dart';
import 'package:lifeclient/features/merchant_panel/model/merchant_showcase_type_extension.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/model/enum/text_field/text_field_max_lengths.dart';
import 'package:lifeclient/product/utility/constants/app_icon_sizes.dart';
import 'package:lifeclient/product/utility/constants/app_icons.dart';
import 'package:lifeclient/product/utility/decorations/empty_box.dart';
import 'package:lifeclient/product/utility/extension/date_time_extension.dart';
import 'package:lifeclient/product/utility/validator/validator_text_field.dart';
import 'package:lifeclient/product/widget/general/index.dart';
import 'package:lifeclient/product/widget/sheet/general_media_sheet.dart';
import 'package:lifeclient/product/widget/text_field/custom_text_form_multi_field.dart';

typedef MerchantModuleFormResult = (MerchantShowcaseModuleModel, File?);

final class MerchantModuleFormSheet extends ConsumerStatefulWidget {
  const MerchantModuleFormSheet({
    required this.moduleId,
    this.module,
    super.key,
  });

  static Future<MerchantModuleFormResult?> open(
    BuildContext context, {
    required String moduleId,
    MerchantShowcaseModuleModel? module,
  }) {
    return showModalBottomSheet<MerchantModuleFormResult>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (context) => Padding(
        padding: MediaQuery.viewInsetsOf(context),
        child: MerchantModuleFormSheet(moduleId: moduleId, module: module),
      ),
    );
  }

  final String moduleId;
  final MerchantShowcaseModuleModel? module;

  @override
  ConsumerState<MerchantModuleFormSheet> createState() =>
      _MerchantModuleFormSheetState();
}

final class _MerchantModuleFormSheetState
    extends ConsumerState<MerchantModuleFormSheet> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _titleController = TextEditingController(
    text: widget.module?.title ?? '',
  );
  late final TextEditingController _descriptionController =
      TextEditingController(text: widget.module?.description ?? '');

  late MerchantShowcaseType _type =
      widget.module?.type ?? MerchantShowcaseType.campaign;
  late DateTime? _startAt = widget.module?.startAt;
  late DateTime? _endAt = widget.module?.endAt;
  late bool _isActive = widget.module?.isActive ?? true;
  late String? _imageUrl = widget.module?.imageUrl;
  File? _imageFile;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _pickDate({required bool isStart}) async {
    final now = DateTime.now();
    final initial = (isStart ? _startAt : _endAt) ?? now;
    final selected = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(now.year - 1),
      lastDate: DateTime(now.year + 5),
    );
    if (selected == null || !mounted) return;
    setState(() {
      if (isStart) {
        _startAt = selected;
      } else {
        _endAt = selected;
      }
    });
  }

  Future<void> _pickImage() async {
    final file = await GeneralMediaSheet.open(context);
    if (file == null || !mounted) return;
    setState(() => _imageFile = file);
  }

  void _removeImage() => setState(() {
    _imageFile = null;
    _imageUrl = null;
  });

  void _submit() {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    final module = MerchantShowcaseModuleModel(
      id: widget.moduleId,
      type: _type,
      title: _titleController.text.trim(),
      description: _descriptionController.text.trim(),
      imageUrl: _imageUrl,
      startAt: _startAt,
      endAt: _endAt,
      isActive: _isActive,
      order: widget.module?.order ?? 0,
    );
    Navigator.of(context).pop((module, _imageFile));
  }

  @override
  Widget build(BuildContext context) {
    final imageFile = _imageFile;
    final imageUrl = _imageUrl;

    return SingleChildScrollView(
      padding: const PagePadding.all(),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GeneralBodyTitle(
              widget.module == null
                  ? LocaleKeys.merchantPanel_showcase_formTitleNew.tr()
                  : LocaleKeys.merchantPanel_showcase_formTitleEdit.tr(),
              fontWeight: FontWeight.bold,
            ),
            const EmptyBox.middleHeight(),
            Text(
              LocaleKeys.merchantPanel_showcase_typeLabel.tr(),
              style: AppText.label,
            ),
            const EmptyBox.xSmallHeight(),
            Row(
              spacing: AppSpacing.xs,
              children: [
                for (final type in MerchantShowcaseType.values)
                  Expanded(
                    child: ChoiceChip(
                      selected: _type == type,
                      showCheckmark: false,
                      selectedColor: context.appColors.coral50,
                      onSelected: (_) => setState(() => _type = type),
                      label: Row(
                        mainAxisSize: MainAxisSize.min,
                        spacing: AppSpacing.xxs,
                        children: [
                          Icon(type.icon, size: AppIconSizes.xMedium),
                          Flexible(
                            child: Text(
                              type.label.tr(),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppText.caption,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
            const EmptyBox.middleHeight(),
            Text(
              LocaleKeys.merchantPanel_showcase_titleLabel.tr(),
              style: AppText.label,
            ),
            const EmptyBox.xSmallHeight(),
            CustomTextFormMultiField(
              hint: LocaleKeys.merchantPanel_showcase_titleHint.tr(),
              controller: _titleController,
              maxLength: TextFieldMaxLengths.large,
              validator: ValidatorNormalTextField(),
            ),
            const EmptyBox.smallHeight(),
            Text(
              LocaleKeys.merchantPanel_showcase_descriptionLabel.tr(),
              style: AppText.label,
            ),
            const EmptyBox.xSmallHeight(),
            CustomTextFormMultiField(
              hint: LocaleKeys.merchantPanel_showcase_descriptionHint.tr(),
              controller: _descriptionController,
              maxLength: TextFieldMaxLengths.max,
              validator: ValidatorNormalTextField(),
            ),
            const EmptyBox.middleHeight(),
            Row(
              spacing: AppSpacing.xs,
              children: [
                Expanded(
                  child: _DateField(
                    label: LocaleKeys.merchantPanel_showcase_startLabel.tr(),
                    value: _startAt,
                    onTap: () => _pickDate(isStart: true),
                  ),
                ),
                Expanded(
                  child: _DateField(
                    label: LocaleKeys.merchantPanel_showcase_endLabel.tr(),
                    value: _endAt,
                    onTap: () => _pickDate(isStart: false),
                  ),
                ),
              ],
            ),
            const EmptyBox.middleHeight(),
            Text(
              LocaleKeys.merchantPanel_showcase_imageLabel.tr(),
              style: AppText.label,
            ),
            const EmptyBox.xSmallHeight(),
            if (imageFile != null || imageUrl != null)
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(AppRadius.md),
                    child: SizedBox(
                      width: double.infinity,
                      height: context.sized.dynamicHeight(0.16),
                      child: imageFile != null
                          ? Image.file(imageFile, fit: BoxFit.cover)
                          : Image.network(imageUrl!, fit: BoxFit.cover),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    top: 0,
                    child: IconButton(
                      onPressed: _removeImage,
                      style: IconButton.styleFrom(
                        backgroundColor: context.appColors.navy700.withValues(
                          alpha: .6,
                        ),
                        foregroundColor: context.appColors.surface,
                      ),
                      icon: const Icon(
                        AppIcons.close,
                        size: AppIconSizes.xMedium,
                      ),
                    ),
                  ),
                ],
              )
            else
              OutlinedButton.icon(
                onPressed: _pickImage,
                icon: const Icon(AppIcons.addPhoto, size: AppIconSizes.medium),
                label: Text(LocaleKeys.merchantPanel_showcase_imageAdd.tr()),
              ),
            const EmptyBox.smallHeight(),
            SwitchListTile.adaptive(
              value: _isActive,
              contentPadding: EdgeInsets.zero,
              onChanged: (value) => setState(() => _isActive = value),
              title: Text(
                LocaleKeys.merchantPanel_showcase_activeLabel.tr(),
                style: AppText.bodyLg,
              ),
            ),
            const EmptyBox.smallHeight(),
            GeneralButtonV2.active(
              action: _submit,
              label: LocaleKeys.merchantPanel_showcase_publishAction.tr(),
            ),
            const EmptyBox.middleHeight(),
          ],
        ),
      ),
    );
  }
}

final class _DateField extends StatelessWidget {
  const _DateField({
    required this.label,
    required this.value,
    required this.onTap,
  });

  final String label;
  final DateTime? value;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppText.caption),
        const EmptyBox.xSmallHeight(),
        OutlinedButton.icon(
          onPressed: onTap,
          icon: const Icon(AppIcons.calendar, size: AppIconSizes.xMedium),
          label: Text(
            value?.shortDate ??
                LocaleKeys.merchantPanel_showcase_dateEmpty.tr(),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
