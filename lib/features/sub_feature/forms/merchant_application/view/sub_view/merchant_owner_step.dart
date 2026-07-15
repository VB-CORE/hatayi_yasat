part of '../merchant_application_view.dart';

final class _MerchantOwnerStep extends ConsumerStatefulWidget {
  const _MerchantOwnerStep({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MerchantOwnerStepState();
}

final class _MerchantOwnerStepState
    extends StepFormConsumerState<_MerchantOwnerStep>
    with AppProviderMixin<_MerchantOwnerStep>, _MerchantOwnerStepMixin {
  @override
  Widget onBuild(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListViewWithSpace(
            children: [
              LabeledProductTextField(
                controller: placeOwnerNameController,
                labelText: LocaleKeys.requestCompany_ownerName.tr(),
                hintText: LocaleKeys.requestCompany_ownerName.tr(),
                validator: ValidatorNormalTextField().validate,
              ),
              Padding(
                padding: const PagePadding.vertical12Symmetric(),
                child: LabeledProductTextField(
                  controller: phoneNumberController,
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
                onFilePicked: _onDocumentPicked,
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
                    value: _isCommentEnabled,
                    onChanged: _onCommentToggleChanged,
                    activeTrackColor: AppColors.coral,
                  ),
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: const PagePadding.horizontalSymmetric(),
          child: KvkkCheckBox(
            onChanged: (value) => isKVKKChecked = value,
          ),
        ),
      ],
    );
  }
}
