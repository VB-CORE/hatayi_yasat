import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vbaseproject/features/v2/sub_feature/forms/provider/project_request_provider.dart';
import 'package:vbaseproject/features/v2/sub_feature/forms/view/mixin/project_request_form_mixin.dart';
import 'package:vbaseproject/features/v2/sub_feature/forms/view/model/request_form.dart';
import 'package:vbaseproject/product/init/language/locale_keys.g.dart';
import 'package:vbaseproject/product/model/enum/text_field/text_field_formatters.dart';
import 'package:vbaseproject/product/utility/decorations/empty_box.dart';
import 'package:vbaseproject/product/utility/mixin/app_provider_mixin.dart';
import 'package:vbaseproject/product/utility/padding/page_padding.dart';
import 'package:vbaseproject/product/utility/validator/index.dart';
import 'package:vbaseproject/product/widget/general/dotted/general_dotted_photo_add.dart';
import 'package:vbaseproject/product/widget/general/general_button.dart';
import 'package:vbaseproject/product/widget/page/request_form_page.dart';
import 'package:vbaseproject/product/widget/text_field/date_time_form_field.dart';
import 'package:vbaseproject/product/widget/text_field/index.dart';

part './widget/project_request_send.dart';

final class ProjectRequestForm extends ConsumerStatefulWidget {
  const ProjectRequestForm({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ProjectRequestFormState();
}

final class _ProjectRequestFormState
    extends RequestFormConsumerState<ProjectRequestForm>
    with AppProviderMixin, ProjectRequestFormMixin {
  @override
  Widget onBuild(BuildContext context) {
    return RequestFormPage(
      title: LocaleKeys.projectRequest_title.tr(),
      sendButtonLabel: LocaleKeys.button_save.tr(),
      onSendButtonTapped: () async {
        await Future<void>.delayed(const Duration(seconds: 2), () {});
        if (!validateAndSave()) return;
        final model = getRequestModel();
        if (model == null) return;
        ref
            .read(projectRequestProviderProvider.notifier)
            .updateRequestModel(model);
      },
      children: [
        GeneralDottedPhotoAdd(
          onSelected: updateProjectImage,
        ),
        CustomTextFormMultiField(
          hint: LocaleKeys.projectRequest_name.tr(),
          controller: projectNameController,
          validator: ValidatorNormalTextField(),
        ),
        CustomTextFormMultiField(
          hint: LocaleKeys.projectRequest_topic.tr(),
          controller: projectTopicController,
          validator: ValidatorNormalTextField(),
        ),
        CustomTextFormMultiField(
          hint: LocaleKeys.projectRequest_description.tr(),
          controller: projectDescriptionController,
          validator: ValidatorNormalTextField(),
        ),
        CustomTextFormMultiField(
          hint: LocaleKeys.projectRequest_publisher.tr(),
          controller: projectPublisherController,
          validator: ValidatorNormalTextField(),
        ),
        CustomTextFormField(
          hint: LocaleKeys.requestCompany_phoneNumber.tr(),
          controller: projectPhoneController,
          textInputType: TextInputType.phone,
          formatters: TextFieldFormatters.phone,
          validator: ValidatorPhoneTextField(),
        ),
        const EmptyBox.middleHeight(),
        DateTimeFormFieldV2(
          onDateSelected: updateProjectDate,
        ),
      ],
    );
  }
}
