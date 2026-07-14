part of '../merchant_application_view.dart';

final class _MerchantCompanyStep extends ConsumerStatefulWidget {
  const _MerchantCompanyStep({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MerchantCompanyStepState();
}

final class _MerchantCompanyStepState
    extends RequestFormConsumerState<_MerchantCompanyStep>
    with AppProviderMixin<_MerchantCompanyStep>, _MerchantCompanyStepMixin {
  @override
  Widget onBuild(BuildContext context) {
    final companyItems = ref
        .watch(
          merchantApplicationViewModelProvider.select(
            (value) => value.companies,
          ),
        )
        .map(_CompanyDropdownItem.new)
        .toList();
    return ListViewWithSpace(
      children: [
        _CompanyModeSelector(
          isNewMode: _isNewCompanyMode,
          onChanged: (isNew) => toggleCompanyMode(isNew: isNew),
        ),
        if (!_isNewCompanyMode)
          CustomDropdownFormField<_CompanyDropdownItem>(
            hint: LocaleKeys.merchantApplication_selectCompany.tr(),
            onSelected: onCompanySelected,
            items: companyItems,
            initialValue: _selectedCompany,
          ),
        CustomTextFormFieldWithTitle(
          maxLength: TextFieldMaxLengths.large,
          title: LocaleKeys.requestCompany_name.tr(),
          controller: placeNameController,
          validator: ValidatorNormalTextField(),
        ),
        CustomTextFormFieldWithTitle.multiLine(
          maxLength: TextFieldMaxLengths.large,
          title: LocaleKeys.requestCompany_description.tr(),
          controller: placeDescriptionController,
          validator: ValidatorNormalTextField(),
        ),
        Row(
          children: [
            Expanded(
              child: CustomDropdownFormField<RegionalCityModel>(
                hint: '',
                onSelected: updateRegionalCityItem,
                items: regionalCityModels,
                initialValue: selectedRegionalCityModel,
              ),
            ),
            const EmptyBox.middleWidth(),
            Expanded(
              child: CustomDropdownFormField<RegionalTownSubItem>(
                hint: '',
                onSelected: updateRegionalTownItem,
                items: selectedRegionalTownModel.towns,
                initialValue: selectedRegionalTownSubItem,
              ),
            ),
          ],
        ),
        OpenAndCloseTimePicker(
          closeTimeController: closeTimeController,
          openTimeController: openTimeController,
        ),
        Padding(
          padding: const PagePadding.vertical12Symmetric(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  GeneralBodySmallTitle(
                    LocaleKeys.merchantApplication_photosTitle.tr(),
                    fontWeight: FontWeight.w500,
                  ),
                  const Spacer(),
                  GeneralBodySmallTitle(
                    LocaleKeys.merchantApplication_photosHint.tr(),
                    fontWeight: FontWeight.w500,
                    color: AppColors.ink400,
                  ),
                ],
              ),
              const EmptyBox.smallHeight(),
              Row(
                children: [
                  for (var i = 0; i < _maxPhotoCount; i++) ...[
                    if (i != 0) const SizedBox(width: WidgetSizes.spacingXs),
                    Expanded(
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: _MerchantPhotoSlot(
                          file: i < _photoFiles.length ? _photoFiles[i] : null,
                          onTap: () => _onPhotoSlotTapped(i),
                          onRemove: () => _onPhotoRemoved(i),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GeneralBodySmallTitle(
              LocaleKeys.requestCompany_chooseCategory.tr(),
              fontWeight: FontWeight.w500,
            ),
            const EmptyBox.middleHeight(),
            Wrap(
              spacing: WidgetSizes.spacingXs,
              runSpacing: WidgetSizes.spacingXs,
              children: [
                for (final category in categoryModels)
                  ActionChip(
                    onPressed: () => _onCategorySelected(category),
                    elevation: kZero,
                    pressElevation: kZero,
                    backgroundColor: _selectedCategory == category
                        ? AppColors.coral
                        : AppColors.surface,
                    label: GeneralBodySmallTitle(
                      category.displayName,
                      fontWeight: FontWeight.w500,
                      color: _selectedCategory == category
                          ? AppColors.white
                          : context.general.colorScheme.primary,
                    ),
                  ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

final class _CompanyDropdownItem extends Equatable with BaseDropDownModel {
  const _CompanyDropdownItem(this.store);

  final StoreModel store;

  @override
  String get displayName => store.name;

  @override
  List<Object?> get props => [store.documentId];
}

final class _CompanyModeSelector extends StatelessWidget {
  const _CompanyModeSelector({
    required this.isNewMode,
    required this.onChanged,
  });

  final bool isNewMode;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _ModeChip(
            label: LocaleKeys.merchantApplication_modeExisting.tr(),
            isSelected: !isNewMode,
            onTap: () => onChanged(false),
          ),
        ),
        const EmptyBox.smallWidth(),
        Expanded(
          child: _ModeChip(
            label: LocaleKeys.merchantApplication_modeNew.tr(),
            isSelected: isNewMode,
            onTap: () => onChanged(true),
          ),
        ),
      ],
    );
  }
}

final class _ModeChip extends StatelessWidget {
  const _ModeChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashFactory: NoSplash.splashFactory,
      onTap: onTap,
      child: AnimatedContainer(
        duration: DurationConstant.durationLow,
        padding: const PagePadding.vertical12Symmetric(),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.coral : AppColors.surface,
          borderRadius: CustomRadius.medium,
          border: Border.all(
            color: isSelected ? AppColors.coral : AppColors.ink100,
          ),
        ),
        child: Center(
          child: GeneralBodySmallTitle(
            label,
            fontWeight: FontWeight.w500,
            color: isSelected
                ? AppColors.white
                : context.general.colorScheme.primary,
          ),
        ),
      ),
    );
  }
}

final class _MerchantPhotoSlot extends StatelessWidget {
  const _MerchantPhotoSlot({
    required this.file,
    required this.onTap,
    required this.onRemove,
  });

  final File? file;
  final VoidCallback onTap;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    final photoFile = file;
    if (photoFile == null) {
      return InkWell(
        splashFactory: NoSplash.splashFactory,
        onTap: onTap,
        child: const GeneralDottedRectangle(
          child: SizedBox.expand(
            child: Icon(
              AppIcons.addPhoto,
              color: AppColors.ink300,
            ),
          ),
        ),
      );
    }
    return Stack(
      fit: StackFit.expand,
      children: [
        InkWell(
          splashFactory: NoSplash.splashFactory,
          onTap: onTap,
          child: ClipRRect(
            borderRadius: CustomRadius.medium,
            child: Image.file(photoFile, fit: BoxFit.cover),
          ),
        ),
        Positioned(
          top: WidgetSizes.spacingXSS,
          right: WidgetSizes.spacingXSS,
          child: InkWell(
            splashFactory: NoSplash.splashFactory,
            onTap: onRemove,
            child: Container(
              width: WidgetSizes.spacingL,
              height: WidgetSizes.spacingL,
              decoration: const BoxDecoration(
                color: AppColors.ink800,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                AppIcons.close,
                size: WidgetSizes.spacingM,
                color: AppColors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
