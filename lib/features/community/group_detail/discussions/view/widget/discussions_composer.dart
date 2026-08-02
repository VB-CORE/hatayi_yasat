import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/features/community/group_detail/discussions/view/widget/start_discussion_card.dart';
import 'package:lifeclient/features/community/group_detail/discussions/view/widget/start_discussion_sheet.dart';
import 'package:lifeclient/features/community/group_detail/members/provider/group_members_view_model.dart';
import 'package:lifeclient/product/utility/decorations/empty_box.dart';

final class DiscussionsComposer extends ConsumerWidget {
  const DiscussionsComposer({
    required this.groupId,
    required this.onStarted,
    super.key,
  });

  final String groupId;
  final ValueChanged<GroupDiscussionModel> onStarted;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isAdmin = ref.watch(
      groupMembersViewModelProvider(groupId).select((state) => state.isAdmin),
    );
    if (!isAdmin) return const EmptyBox.middleHeight();

    return Padding(
      padding: const PagePadding.horizontal16Symmetric(),
      child: Column(
        children: [
          const EmptyBox.middleHeight(),
          StartDiscussionCard(onTap: () => _openSheet(context)),
          const EmptyBox.middleHeight(),
        ],
      ),
    );
  }

  Future<void> _openSheet(BuildContext context) async {
    final discussion = await StartDiscussionSheet.show(
      context,
      groupId: groupId,
    );
    if (discussion == null || !context.mounted) return;
    onStarted(discussion);
  }
}
