import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/features/community/group_detail/members/provider/group_members_view_model.dart';
import 'package:lifeclient/features/community/provider/soft_deletable_mixin.dart';
import 'package:lifeclient/features/community/widget/community_delete_confirm_dialog.dart';
import 'package:lifeclient/product/utility/constants/app_icons.dart';
import 'package:lifeclient/product/utility/decorations/custom_radius.dart';

final class DismissibleContentCard extends ConsumerWidget {
  const DismissibleContentCard({
    required this.contentId,
    required this.groupId,
    required this.authorUid,
    required this.onDelete,
    required this.child,
    super.key,
  });

  final String contentId;
  final String groupId;
  final String authorUid;
  final Future<void> Function(WidgetRef ref) onDelete;
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentMember = ref.watch(
      groupMembersViewModelProvider(groupId).select((s) => s.currentMember),
    );
    final canDelete = canDeleteContent(
      authorUid: authorUid,
      currentMember: currentMember,
    );
    if (!canDelete) return child;

    return Dismissible(
      key: ValueKey(contentId),
      direction: DismissDirection.endToStart,
      background: const _DeleteBackground(),
      confirmDismiss: (_) async {
        final isConfirmed = await CommunityDeleteConfirmDialog.show(context);
        if (!isConfirmed) return false;
        await onDelete(ref);
        return true;
      },
      child: child,
    );
  }
}

final class _DeleteBackground extends StatelessWidget {
  const _DeleteBackground();

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      padding: const PagePadding.horizontal16Symmetric(),
      decoration: BoxDecoration(
        color: context.general.colorScheme.error,
        borderRadius: CustomRadius.large,
      ),
      child: Icon(
        AppIcons.delete,
        color: context.general.colorScheme.onError,
      ),
    );
  }
}
