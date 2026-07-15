part of '../merchant_application_view.dart';

final class _MerchantCompanyStep extends ConsumerStatefulWidget {
  const _MerchantCompanyStep({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MerchantCompanyStepState();
}

final class _MerchantCompanyStepState
    extends StepFormConsumerState<_MerchantCompanyStep>
    with AppProviderMixin<_MerchantCompanyStep>, _MerchantCompanyStepMixin {
  @override
  Widget onBuild(BuildContext context) {
    final companyItems = ref
        .watch(
          merchantApplicationViewModelProvider.select(
            (value) => value.companies,
          ),
        )
        .map(MerchantCompanyDropdownModel.new)
        .toList();
    return ListViewWithSpace(
      children: [
        _CompanyModeSelector(
          isNewMode: _isNewCompanyMode,
          onChanged: (isNew) => _changeCompanyMode(isNew: isNew),
        ),
        if (!_isNewCompanyMode)
          CustomDropdownFormField<MerchantCompanyDropdownModel>(
            hint: LocaleKeys.merchantApplication_selectCompany.tr(),
            onSelected: _onCompanySelected,
            items: companyItems,
            initialValue: _selectedCompany,
          ),
        LabeledProductTextField(
          controller: placeNameController,
          labelText: LocaleKeys.requestCompany_name.tr(),
          hintText: LocaleKeys.requestCompany_name.tr(),
          validator: ValidatorNormalTextField().validate,
        ),
        LabeledProductTextField(
          isMultiline: true,
          controller: placeDescriptionController,
          labelText: LocaleKeys.requestCompany_description.tr(),
          hintText: LocaleKeys.requestCompany_description.tr(),
          validator: ValidatorNormalTextField().validate,
        ),
        Padding(
          padding: const PagePadding.vertical12Symmetric(),
          child: Row(
            children: [
              Expanded(
                child: CustomDropdownFormField<RegionalCityModel>(
                  hint: '',
                  onSelected: _onCityChanged,
                  items: regionalCityModels,
                  initialValue: selectedRegionalCityModel,
                ),
              ),
              const EmptyBox.middleWidth(),
              Expanded(
                child: CustomDropdownFormField<RegionalTownSubItem>(
                  hint: '',
                  onSelected: _onTownChanged,
                  items: selectedRegionalTownModel.towns,
                  initialValue: selectedRegionalTownSubItem,
                ),
              ),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextFieldLabel(
              labelText: LocaleKeys.requestCompany_chooseCategory.tr(),
            ),
            context.sized.emptySizedHeightBoxLow,
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
        padding: const PagePadding.vertical8Symmetric(),
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
