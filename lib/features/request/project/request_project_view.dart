import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:vbaseproject/features/request/project/mixin/request_project_mixin.dart';
import 'package:vbaseproject/features/request/project/request_project_state.dart';
import 'package:vbaseproject/features/request/project/viewmodel/request_project_view_model.dart';
import 'package:vbaseproject/product/init/language/locale_keys.g.dart';
import 'package:vbaseproject/product/utility/decorations/empty_box.dart';
import 'package:vbaseproject/product/utility/mixin/app_provider_mixin.dart';
import 'package:vbaseproject/product/utility/package/photo_picker/dotted_add_photo_button.dart';
import 'package:vbaseproject/product/utility/padding/page_padding.dart';
import 'package:vbaseproject/product/utility/validator/validator_text_field.dart';
import 'package:vbaseproject/product/widget/button/save_fab_button.dart';
import 'package:vbaseproject/product/widget/text_field/datetime_text_form_field.dart';
import 'package:vbaseproject/product/widget/text_field/phone_text_form_field.dart';
import 'package:vbaseproject/product/widget/text_field/validator_text_form_field.dart';

final StateNotifierProvider<RequestProjectViewModel, RequestProjectState>
    _requestProjectViewModel = StateNotifierProvider(
  (ref) => RequestProjectViewModel(),
);

class RequestProjectView extends ConsumerStatefulWidget {
  const RequestProjectView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _RequestProjectViewState();
}

class _RequestProjectViewState extends ConsumerState<RequestProjectView>
    with AppProviderMixin, RequestProjectMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(LocaleKeys.projectRequest_title).tr(),
      ),
      bottomNavigationBar: SaveButton(
        onPressed: () async {
          if (!isCheckValidation()) return;
          final response = await ref
              .read(_requestProjectViewModel.notifier)
              .addNewDataToService(model);
          await dataSendingComplete(isOkay: response);
        },
        isSendingRequestCheck:
            ref.watch(_requestProjectViewModel).isSendingRequest,
      ),
      body: WillPopScope(
        onWillPop: checkBackButton,
        child: Form(
          key: formKey,
          autovalidateMode: autoValidate(),
          child: SingleChildScrollView(
            padding: const PagePadding.horizontal16Symmetric() +
                const PagePadding.onlyBottom(),
            child: Column(
              children: [
                DottedAddPhotoButton(onSelected: onImageSelected),
                const EmptyBox.middleHeight(),
                ValidatorTextFormField(
                  controller: nameController,
                  labelText: LocaleKeys.projectRequest_name,
                  validator: ValidatorNormalTextField(),
                ),
                ValidatorTextFormField(
                  controller: topicController,
                  labelText: LocaleKeys.projectRequest_topic,
                  validator: ValidatorNormalTextField(),
                ),
                ValidatorTextFormField(
                  controller: descriptionController,
                  labelText: LocaleKeys.projectRequest_description,
                  validator: ValidatorNormalTextField(),
                  minLine: 3,
                ),
                ValidatorTextFormField(
                  controller: publisherController,
                  labelText: LocaleKeys.projectRequest_publisher,
                  validator: ValidatorNormalTextField(),
                ),
                PhoneTextFormField(
                  controller: phoneController,
                ),
                Padding(
                  padding: const PagePadding.onlyTop(),
                  child: ValueListenableBuilder<DateTime?>(
                    valueListenable: expireDateNotifier,
                    builder:
                        (BuildContext context, DateTime? value, Widget? child) {
                      return DateTimeTextFormField(
                        controller: startDateController,
                        startDate: value,
                        labelText: LocaleKeys.projectRequest_expireDate,
                        validator: TextFieldValidatorIsNullEmpty(),
                        onDateSelected: (value) {
                          updateSelectedDateTime(value: value);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ).ext.toDisabled(
          disable: ref.watch(_requestProjectViewModel).isSendingRequest,
          opacity: 0.5,
        );
  }
}
