import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart' show ContextExtension;
import 'package:lifeclient/product/init/application_theme.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/package/photo_picker/photo_picker_manager.dart';
import 'package:lifeclient/product/repository/merchant/merchant_application_input.dart';
import 'package:lifeclient/product/repository/merchant/merchant_application_repository_provider.dart';
import 'package:lifeclient/product/utility/decorations/custom_radius.dart';
import 'package:lifeclient/product/utility/decorations/empty_box.dart';
import 'package:lifeclient/product/widget/brand/eyebrow.dart';

/// 4-step merchant ("esnaf") onboarding modal. Submits to
/// `merchant_applications/` via [MerchantApplicationRepository].
class MerchantOnboardingView extends ConsumerStatefulWidget {
  const MerchantOnboardingView({super.key});

  @override
  ConsumerState<MerchantOnboardingView> createState() =>
      _MerchantOnboardingViewState();
}

class _MerchantOnboardingViewState
    extends ConsumerState<MerchantOnboardingView> {
  int _step = 0;
  static const _totalSteps = 4;

  // Step 1
  final _placeNameCtrl = TextEditingController();
  final _categoryCtrl = TextEditingController();
  final _descriptionCtrl = TextEditingController();
  final _photos = <File>[];

  // Step 2
  final _phoneCtrl = TextEditingController();
  final _addressCtrl = TextEditingController();
  final _hoursCtrl = TextEditingController();

  // Step 3
  final _ownerNameCtrl = TextEditingController();
  final _taxNumberCtrl = TextEditingController();
  final _registryCtrl = TextEditingController();
  final _documents = <File>[];

  bool _submitting = false;

  @override
  void dispose() {
    _placeNameCtrl.dispose();
    _categoryCtrl.dispose();
    _descriptionCtrl.dispose();
    _phoneCtrl.dispose();
    _addressCtrl.dispose();
    _hoursCtrl.dispose();
    _ownerNameCtrl.dispose();
    _taxNumberCtrl.dispose();
    _registryCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.general.colorScheme;
    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        backgroundColor: colorScheme.secondary,
        leading: IconButton(
          icon: Icon(Icons.close_rounded, color: colorScheme.primary),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
        title: Text(
          LocaleKeys.merchantOnboarding_title.tr(),
          style: V2Typography.display(fontSize: 20, color: colorScheme.primary),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4),
          child: LinearProgressIndicator(
            minHeight: 4,
            value: (_step + 1) / _totalSteps,
            backgroundColor: colorScheme.onPrimaryContainer,
            valueColor: AlwaysStoppedAnimation<Color>(colorScheme.error),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                children: [
                  Eyebrow(
                    LocaleKeys.merchantOnboarding_stepOf.tr(
                      namedArgs: {
                        'current': '${_step + 1}',
                        'total': '$_totalSteps',
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Expanded(child: _buildStep()),
              _BottomBar(
                step: _step,
                totalSteps: _totalSteps,
                submitting: _submitting,
                onBack: _step == 0 ? null : () => setState(() => _step--),
                onNext: () => setState(() => _step++),
                onSubmit: _submit,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStep() {
    switch (_step) {
      case 0:
        return _Step1Place(
          placeNameCtrl: _placeNameCtrl,
          categoryCtrl: _categoryCtrl,
          descriptionCtrl: _descriptionCtrl,
          photos: _photos,
          onAddPhoto: _addPhoto,
          onRemovePhoto: (i) => setState(() => _photos.removeAt(i)),
        );
      case 1:
        return _Step2Contact(
          phoneCtrl: _phoneCtrl,
          addressCtrl: _addressCtrl,
          hoursCtrl: _hoursCtrl,
        );
      case 2:
        return _Step3Owner(
          ownerNameCtrl: _ownerNameCtrl,
          taxNumberCtrl: _taxNumberCtrl,
          registryCtrl: _registryCtrl,
          documents: _documents,
          onAddDocument: _addDocument,
          onRemoveDocument: (i) => setState(() => _documents.removeAt(i)),
        );
      case 3:
        return _Step4Preview(
          placeName: _placeNameCtrl.text,
          category: _categoryCtrl.text,
          phone: _phoneCtrl.text,
          ownerName: _ownerNameCtrl.text,
          photoCount: _photos.length,
          documentCount: _documents.length,
        );
      default:
        return const SizedBox.shrink();
    }
  }

  Future<void> _addPhoto() async {
    final manager = PhotoPickerManager(context: context);
    final file = await manager.pickPhoto(type: PhotoPickType.gallery);
    if (file == null || _photos.length >= 5) return;
    setState(() => _photos.add(file));
  }

  Future<void> _addDocument() async {
    final manager = PhotoPickerManager(context: context);
    final file = await manager.pickPhoto(type: PhotoPickType.gallery);
    if (file == null) return;
    setState(() => _documents.add(file));
  }

  Future<void> _submit() async {
    setState(() => _submitting = true);
    try {
      await ref
          .read(merchantApplicationRepositoryProvider)
          .submit(
            MerchantApplicationInput(
              placeName: _placeNameCtrl.text,
              placeCategory: _categoryCtrl.text,
              description: _descriptionCtrl.text,
              photoFiles: _photos,
              phone: _phoneCtrl.text,
              address: _addressCtrl.text,
              hours: _hoursCtrl.text,
              ownerName: _ownerNameCtrl.text,
              taxNumber: _taxNumberCtrl.text,
              registryNumber: _registryCtrl.text,
              documentFiles: _documents,
            ),
          );
      if (!mounted) return;
      final colorScheme = context.general.colorScheme;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: colorScheme.primaryContainer,
          content: Text(LocaleKeys.profileV2_merchantPendingTitle.tr()),
        ),
      );
      Navigator.of(context).maybePop();
    } catch (e) {
      if (!mounted) return;
      final colorScheme = context.general.colorScheme;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: colorScheme.error,
          content: Text(e.toString()),
        ),
      );
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }
}

class _Step1Place extends StatelessWidget {
  const _Step1Place({
    required this.placeNameCtrl,
    required this.categoryCtrl,
    required this.descriptionCtrl,
    required this.photos,
    required this.onAddPhoto,
    required this.onRemovePhoto,
  });

  final TextEditingController placeNameCtrl;
  final TextEditingController categoryCtrl;
  final TextEditingController descriptionCtrl;
  final List<File> photos;
  final Future<void> Function() onAddPhoto;
  final ValueChanged<int> onRemovePhoto;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.general.colorScheme;
    final textTheme = context.general.textTheme;
    return ListView(
      children: [
        Text(
          LocaleKeys.merchantOnboarding_step1Title.tr(),
          style: V2Typography.display(fontSize: 24, color: colorScheme.primary),
        ),
        const EmptyBox.smallHeight(),
        Text(
          LocaleKeys.merchantOnboarding_step1Body.tr(),
          style: textTheme.bodyMedium?.copyWith(
            color: colorScheme.onPrimaryFixedVariant,
          ),
        ),
        const EmptyBox.middleHeight(),
        _Field(
          label: LocaleKeys.merchantOnboarding_fieldPlaceName.tr(),
          controller: placeNameCtrl,
        ),
        _Field(
          label: LocaleKeys.merchantOnboarding_fieldCategory.tr(),
          controller: categoryCtrl,
        ),
        _Field(
          label: LocaleKeys.merchantOnboarding_fieldDescription.tr(),
          controller: descriptionCtrl,
          maxLines: 4,
        ),
        const EmptyBox.smallHeight(),
        Text(
          LocaleKeys.merchantOnboarding_fieldPhotos.tr(),
          style: textTheme.labelMedium?.copyWith(
            fontWeight: FontWeight.w700,
            color: colorScheme.onPrimaryFixedVariant,
          ),
        ),
        const EmptyBox.smallHeight(),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (var i = 0; i < photos.length; i++)
              _PhotoTile(
                file: photos[i],
                onRemove: () => onRemovePhoto(i),
              ),
            if (photos.length < 5) _AddPhotoTile(onTap: onAddPhoto),
          ],
        ),
      ],
    );
  }
}

class _Step2Contact extends StatelessWidget {
  const _Step2Contact({
    required this.phoneCtrl,
    required this.addressCtrl,
    required this.hoursCtrl,
  });

  final TextEditingController phoneCtrl;
  final TextEditingController addressCtrl;
  final TextEditingController hoursCtrl;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.general.colorScheme;
    return ListView(
      children: [
        Text(
          LocaleKeys.merchantOnboarding_step2Title.tr(),
          style: V2Typography.display(fontSize: 24, color: colorScheme.primary),
        ),
        const EmptyBox.middleHeight(),
        _Field(
          label: LocaleKeys.merchantOnboarding_fieldPhone.tr(),
          controller: phoneCtrl,
          keyboardType: TextInputType.phone,
        ),
        _Field(
          label: LocaleKeys.merchantOnboarding_fieldAddress.tr(),
          controller: addressCtrl,
          maxLines: 2,
        ),
        _Field(
          label: LocaleKeys.merchantOnboarding_fieldHours.tr(),
          controller: hoursCtrl,
        ),
      ],
    );
  }
}

class _Step3Owner extends StatelessWidget {
  const _Step3Owner({
    required this.ownerNameCtrl,
    required this.taxNumberCtrl,
    required this.registryCtrl,
    required this.documents,
    required this.onAddDocument,
    required this.onRemoveDocument,
  });

  final TextEditingController ownerNameCtrl;
  final TextEditingController taxNumberCtrl;
  final TextEditingController registryCtrl;
  final List<File> documents;
  final Future<void> Function() onAddDocument;
  final ValueChanged<int> onRemoveDocument;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.general.colorScheme;
    final textTheme = context.general.textTheme;
    return ListView(
      children: [
        Text(
          LocaleKeys.merchantOnboarding_step3Title.tr(),
          style: V2Typography.display(fontSize: 24, color: colorScheme.primary),
        ),
        const EmptyBox.smallHeight(),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: colorScheme.tertiaryContainer,
            borderRadius: CustomRadius.medium,
          ),
          child: Text(
            LocaleKeys.merchantOnboarding_step3Body.tr(),
            style: textTheme.bodySmall?.copyWith(
              color: colorScheme.onTertiaryContainer,
              height: 1.5,
            ),
          ),
        ),
        const EmptyBox.middleHeight(),
        _Field(
          label: LocaleKeys.merchantOnboarding_fieldOwnerName.tr(),
          controller: ownerNameCtrl,
        ),
        _Field(
          label: LocaleKeys.merchantOnboarding_fieldTaxNumber.tr(),
          controller: taxNumberCtrl,
          keyboardType: TextInputType.number,
        ),
        _Field(
          label: LocaleKeys.merchantOnboarding_fieldRegistry.tr(),
          controller: registryCtrl,
        ),
        const EmptyBox.smallHeight(),
        Text(
          LocaleKeys.merchantOnboarding_fieldDocuments.tr(),
          style: textTheme.labelMedium?.copyWith(
            fontWeight: FontWeight.w700,
            color: colorScheme.onPrimaryFixedVariant,
          ),
        ),
        const EmptyBox.smallHeight(),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (var i = 0; i < documents.length; i++)
              _PhotoTile(
                file: documents[i],
                onRemove: () => onRemoveDocument(i),
              ),
            _AddPhotoTile(onTap: onAddDocument),
          ],
        ),
      ],
    );
  }
}

class _Step4Preview extends StatelessWidget {
  const _Step4Preview({
    required this.placeName,
    required this.category,
    required this.phone,
    required this.ownerName,
    required this.photoCount,
    required this.documentCount,
  });

  final String placeName;
  final String category;
  final String phone;
  final String ownerName;
  final int photoCount;
  final int documentCount;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.general.colorScheme;
    final textTheme = context.general.textTheme;
    return ListView(
      children: [
        Text(
          LocaleKeys.merchantOnboarding_step4Title.tr(),
          style: V2Typography.display(fontSize: 24, color: colorScheme.primary),
        ),
        const EmptyBox.smallHeight(),
        Text(
          LocaleKeys.merchantOnboarding_step4Body.tr(),
          style: textTheme.bodyMedium?.copyWith(
            color: colorScheme.onPrimaryFixedVariant,
          ),
        ),
        const EmptyBox.largeHeight(),
        _PreviewRow(
          label: LocaleKeys.merchantOnboarding_fieldPlaceName.tr(),
          value: placeName,
        ),
        _PreviewRow(
          label: LocaleKeys.merchantOnboarding_fieldCategory.tr(),
          value: category,
        ),
        _PreviewRow(
          label: LocaleKeys.merchantOnboarding_fieldPhone.tr(),
          value: phone,
        ),
        _PreviewRow(
          label: LocaleKeys.merchantOnboarding_fieldOwnerName.tr(),
          value: ownerName,
        ),
        _PreviewRow(
          label: LocaleKeys.merchantOnboarding_fieldPhotos.tr(),
          value: '$photoCount',
        ),
        _PreviewRow(
          label: LocaleKeys.merchantOnboarding_fieldDocuments.tr(),
          value: '$documentCount',
        ),
      ],
    );
  }
}

class _Field extends StatelessWidget {
  const _Field({
    required this.label,
    required this.controller,
    this.maxLines = 1,
    this.keyboardType,
  });

  final String label;
  final TextEditingController controller;
  final int maxLines;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.general.colorScheme;
    final textTheme = context.general.textTheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: textTheme.labelSmall?.copyWith(
              fontWeight: FontWeight.w700,
              color: colorScheme.onPrimaryFixedVariant,
            ),
          ),
          const SizedBox(height: 6),
          TextField(
            controller: controller,
            maxLines: maxLines,
            keyboardType: keyboardType,
            decoration: InputDecoration(
              filled: true,
              fillColor: colorScheme.secondary,
              border: OutlineInputBorder(
                borderRadius: CustomRadius.medium,
                borderSide: BorderSide(color: colorScheme.onPrimaryContainer),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: CustomRadius.medium,
                borderSide: BorderSide(color: colorScheme.onPrimaryContainer),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: CustomRadius.medium,
                borderSide: BorderSide(color: colorScheme.primary),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PreviewRow extends StatelessWidget {
  const _PreviewRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.general.colorScheme;
    final textTheme = context.general.textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: textTheme.labelSmall?.copyWith(
                color: colorScheme.onSecondaryFixed,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value.isEmpty ? '—' : value,
              style: textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: colorScheme.onSurface,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PhotoTile extends StatelessWidget {
  const _PhotoTile({required this.file, required this.onRemove});

  final File file;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.general.colorScheme;
    return Stack(
      children: [
        ClipRRect(
          borderRadius: CustomRadius.medium,
          child: SizedBox(
            width: 80,
            height: 80,
            child: Image.file(file, fit: BoxFit.cover),
          ),
        ),
        Positioned(
          top: 4,
          right: 4,
          child: InkWell(
            onTap: onRemove,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: colorScheme.onSurface.withValues(alpha: 0.6),
                borderRadius: const BorderRadius.all(Radius.circular(99)),
              ),
              child: Icon(
                Icons.close_rounded,
                size: 12,
                color: colorScheme.onPrimary,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _AddPhotoTile extends StatelessWidget {
  const _AddPhotoTile({required this.onTap});

  final Future<void> Function() onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.general.colorScheme;
    return InkWell(
      onTap: () => onTap(),
      borderRadius: CustomRadius.medium,
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          color: colorScheme.onPrimaryFixed,
          borderRadius: CustomRadius.medium,
          border: Border.all(color: colorScheme.onPrimaryContainer),
        ),
        child: Icon(Icons.add_rounded, color: colorScheme.primary),
      ),
    );
  }
}

class _BottomBar extends StatelessWidget {
  const _BottomBar({
    required this.step,
    required this.totalSteps,
    required this.submitting,
    required this.onBack,
    required this.onNext,
    required this.onSubmit,
  });

  final int step;
  final int totalSteps;
  final bool submitting;
  final VoidCallback? onBack;
  final VoidCallback onNext;
  final Future<void> Function() onSubmit;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.general.colorScheme;
    final isLast = step == totalSteps - 1;
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Row(
        children: [
          if (onBack != null)
            Expanded(
              child: OutlinedButton(
                onPressed: onBack,
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  side: BorderSide(color: colorScheme.onPrimaryContainer),
                  shape: const RoundedRectangleBorder(
                    borderRadius: CustomRadius.medium,
                  ),
                ),
                child: Text(LocaleKeys.merchantOnboarding_back.tr()),
              ),
            ),
          if (onBack != null) const EmptyBox(width: 12),
          Expanded(
            flex: 2,
            child: ElevatedButton(
              onPressed: submitting
                  ? null
                  : (isLast ? () => onSubmit() : onNext),
              style: ElevatedButton.styleFrom(
                backgroundColor: colorScheme.error,
                foregroundColor: colorScheme.onPrimary,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: const RoundedRectangleBorder(
                  borderRadius: CustomRadius.medium,
                ),
              ),
              child: submitting
                  ? SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: colorScheme.onPrimary,
                      ),
                    )
                  : Text(
                      isLast
                          ? LocaleKeys.merchantOnboarding_submit.tr()
                          : LocaleKeys.merchantOnboarding_next.tr(),
                      style: const TextStyle(fontWeight: FontWeight.w800),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
