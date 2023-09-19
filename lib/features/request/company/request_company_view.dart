import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:vbaseproject/features/request/company/mixin/request_company_mixin.dart';
import 'package:vbaseproject/features/request/company/request_company_view_model.dart';
import 'package:vbaseproject/features/request/company/request_state.dart';
import 'package:vbaseproject/product/init/language/locale_keys.g.dart';
import 'package:vbaseproject/product/utility/dropdown/district_drop_down.dart';
import 'package:vbaseproject/product/utility/mixin/app_provider_mixin.dart';
import 'package:vbaseproject/product/utility/padding/page_padding.dart';
import 'package:vbaseproject/product/utility/size/index.dart';
import 'package:vbaseproject/product/utility/state/app_provider.dart';
import 'package:vbaseproject/product/utility/validator/validator_text_field.dart';
import 'package:vbaseproject/product/widget/checkbox/kvkk_checkbox.dart';
import 'package:vbaseproject/product/widget/package/photo_picker/dotted_add_photo_button.dart';
import 'package:vbaseproject/product/widget/text_field/phone_text_form_field.dart';
import 'package:vbaseproject/product/widget/text_field/validator_text_form_field.dart';

final StateNotifierProvider<RequestCompanyViewModel, RequestCompanyState>
    _requestCompanyViewModel = StateNotifierProvider(
  (ref) => RequestCompanyViewModel(
    ref.read(AppProvider.provider).deviceID ?? '',
  ),
);

class RequestCompanyView extends ConsumerStatefulWidget {
  const RequestCompanyView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _RequestCompanyViewState();
}

class _RequestCompanyViewState extends ConsumerState<RequestCompanyView>
    with AppProviderMixin, RequestCompanyMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _SaveButton(
        () async {
          if (!isCheckValidation()) return;
          final response = await ref
              .read(_requestCompanyViewModel.notifier)
              .addNewDataToService(model);
          await dataSendingComplete(isOkay: response);
        },
      ),
      appBar: AppBar(
        title: const Text(LocaleKeys.requestCompany_title).tr(),
      ),
      body: WillPopScope(
        onWillPop: checkBackButton,
        child: Form(
          key: formKey,
          autovalidateMode: autoValidate(),
          child: Padding(
            padding: const PagePadding.horizontal16Symmetric() +
                const PagePadding.onlyBottom(),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  DottedAddPhotoButton(
                    onSelected: onImageSelected,
                  ),
                  const _EmptyBox(),
                  ValidatorTextFormField(
                    controller: companyNameController,
                    labelText: LocaleKeys.requestCompany_name.tr(),
                    validator: ValidatorNormalTextField(),
                  ),
                  ValidatorTextFormField(
                    controller: companyDescriptionController,
                    labelText: LocaleKeys.requestCompany_description.tr(),
                    validator: ValidatorNormalTextField(),
                    minLine: 3,
                  ),
                  ValidatorTextFormField(
                    controller: nameSurnameController,
                    labelText: LocaleKeys.requestCompany_ownerName.tr(),
                    validator: ValidatorNormalTextField(),
                  ),
                  ValidatorTextFormField(
                    controller: addressController,
                    labelText: LocaleKeys.validation_address.tr(),
                    validator: ValidatorNormalTextField(),
                    minLine: 3,
                  ),
                  PhoneTextFormField(
                    controller: phoneController,
                  ),
                  DistrictDropDownView(
                    onSelected: onTownSelected,
                  ),
                  KvkkCheckBox(
                    onChanged: (value) {
                      onKvkkSelected(value: value);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ).ext.toDisabled(
          disable:
              ref.watch(_requestCompanyViewModel).isSendingRequest ?? false,
          opacity: 0.5,
        );
  }
}

class _EmptyBox extends StatelessWidget {
  const _EmptyBox();

  @override
  Widget build(BuildContext context) {
    return const SizedBox(height: WidgetSizes.spacingM);
  }
}

class _SaveButton extends ConsumerWidget {
  const _SaveButton(this.onPressed);
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading =
        ref.watch(_requestCompanyViewModel).isSendingRequest ?? false;
    return SafeArea(
      child: Padding(
        padding: const PagePadding.horizontal16Symmetric() +
            const PagePadding.onlyBottomMedium(),
        child: FloatingActionButton(
          onPressed: () {
            if (isLoading) return;
            onPressed();
          },
          child: isLoading
              ? const CircularProgressIndicator()
              : const Text(LocaleKeys.button_save).tr(),
        ),
      ),
    );
  }
}
