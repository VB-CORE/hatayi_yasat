import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:vbaseproject/features/request/scholarship/mixin/request_scholarship_mixin.dart';
import 'package:vbaseproject/product/common/color_common.dart';
import 'package:vbaseproject/product/init/language/locale_keys.g.dart';
import 'package:vbaseproject/product/utility/constants/app_constants.dart';
import 'package:vbaseproject/product/utility/decorations/empty_box.dart';
import 'package:vbaseproject/product/utility/mixin/app_provider_mixin.dart';
import 'package:vbaseproject/product/utility/package/file_picker/upload_file_section_widget.dart';
import 'package:vbaseproject/product/utility/padding/page_padding.dart';
import 'package:vbaseproject/product/utility/validator/validator_text_field.dart';
import 'package:vbaseproject/product/widget/button/save_fab_button.dart';
import 'package:vbaseproject/product/widget/checkbox/kvkk_checkbox.dart';
import 'package:vbaseproject/product/widget/text_field/index.dart';

class RequestScholarshipView extends ConsumerStatefulWidget {
  const RequestScholarshipView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _RequestScholarshipViewState();
}

class _RequestScholarshipViewState extends ConsumerState<RequestScholarshipView>
    with AppProviderMixin, RequestScholarshipMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(LocaleKeys.requestScholarship_title).tr(),
      ),
      bottomNavigationBar: _SaveButtonWithPolicyChecked(
        onPolicyChecked: changePolicyCheck,
        onSavePressed: uploadAndShowDialog,
        isLoading: isLoading,
        canApply: ref.read(requestProjectViewModel).canApply,
      ),
      body: WillPopScope(
        onWillPop: popScopeAction,
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Padding(
              padding: const PagePadding.generalAllNormal(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _TitleText(
                    title: LocaleKeys.requestScholarship_contact,
                  ),
                  const EmptyBox.smallHeight(),
                  ValidatorTextFormField(
                    labelText: LocaleKeys.requestScholarship_email,
                    validator: ValidatorEmailTextField(),
                    controller: emailController,
                  ),
                  const EmptyBox.smallHeight(),
                  PhoneTextFormField(controller: phoneNumberController),
                  const EmptyBox.largeHeight(),
                  const _TitleText(title: LocaleKeys.requestScholarship_story),
                  const EmptyBox.smallHeight(),
                  ValidatorTextFormField(
                    minLine: AppConstants.kTwo,
                    labelText: '',
                    validator: ValidatorNormalTextField(),
                    controller: storyController,
                  ),
                  const EmptyBox.middleHeight(),
                  const _TitleText(
                    title: LocaleKeys.requestScholarship_studentDocument,
                  ),
                  const EmptyBox.smallHeight(),
                  UploadFileSectionWidget(
                    hintText: LocaleKeys.requestScholarship_pdfHint,
                    onFilePicked: updatePDFFile,
                  ),
                  const EmptyBox.smallHeight(),
                ],
              ),
            ),
          ),
        ).ext.toDisabled(disable: !ref.read(requestProjectViewModel).canApply),
      ),
    );
  }
}

@immutable
final class _SaveButtonWithPolicyChecked extends StatelessWidget {
  const _SaveButtonWithPolicyChecked({
    required this.onPolicyChecked,
    required this.onSavePressed,
    required this.isLoading,
    required this.canApply,
  });

  final ValueSetter<bool> onPolicyChecked;
  final VoidCallback onSavePressed;
  final bool isLoading;
  final bool canApply;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const PagePadding.horizontal16Symmetric(),
          child: KvkkCheckBox(onChanged: onPolicyChecked),
        ).ext.toDisabled(disable: !canApply),
        SaveButton(
          onPressed: canApply ? onSavePressed : () {},
          isSendingRequestCheck: isLoading,
          title: canApply
              ? LocaleKeys.button_save
              : LocaleKeys.requestScholarship_disableButtonTitle,
        ),
      ],
    );
  }
}

class _TitleText extends StatelessWidget {
  const _TitleText({required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Text(
      title.tr(),
      style: context.general.textTheme.titleLarge?.copyWith(
        fontWeight: FontWeight.bold,
        color: ColorCommon(context).whiteAndBlackForTheme,
      ),
    );
  }
}
