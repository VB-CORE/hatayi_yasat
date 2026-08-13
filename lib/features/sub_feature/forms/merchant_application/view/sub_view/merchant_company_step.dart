part of '../merchant_application_view.dart';

final class _MerchantCompanyStep extends ConsumerStatefulWidget {
  const _MerchantCompanyStep({
    required this.formKey,
    required this.nameController,
    required this.descriptionController,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController descriptionController;

  @override
  ConsumerState<_MerchantCompanyStep> createState() =>
      _MerchantCompanyStepState();
}

final class _MerchantCompanyStepState
    extends ConsumerState<_MerchantCompanyStep>
    with
        AutomaticKeepAliveClientMixin<_MerchantCompanyStep>,
        AppProviderMixin<_MerchantCompanyStep> {
  @override
  bool get wantKeepAlive => true;

  MerchantApplicationViewModel get _viewModel =>
      ref.read(merchantApplicationViewModelProvider.notifier);

  Future<void> _openCompanySheet() async {
    final store = await MerchantCompanySheet.show(context);
    if (!mounted || store == null) return;
    _viewModel.selectCompany(store);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final state = ref.watch(merchantApplicationViewModelProvider);
    return Form(
      key: widget.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: ListViewWithSpace(
        children: [
          _CompanyModeSelector(
            isNewMode: state.isNewCompanyMode,
            onChanged: (isNew) => _viewModel.setCompanyMode(isNew: isNew),
          ),
          if (!state.isNewCompanyMode)
            _CompanySelectorField(
              selectedName: state.selectedCompany?.name,
              onTap: _openCompanySheet,
            ),
          LabeledProductTextField(
            controller: widget.nameController,
            readOnly:
                state.isCompanyLocked && widget.nameController.text.isNotEmpty,
            labelText: LocaleKeys.requestCompany_name.tr(),
            hintText: LocaleKeys.requestCompany_name.tr(),
            validator: ValidatorNormalTextField().validate,
          ),
          LabeledProductTextField(
            isMultiline: true,
            controller: widget.descriptionController,
            readOnly:
                state.isCompanyLocked &&
                widget.descriptionController.text.isNotEmpty,
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
                    enabled: !state.isCompanyLocked,
                    onSelected: _viewModel.selectCity,
                    items: productState.regionalCityItems,
                    initialValue: state.selectedCity,
                  ),
                ),
                const EmptyBox.middleWidth(),
                Expanded(
                  child: CustomDropdownFormField<RegionalTownSubItem>(
                    hint: '',
                    enabled: !state.isCompanyLocked,
                    onSelected: _viewModel.selectTown,
                    items: state.townItems,
                    initialValue: state.selectedTown,
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
                  for (final category in productState.categoryItems)
                    ActionChip(
                      onPressed:
                          (state.isCompanyLocked &&
                              state.selectedCompany?.category != null)
                          ? null
                          : () => _viewModel.selectCategory(category),
                      elevation: kZero,
                      pressElevation: kZero,
                      backgroundColor: state.selectedCategory == category
                          ? context.general.colorScheme.tertiary
                          : context.appColors.surface,
                      label: GeneralBodySmallTitle(
                        category.displayName,
                        fontWeight: FontWeight.w500,
                        color: state.selectedCategory == category
                            ? context.general.colorScheme.onTertiary
                            : context.general.colorScheme.primary,
                      ),
                    ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

final class _CompanySelectorField extends StatelessWidget {
  const _CompanySelectorField({
    required this.selectedName,
    required this.onTap,
  });

  final String? selectedName;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final name = selectedName;
    return InkWell(
      onTap: onTap,
      borderRadius: CustomRadius.medium,
      child: DecoratedBox(
        decoration: BoxDecorations.circularMedium(
          borderColor: context.general.colorScheme.onPrimaryContainer,
        ),
        child: Padding(
          padding: const PagePadding.generalAllNormal(),
          child: Row(
            children: [
              Expanded(
                child: GeneralBodySmallTitle(
                  name ?? LocaleKeys.merchantApplication_selectCompany.tr(),
                  fontWeight: FontWeight.w500,
                  color: name == null
                      ? context.general.colorScheme.onSurfaceVariant
                      : context.general.colorScheme.primary,
                ),
              ),
              const Icon(Icons.keyboard_arrow_down),
            ],
          ),
        ),
      ),
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
            label: LocaleKeys.merchantApplication_modeNew.tr(),
            isSelected: isNewMode,
            onTap: () => onChanged(true),
          ),
        ),
        const EmptyBox.smallWidth(),
        Expanded(
          child: _ModeChip(
            label: LocaleKeys.merchantApplication_modeExisting.tr(),
            isSelected: !isNewMode,
            onTap: () => onChanged(false),
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
          color: isSelected
              ? context.general.colorScheme.tertiary
              : context.appColors.surface,
          borderRadius: CustomRadius.medium,
          border: Border.all(
            color: isSelected
                ? context.general.colorScheme.tertiary
                : context.general.colorScheme.outline,
          ),
        ),
        child: Center(
          child: GeneralBodySmallTitle(
            label,
            fontWeight: FontWeight.w500,
            color: isSelected
                ? context.general.colorScheme.onTertiary
                : context.general.colorScheme.primary,
          ),
        ),
      ),
    );
  }
}
