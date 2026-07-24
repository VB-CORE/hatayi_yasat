import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifeclient/features/community/group_detail/discussions/provider/group_discussions_view_model.dart';
import 'package:lifeclient/features/community/group_detail/discussions/view/widget/start_discussion_sheet.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/utility/mixin/app_provider_mixin.dart';

mixin StartDiscussionSheetMixin
    on
        ConsumerState<StartDiscussionSheet>,
        AppProviderMixin<StartDiscussionSheet> {
  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final messageController = TextEditingController();

  bool get canSubmit =>
      titleController.text.trim().isNotEmpty &&
      messageController.text.trim().isNotEmpty;

  @override
  void initState() {
    super.initState();
    titleController.addListener(_onFormFieldChanged);
    messageController.addListener(_onFormFieldChanged);
  }

  @override
  void dispose() {
    titleController.dispose();
    messageController.dispose();
    super.dispose();
  }

  void _onFormFieldChanged() => setState(() {});

  Future<void> submit() async {
    final isFormValid = formKey.currentState?.validate() ?? false;
    if (!isFormValid) return;

    final discussion = await ref
        .read(groupDiscussionsViewModelProvider.notifier)
        .addDiscussion(
          widget.groupId,
          titleController.text.trim(),
          messageController.text.trim(),
        );
    if (!mounted) return;
    if (discussion == null) {
      appProvider.showSnackbarMessage(
        LocaleKeys.message_somethingWentWrong.tr(),
      );
      return;
    }
    Navigator.of(context).pop(discussion);
  }
}
