import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/theme/app_context_colors.dart';
import 'package:lifeclient/core/theme/app_radius.dart';
import 'package:lifeclient/core/theme/app_spacing.dart';
import 'package:lifeclient/core/theme/app_text.dart';
import 'package:lifeclient/features/merchant_panel/model/merchant_showcase_type_extension.dart';
import 'package:lifeclient/features/merchant_panel/provider/merchant_showcase_view_model.dart';
import 'package:lifeclient/features/merchant_panel/view/mixin/merchant_showcase_mixin.dart';
import 'package:lifeclient/features/merchant_panel/view/widget/merchant_showcase_card.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/utility/constants/app_constants.dart';
import 'package:lifeclient/product/utility/constants/app_icon_sizes.dart';
import 'package:lifeclient/product/utility/constants/app_icons.dart';
import 'package:lifeclient/product/utility/mixin/app_provider_mixin.dart';
import 'package:lifeclient/product/widget/general/general_not_found_widget.dart';

part 'widget/merchant_showcase_editor.dart';
part 'widget/merchant_showcase_module_tile.dart';

final class MerchantShowcaseSubView extends ConsumerStatefulWidget {
  const MerchantShowcaseSubView({required this.storeId, super.key});

  final String storeId;

  @override
  ConsumerState<MerchantShowcaseSubView> createState() =>
      _MerchantShowcaseSubViewState();
}

final class _MerchantShowcaseSubViewState
    extends ConsumerState<MerchantShowcaseSubView>
    with AppProviderMixin<MerchantShowcaseSubView>, MerchantShowcaseMixin {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(merchantShowcaseViewModelProvider(widget.storeId));

    if (state.isFetching) {
      return const PlaceShimmerList();
    }

    if (state.isError && state.modules.isEmpty) {
      return GeneralNotFoundWidget(
        title: LocaleKeys.message_somethingWentWrong.tr(),
        onRefresh: () => unawaited(viewModel.retry()),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _MerchantShowcaseToolbar(
          isPreview: state.isPreview,
          onTogglePreview: viewModel.togglePreview,
          onAdd: () => unawaited(openModuleForm()),
        ),
        Expanded(
          child: state.isPreview
              ? _MerchantShowcasePreview(modules: state.publishedModules)
              : _MerchantShowcaseEditor(
                  storeId: widget.storeId,
                  modules: state.modules,
                  onReorder: (oldIndex, newIndex) =>
                      unawaited(viewModel.reorder(oldIndex, newIndex)),
                  onEdit: (module) => unawaited(openModuleForm(module: module)),
                  onDelete: (module) => unawaited(confirmDelete(module)),
                  onToggleActive: (module) => unawaited(toggleActive(module)),
                ),
        ),
      ],
    );
  }
}

final class _MerchantShowcaseToolbar extends StatelessWidget {
  const _MerchantShowcaseToolbar({
    required this.isPreview,
    required this.onTogglePreview,
    required this.onAdd,
  });

  final bool isPreview;
  final VoidCallback onTogglePreview;
  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const PagePadding.generalAllLow(),
      child: Row(
        children: [
          Expanded(
            child: Text(
              isPreview
                  ? LocaleKeys.merchantPanel_showcase_previewTitle.tr()
                  : LocaleKeys.merchantPanel_showcase_reorderHint.tr(),
              style: AppText.caption,
            ),
          ),
          TextButton.icon(
            onPressed: onTogglePreview,
            icon: Icon(
              isPreview ? AppIcons.edit : AppIcons.visibility,
              size: AppIconSizes.medium,
            ),
            label: Text(
              isPreview
                  ? LocaleKeys.merchantPanel_showcase_editAction.tr()
                  : LocaleKeys.merchantPanel_showcase_previewAction.tr(),
            ),
          ),
          if (!isPreview)
            IconButton.filled(
              onPressed: onAdd,
              icon: const Icon(AppIcons.add, size: AppIconSizes.medium),
            ),
        ],
      ),
    );
  }
}
