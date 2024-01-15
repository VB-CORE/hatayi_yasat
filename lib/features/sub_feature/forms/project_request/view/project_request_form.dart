import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:vbaseproject/features/sub_feature/forms/project_request/provider/project_request_provider.dart';
import 'package:vbaseproject/features/sub_feature/forms/project_request/view/mixin/project_request_form_mixin.dart';
import 'package:vbaseproject/features/sub_feature/forms/request_form.dart';
import 'package:vbaseproject/product/init/language/locale_keys.g.dart';
import 'package:vbaseproject/product/model/enum/text_field/text_field_formatters.dart';
import 'package:vbaseproject/product/utility/decorations/empty_box.dart';
import 'package:vbaseproject/product/utility/mixin/app_provider_mixin.dart';
import 'package:vbaseproject/product/utility/padding/page_padding.dart';
import 'package:vbaseproject/product/utility/validator/index.dart';
import 'package:vbaseproject/product/widget/checkbox/kvkk_checkbox.dart';
import 'package:vbaseproject/product/widget/general/dotted/general_dotted_photo_add.dart';
import 'package:vbaseproject/product/widget/general/general_button.dart';
import 'package:vbaseproject/product/widget/list_view/list_view_with_space.dart';
import 'package:vbaseproject/product/widget/text_field/date_time_form_field.dart';
import 'package:vbaseproject/product/widget/text_field/index.dart';

part 'widget/project_request_send.dart';

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
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(onPressed: () => context.pop()),
        title: Text(
          LocaleKeys.projectRequest_title.tr(),
        ),
      ),
      bottomNavigationBar: _ProjectRequestSend(
        onTapped: () async {
          if (!validateAndSave()) return;
          final model = getRequestModel();
          if (model == null) return;
          final response = await ref
              .read(projectRequestProviderProvider.notifier)
              .addNewDataToService(model);
          await dataSendingComplete(isOkay: response);
        },
        onKVKKChanged: updateKVKK,
      ).ext.toDisabled(
            disable:
                ref.watch(projectRequestProviderProvider).isSendingRequest ??
                    false,
            opacity: 0.5,
          ),
      body: ListViewWithSpace(
        children: [
          GeneralDottedPhotoAdd(
            onSelected: onImageSelected,
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
          DateTimeFormField(
            onDateSelected: (value) {
              updateSelectedDateTime(value: value);
            },
          ),
        ],
      ).ext.toDisabled(
            disable:
                ref.watch(projectRequestProviderProvider).isSendingRequest ??
                    false,
            opacity: 0.5,
          ),
    );
  }
}
