import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifeclient/features/community/discussion_detail/provider/discussion_detail_view_model.dart';
import 'package:lifeclient/features/community/discussion_detail/view/discussion_detail_view.dart';
import 'package:lifeclient/product/utility/mixin/app_provider_mixin.dart';

mixin DiscussionDetailViewMixin
    on
        ConsumerState<DiscussionDetailView>,
        AppProviderMixin<DiscussionDetailView> {
  final TextEditingController replyController = TextEditingController();
  final ScrollController entriesScrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref
          .read(discussionDetailViewModelProvider.notifier)
          .fetchEntries(widget.args.discussion);
    });
  }

  @override
  void dispose() {
    replyController.dispose();
    entriesScrollController.dispose();
    super.dispose();
  }

  void submitReply() {
    final content = replyController.text.trim();
    if (content.isEmpty) return;
    ref.read(discussionDetailViewModelProvider.notifier).addEntry(content);
    replyController.clear();
    _scrollToLatestEntry();
  }

  /// Yeni gönderi listeye eklendikten (frame çizildikten) sonra en alta
  /// kaydırır.
  void _scrollToLatestEntry() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!entriesScrollController.hasClients) return;
      entriesScrollController.animateTo(
        entriesScrollController.position.maxScrollExtent,
        duration: Durations.medium2,
        curve: Curves.easeOut,
      );
    });
  }
}
