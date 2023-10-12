import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:vbaseproject/features/request/scholarship/request_scholarship_state.dart';
import 'package:vbaseproject/features/request/scholarship/viewmodel/request_scholarship_view_model.dart';
import 'package:vbaseproject/product/init/language/locale_keys.g.dart';
import 'package:vbaseproject/product/utility/constants/app_constants.dart';
import 'package:vbaseproject/product/utility/decorations/empty_box.dart';
import 'package:vbaseproject/product/utility/mixin/app_provider_mixin.dart';
import 'package:vbaseproject/product/utility/padding/page_padding.dart';
import 'package:vbaseproject/product/utility/validator/validator_text_field.dart';
import 'package:vbaseproject/product/widget/button/save_fab_button.dart';
import 'package:vbaseproject/product/widget/checkbox/kvkk_checkbox.dart';
import 'package:vbaseproject/product/widget/text_field/index.dart';
import 'package:vbaseproject/product/widget/text_field/validator_text_form_field.dart';

final StateNotifierProvider<RequestScholarshipViewModel,
    RequestScholarshipState> _requestProjectViewModel = StateNotifierProvider(
  (ref) => RequestScholarshipViewModel(),
);

class RequestScholarshipView extends ConsumerStatefulWidget {
  const RequestScholarshipView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _RequestScholarshipViewState();
}

class _RequestScholarshipViewState extends ConsumerState<RequestScholarshipView>
    with AppProviderMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(LocaleKeys.request_scholarship_title).tr(),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const PagePadding.horizontal16Symmetric(),
            child: KvkkCheckBox(onChanged: (_) {}),
          ),
          SaveButton(
            onPressed: () {},
            isSendingRequestCheck: false,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
          child: Padding(
            padding: const PagePadding.generalAllNormal(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _TitleText(title: LocaleKeys.request_scholarship_contact),
                const EmptyBox.smallHeight(),
                ValidatorTextFormField(
                  labelText: 'Email',
                  validator: ValidatorNormalTextField(),
                  controller: TextEditingController(),
                ),
                const EmptyBox.smallHeight(),
                PhoneTextFormField(controller: TextEditingController()),
                const EmptyBox.largeHeight(),
                const _TitleText(title: LocaleKeys.request_scholarship_story),
                const EmptyBox.smallHeight(),
                ValidatorTextFormField(
                  labelText: '',
                  validator: ValidatorNormalTextField(),
                  controller: TextEditingController(),
                ),
                const EmptyBox.middleHeight(),
                const _TitleText(
                  title: LocaleKeys.request_scholarship_student_document,
                ),
                const EmptyBox.smallHeight(),
                const _UploadStudentDocumentSection(),
                const EmptyBox.smallHeight(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _UploadStudentDocumentSection extends StatefulWidget {
  const _UploadStudentDocumentSection();

  @override
  State<_UploadStudentDocumentSection> createState() =>
      _UploadStudentDocumentSectionState();
}

class _UploadStudentDocumentSectionState
    extends State<_UploadStudentDocumentSection> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const EmptyBox.smallWidth(),
        Expanded(
          child: Text(
            LocaleKeys.request_scholarship_pdf_hint.tr(),
            maxLines: AppConstants.kOne,
            overflow: TextOverflow.ellipsis,
            style: context.general.textTheme.titleMedium,
          ),
        ),
        const EmptyBox.smallWidth(),
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            shape: const RoundedRectangleBorder(),
          ),
          onPressed: () {},
          label: Text(
            LocaleKeys.request_scholarship_upload.tr(),
          ),
          icon: const Icon(
            Icons.upload_file,
            size: 24,
          ),
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
      style: context.general.textTheme.titleMedium?.copyWith(
        fontSize: 20,
      ),
    );
  }
}
