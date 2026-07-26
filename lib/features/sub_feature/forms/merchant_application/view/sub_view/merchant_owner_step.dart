part of '../merchant_application_view.dart';

final class _MerchantOwnerStep extends ConsumerStatefulWidget {
  const _MerchantOwnerStep({
    required this.formKey,
    required this.nameController,
    required this.phoneController,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController phoneController;

  @override
  ConsumerState<_MerchantOwnerStep> createState() => _MerchantOwnerStepState();
}

final class _MerchantOwnerStepState extends ConsumerState<_MerchantOwnerStep>
    with
        AutomaticKeepAliveClientMixin<_MerchantOwnerStep>,
        AppProviderMixin<_MerchantOwnerStep> {
  @override
  bool get wantKeepAlive => true;

  MerchantApplicationViewModel get _viewModel =>
      ref.read(merchantApplicationViewModelProvider.notifier);

  bool _validateDocumentSize(File file) {
    if (_viewModel.isFileSizeValid(file)) return true;
    appProvider.showSnackbarMessage(
      LocaleKeys.requestScholarship_error_fileSizeError.tr(),
    );
    return false;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final isCommentEnabled = ref.watch(
      merchantApplicationViewModelProvider.select(
        (value) => value.isCommentEnabled,
      ),
    );
    final isLocked = ref.watch(
      merchantApplicationViewModelProvider.select(
        (value) => value.isCompanyLocked,
      ),
    );
    return Form(
      key: widget.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          Expanded(
            child: ListViewWithSpace(
              children: [
                LabeledProductTextField(
                  controller: widget.nameController,
                  readOnly: isLocked && widget.nameController.text.isNotEmpty,
                  labelText: LocaleKeys.requestCompany_ownerName.tr(),
                  hintText: LocaleKeys.requestCompany_ownerName.tr(),
                  validator: ValidatorNormalTextField().validate,
                ),
                Padding(
                  padding: const PagePadding.vertical12Symmetric(),
                  child: LabeledProductTextField(
                    controller: widget.phoneController,
                    readOnly:
                        isLocked && widget.phoneController.text.isNotEmpty,
                    keyboardType: TextInputType.phone,
                    labelText: LocaleKeys.requestCompany_phoneNumber.tr(),
                    hintText: LocaleKeys.requestCompany_phoneNumber.tr(),
                    validator: ValidatorPhoneTextField().validate,
                  ),
                ),
                UploadFileSection(
                  label: LocaleKeys.merchantApplication_documentLabel,
                  hintText: LocaleKeys.merchantApplication_documentHint,
                  fileValidator: _validateDocumentSize,
                  onFilePicked: _viewModel.setDocument,
                ),
                Row(
                  children: [
                    Expanded(
                      child: GeneralBodySmallTitle(
                        LocaleKeys.merchantApplication_commentToggle.tr(),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const EmptyBox.smallWidth(),
                    Switch(
                      value: isCommentEnabled,
                      onChanged: (value) =>
                          _viewModel.setCommentEnabled(value: value),
                      activeTrackColor: context.general.colorScheme.tertiary,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const PagePadding.horizontalSymmetric(),
            child: KvkkCheckBox(
              onChanged: (value) => _viewModel.setKvkkChecked(value: value),
            ),
          ),
        ],
      ),
    );
  }
}
