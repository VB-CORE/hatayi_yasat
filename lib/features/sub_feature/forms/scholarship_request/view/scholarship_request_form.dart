import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kartal/kartal.dart' show SizedBoxExtension, WidgetExtension;
import 'package:life_shared/life_shared.dart';
import 'package:vbaseproject/features/sub_feature/forms/request_form.dart';
import 'package:vbaseproject/features/sub_feature/forms/scholarship_request/provider/scholarship_request_provider.dart';
import 'package:vbaseproject/features/sub_feature/forms/scholarship_request/view/mixin/scholarship_request_form_mixin.dart';
import 'package:vbaseproject/product/init/language/locale_keys.g.dart';
import 'package:vbaseproject/product/model/enum/index.dart';
import 'package:vbaseproject/product/model/enum/text_field/text_field_formatters.dart';
import 'package:vbaseproject/product/package/file_picker/upload_file_section_v2.dart';
import 'package:vbaseproject/product/utility/constants/app_constants.dart';
import 'package:vbaseproject/product/utility/constants/app_icons.dart';
import 'package:vbaseproject/product/utility/mixin/app_provider_mixin.dart';
import 'package:vbaseproject/product/utility/padding/page_padding.dart';
import 'package:vbaseproject/product/utility/validator/index.dart';
import 'package:vbaseproject/product/widget/checkbox/kvkk_checkbox.dart';
import 'package:vbaseproject/product/widget/general/general_large_label.dart';
import 'package:vbaseproject/product/widget/general/index.dart';
import 'package:vbaseproject/product/widget/list_view/list_view_with_space.dart';
import 'package:vbaseproject/product/widget/text_field/index.dart';

part 'widget/scholarship_request_send.dart';
part 'widget/upload_size_info.dart';

final class ScholarshipRequestForm extends ConsumerStatefulWidget {
  const ScholarshipRequestForm({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ScholarshipRequestFormState();
}

final class _ScholarshipRequestFormState
    extends RequestFormConsumerState<ScholarshipRequestForm>
    with AppProviderMixin, ScholarshipRequestFormMixin {
  @override
  Widget onBuild(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(onPressed: () => context.pop()),
        title: Text(LocaleKeys.requestScholarship_title.tr()),
      ),
      bottomNavigationBar: _ScholarshipRequestSend(
        onTapped: () async {
          if (!validateAndSave()) return;
          final model = getRequestModel();
          if (model == null) return;

          await ref
              .read(scholarshipRequestProviderProvider.notifier)
              .uploadScholarship(model);
          await uploadAndShowDialog();
        },
        onKVKKChanged: updateKVKK,
        canApply:
            ref.read(scholarshipRequestProviderProvider).canApply ?? false,
      ).ext.toDisabled(
            disable: ref
                    .watch(scholarshipRequestProviderProvider)
                    .isSendingRequest ??
                false,
            opacity: 0.5,
          ),
      body: ListViewWithSpace(
        children: [
          CustomTextFormField(
            controller: phoneController,
            hint: LocaleKeys.requestScholarship_phone.tr(),
            validator: ValidatorPhoneTextField(),
            formatters: TextFieldFormatters.phone,
          ),
          CustomTextFormField(
            controller: emailController,
            hint: LocaleKeys.requestScholarship_email.tr(),
            validator: ValidatorEmailTextField(),
            maxLength: TextFieldMaxLengths.large,
          ),
          CustomTextFormMultiField(
            controller: bioController,
            hint: LocaleKeys.requestScholarship_story.tr(),
            validator: ValidatorNormalTextField(),
            maxLength: TextFieldMaxLengths.veryLarge,
          ),
          context.sized.emptySizedHeightBoxLow,
          GeneralContentTitle(
            value: LocaleKeys.requestScholarship_studentDocument.tr(),
          ),
          UploadFileSection(
            hintText: LocaleKeys.requestScholarship_pdfHint,
            onFilePicked: updatePdfFile,
          ),
          const _UploadSizeInfo(),
        ],
      ).ext.toDisabled(
            disable: ref
                    .watch(scholarshipRequestProviderProvider)
                    .isSendingRequest ??
                false,
            opacity: 0.5,
          ),
    );
  }
}
