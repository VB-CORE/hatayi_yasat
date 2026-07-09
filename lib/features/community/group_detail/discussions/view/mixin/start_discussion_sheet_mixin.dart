import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifeclient/features/community/group_detail/discussions/provider/group_discussions_view_model.dart';
import 'package:lifeclient/features/community/group_detail/discussions/view/widget/start_discussion_sheet.dart';

mixin StartDiscussionSheetMixin on ConsumerState<StartDiscussionSheet> {
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
    titleController
      ..removeListener(_onFormFieldChanged)
      ..dispose();
    messageController
      ..removeListener(_onFormFieldChanged)
      ..dispose();
    super.dispose();
  }

  void _onFormFieldChanged() => setState(() {});

  void submit() {
    final isFormValid = formKey.currentState?.validate() ?? false;
    if (!isFormValid) return;

    final discussion = ref
        .read(groupDiscussionsViewModelProvider.notifier)
        .addDiscussion(
          titleController.text.trim(),
          messageController.text.trim(),
        );
    Navigator.of(context).pop(discussion);
  }
}
