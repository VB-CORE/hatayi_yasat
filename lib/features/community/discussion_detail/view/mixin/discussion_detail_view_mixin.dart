import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifeclient/features/community/discussion_detail/provider/discussion_detail_state.dart';
import 'package:lifeclient/features/community/discussion_detail/provider/discussion_detail_view_model.dart';
import 'package:lifeclient/features/community/discussion_detail/view/discussion_detail_view.dart';
import 'package:lifeclient/features/community/widget/content_action_result_handler.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/utility/extension/string_extension.dart';
import 'package:lifeclient/product/utility/mixin/app_provider_mixin.dart';

mixin DiscussionDetailViewMixin
    on
        ConsumerState<DiscussionDetailView>,
        AppProviderMixin<DiscussionDetailView> {
  final TextEditingController replyController = TextEditingController();
  final ScrollController entriesScrollController = ScrollController();

  DiscussionDetailViewModelProvider get entriesNotifier =>
      discussionDetailViewModelProvider(
        widget.args.group.id,
        widget.args.discussion.id,
      );

  @override
  void initState() {
    super.initState();
    ref.listenManual(entriesNotifier, _onEntryActionResult);
  }

  void _onEntryActionResult(
    DiscussionDetailState? previous,
    DiscussionDetailState next,
  ) {
    final notifier = ref.read(entriesNotifier.notifier);
    unawaited(
      handleContentActionStatus(
        context,
        status: next.status,
        showSnackbar: appProvider.showSnackbarMessage,
        resetStatus: notifier.resetStatus,
      ),
    );
  }

  @override
  void dispose() {
    replyController.dispose();
    entriesScrollController.dispose();
    super.dispose();
  }

  Future<void> submitReply() async {
    final content = replyController.text.normalize;
    if (content.isEmpty) return;

    final isAdded = await ref.read(entriesNotifier.notifier).addEntry(content);
    if (!mounted) return;

    if (!isAdded) {
      appProvider.showSnackbarMessage(
        LocaleKeys.message_somethingWentWrong.tr(),
      );
      return;
    }
    replyController.clear();
    _scrollToLatestEntry();
  }

  void _scrollToLatestEntry() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!entriesScrollController.hasClients) return;
      unawaited(
        entriesScrollController.animateTo(
          entriesScrollController.position.maxScrollExtent,
          duration: Durations.medium2,
          curve: Curves.easeOut,
        ),
      );
    });
  }
}
