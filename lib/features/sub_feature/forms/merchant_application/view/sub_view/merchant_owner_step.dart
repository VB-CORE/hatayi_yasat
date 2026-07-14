part of '../merchant_application_view.dart';

final class _MerchantOwnerStep extends ConsumerStatefulWidget {
  const _MerchantOwnerStep({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MerchantOwnerStepState();
}

final class _MerchantOwnerStepState
    extends RequestFormConsumerState<_MerchantOwnerStep>
    with AppProviderMixin<_MerchantOwnerStep>, _MerchantOwnerStepMixin {
  @override
  Widget onBuild(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListViewWithSpace(
            children: [
              CustomTextFormFieldWithTitle(
                maxLength: TextFieldMaxLengths.large,
                title: LocaleKeys.requestCompany_ownerName.tr(),
                controller: placeOwnerNameController,
                validator: ValidatorNormalTextField(),
              ),
              CustomTextFormFieldWithTitle(
                controller: phoneNumberController,
                textInputType: TextInputType.phone,
                formatters: TextFieldFormatters.phone,
                validator: ValidatorPhoneTextField(),
                title: LocaleKeys.requestCompany_phoneNumber.tr(),
              ),
              Padding(
                padding: const PagePadding.vertical12Symmetric(),
                child: _PlacePickerFormField(
                  initialValue: _selectedLocation,
                  onChanged: updateSelectedLocation,
                  initialPosition: LatLng(
                    productState.selectedCity.location.latitude,
                    productState.selectedCity.location.longitude,
                  ),
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
            onChanged: (value) => updateKVKK(value: value),
          ),
        ),
      ],
    );
  }
}
