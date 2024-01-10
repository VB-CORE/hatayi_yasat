import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vbaseproject/features/sub_feature/forms/provider/project_request_provider.dart';
import 'package:vbaseproject/features/sub_feature/forms/view/mixin/project_request_form_mixin.dart';
import 'package:vbaseproject/features/sub_feature/forms/view/model/request_form.dart';
import 'package:vbaseproject/product/init/language/locale_keys.g.dart';
import 'package:vbaseproject/product/model/enum/text_field/text_field_formatters.dart';
import 'package:vbaseproject/product/utility/decorations/empty_box.dart';
import 'package:vbaseproject/product/utility/mixin/app_provider_mixin.dart';
import 'package:vbaseproject/product/utility/padding/page_padding.dart';
import 'package:vbaseproject/product/utility/validator/index.dart';
import 'package:vbaseproject/product/widget/general/dotted/general_dotted_photo_add.dart';
import 'package:vbaseproject/product/widget/general/general_button.dart';
import 'package:vbaseproject/product/widget/list_view/list_view_with_space.dart';
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
    return _RequestFormPage(
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
        DateTimeFormField(
          onDateSelected: updateProjectDate,
        ),
      ],
    );
  }
}

@immutable
final class _RequestFormPage extends StatelessWidget {
  const _RequestFormPage({
    required this.title,
    required this.onSendButtonTapped,
    required this.children,
    required this.sendButtonLabel,
  });

  final String title;
  final String sendButtonLabel;
  final AsyncCallback onSendButtonTapped;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(onPressed: () => context.pop()),
        title: Text(title),
      ),
      bottomNavigationBar: _RequestFormBottomButton(
        buttonTitle: sendButtonLabel,
        onTapped: onSendButtonTapped,
      ),
      body: ListViewWithSpace(
        children: children,
      ),
    );
  }
}

@immutable
final class _RequestFormBottomButton extends StatelessWidget {
  const _RequestFormBottomButton({
    required this.buttonTitle,
    required this.onTapped,
  });
  final String buttonTitle;
  final AsyncCallback onTapped;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const PagePadding.all(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GeneralButtonV2.async(
              action: onTapped,
              label: buttonTitle,
            ),
          ],
        ),
      ),
    );
  }
}
