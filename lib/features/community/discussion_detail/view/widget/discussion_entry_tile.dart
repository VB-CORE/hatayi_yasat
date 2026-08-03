import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/theme/app_context_colors.dart';
import 'package:lifeclient/features/community/discussion_detail/provider/discussion_detail_view_model.dart';
import 'package:lifeclient/features/community/group_detail/members/provider/group_members_view_model.dart';
import 'package:lifeclient/features/community/widget/community_delete_confirm_dialog.dart';
import 'package:lifeclient/features/community/widget/community_options_sheet.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/utility/constants/app_icons.dart';
import 'package:lifeclient/product/utility/decorations/custom_radius.dart';
import 'package:lifeclient/product/utility/decorations/empty_box.dart';
import 'package:lifeclient/product/utility/extension/date_time_extension.dart';
import 'package:lifeclient/product/widget/circle_avatar/custom_user_avatar.dart';
import 'package:lifeclient/product/widget/general/index.dart';

@immutable
final class DiscussionEntryTile extends StatelessWidget {
  const DiscussionEntryTile({
    required this.model,
    required this.groupId,
    required this.discussionId,
    super.key,
  });

  final GroupDiscussionEntryModel model;
  final String groupId;
  final String discussionId;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.general.colorScheme;
    return Card(
      margin: EdgeInsets.zero,
      shape: const RoundedRectangleBorder(borderRadius: CustomRadius.large),
      child: Padding(
        padding: const PagePadding.generalCardAll(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CustomUserAvatar(
                  userName: model.author.displayName,
                  backgroundColor: context.appColors.ink300,
                  singleLetter: true,
                ),
                const EmptyBox(width: WidgetSizes.spacingS),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          GeneralContentSubTitle(
                            value: model.author.maskedDisplayName,
                            fontWeight: FontWeight.w700,
                          ),
                          if (model.author.role == GroupMemberRole.admin) ...[
                            const EmptyBox.smallWidth(),
                            GeneralStatusBadge(
                              label: LocaleKeys.community_groupDetail_adminBadge
                                  .tr(),
                              color: colorScheme.tertiary,
                            ),
                          ],
                        ],
                      ),
                      GeneralContentSmallTitle(
                        value: model.createdAt.timeAgoOrNow,
                        color: context.appColors.navy300,
                      ),
                    ],
                  ),
                ),
                _EntryMoreButton(
                  model: model,
                  groupId: groupId,
                  discussionId: discussionId,
                ),
              ],
            ),
            const EmptyBox.smallHeight(),
            GeneralContentSubTitle(value: model.content),
          ],
        ),
      ),
    );
  }
}

final class _EntryMoreButton extends ConsumerWidget {
  const _EntryMoreButton({
    required this.model,
    required this.groupId,
    required this.discussionId,
  });

  final GroupDiscussionEntryModel model;
  final String groupId;
  final String discussionId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentMember = ref.watch(
      groupMembersViewModelProvider(groupId).select((s) => s.currentMember),
    );
    final canDelete = currentMember != null &&
        (model.author.uid == currentMember.uid || currentMember.isAdmin);
    if (!canDelete) return const SizedBox.shrink();

    return IconButton(
      icon: Icon(AppIcons.moreDots, color: context.appColors.navy300),
      onPressed: () => _onMorePressed(context, ref),
    );
  }

  Future<void> _onMorePressed(BuildContext context, WidgetRef ref) async {
    final action = await showModalBottomSheet<CommunityOptionAction>(
      context: context,
      builder: (_) => const CommunityOptionsSheet(),
    );
    if (action != CommunityOptionAction.delete || !context.mounted) return;

    final isConfirmed = await CommunityDeleteConfirmDialog.show(context);
    if (!isConfirmed) return;

    await ref
        .read(discussionDetailViewModelProvider(groupId, discussionId).notifier)
        .deleteEntry(model);
  }
}
