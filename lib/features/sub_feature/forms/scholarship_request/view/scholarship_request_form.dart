import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart' show WidgetExtension;
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/features/sub_feature/forms/place_request/view/place_request_form.dart';
import 'package:lifeclient/features/sub_feature/forms/request_form.dart';
import 'package:lifeclient/features/sub_feature/forms/scholarship_request/provider/scholarship_request_provider.dart';
import 'package:lifeclient/features/sub_feature/forms/scholarship_request/view/mixin/scholarship_request_form_mixin.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/model/enum/text_field/index.dart';
import 'package:lifeclient/product/package/file_picker/upload_file_section_v2.dart';
import 'package:lifeclient/product/utility/constants/app_constants.dart';
import 'package:lifeclient/product/utility/constants/app_icons.dart';
import 'package:lifeclient/product/utility/mixin/app_provider_mixin.dart';
import 'package:lifeclient/product/utility/validator/index.dart';
import 'package:lifeclient/product/widget/checkbox/kvkk_checkbox.dart';
import 'package:lifeclient/product/widget/general/index.dart';
import 'package:lifeclient/product/widget/list_view/list_view_with_space.dart';

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
        title: GeneralSubTitle(value: LocaleKeys.requestScholarship_title.tr()),
        centerTitle: true,
      ),
      bottomNavigationBar: _ScholarshipRequestSend(
        onTapped: () async {
          if (!validateAndSave()) return;
          final model = getRequestModel();
          if (model == null) return;

          final response = await ref
              .read(scholarshipRequestProviderProvider.notifier)
              .uploadScholarship(model);
          if (response == null) {
            await uploadAndShowDialog();
            return;
          }
          await showErrorSnackbar(title: response);
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
          CustomTextFormFieldWithTitle(
            controller: phoneController,
            title: LocaleKeys.requestScholarship_phone.tr(),
            validator: ValidatorPhoneTextField(),
            formatters: TextFieldFormatters.phone,
          ),
          CustomTextFormFieldWithTitle(
            controller: emailController,
            title: LocaleKeys.requestScholarship_email.tr(),
            validator: ValidatorEmailTextField(),
            maxLength: TextFieldMaxLengths.large,
          ),
          CustomTextFormFieldWithTitle.multiLine(
            controller: bioController,
            title: LocaleKeys.requestScholarship_story.tr(),
            validator: ValidatorNormalTextField(),
            maxLength: TextFieldMaxLengths.veryLarge,
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
