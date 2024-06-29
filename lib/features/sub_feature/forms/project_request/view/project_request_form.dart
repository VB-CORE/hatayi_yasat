import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/features/sub_feature/forms/place_request/view/place_request_form.dart';
import 'package:lifeclient/features/sub_feature/forms/project_request/provider/project_request_provider.dart';
import 'package:lifeclient/features/sub_feature/forms/project_request/view/mixin/project_request_form_mixin.dart';
import 'package:lifeclient/features/sub_feature/forms/request_form.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/model/enum/text_field/index.dart';
import 'package:lifeclient/product/utility/decorations/empty_box.dart';
import 'package:lifeclient/product/utility/mixin/app_provider_mixin.dart';
import 'package:lifeclient/product/utility/validator/index.dart';
import 'package:lifeclient/product/widget/checkbox/kvkk_checkbox.dart';
import 'package:lifeclient/product/widget/general/dotted/index.dart';
import 'package:lifeclient/product/widget/general/dotted/state/general_dotted_photo_add_provider.dart';
import 'package:lifeclient/product/widget/general/index.dart';
import 'package:lifeclient/product/widget/list_view/list_view_with_space.dart';
import 'package:lifeclient/product/widget/text_field/date_time_form_field.dart';

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
        title: GeneralSubTitle(value: LocaleKeys.projectRequest_title.tr()),
        centerTitle: true,
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
          CustomTextFormFieldWithTitle(
            title: LocaleKeys.projectRequest_publisher.tr(),
            controller: projectPublisherController,
            validator: ValidatorNormalTextField(),
          ),
          CustomTextFormFieldWithTitle(
            title: LocaleKeys.requestCompany_phoneNumber.tr(),
            controller: projectPhoneController,
            textInputType: TextInputType.phone,
            formatters: TextFieldFormatters.phone,
            validator: ValidatorPhoneTextField(),
          ),
          GeneralDottedPhotoAddProvider(
            onSelected: onImageSelected,
            child: GeneralDottedPhotoAdd(
              title: LocaleKeys.projectRequest_projectImage.tr(),
            ),
          ),
          CustomTextFormFieldWithTitle(
            title: LocaleKeys.projectRequest_name.tr(),
            controller: projectNameController,
            textInputType: TextInputType.name,
            validator: ValidatorNormalTextField(),
          ),
          CustomTextFormFieldWithTitle.multiLine(
            title: LocaleKeys.projectRequest_topic.tr(),
            controller: projectTopicController,
            validator: ValidatorNormalTextField(),
          ),
          CustomTextFormFieldWithTitle.multiLine(
            title: LocaleKeys.projectRequest_description.tr(),
            controller: projectDescriptionController,
            validator: ValidatorNormalTextField(),
          ),
          DateTimeFormField(
            onDateSelected: (value) => updateSelectedDateTime(value: value),
          ),
          const EmptyBox.middleHeight(),
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
