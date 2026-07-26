part of '../group_details_view.dart';

final class _InfoRows extends ConsumerWidget {
  const _InfoRows({required this.model});

  final GroupModel model;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final memberCount = ref.watch(
      groupDetailViewModelProvider(
        model.id,
      ).select((state) => state.group?.memberCount ?? model.memberCount),
    );
    final createdAt = model.createdAt;
    final dividerColor = context.general.colorScheme.outline;
    return Column(
      children: [
        GroupInfoRow(
          icon: model.type.icon,
          label: LocaleKeys.community_groupDetail_details_groupTypeLabel.tr(),
          value: model.type.label,
        ),
        if (model.categoryName.isNotEmpty) ...[
          Divider(color: dividerColor),
          GroupInfoRow(
            icon: AppIcons.gridView,
            label: LocaleKeys.community_groupDetail_details_categoryLabel.tr(),
            value: model.categoryName,
          ),
        ],
        Divider(color: dividerColor),
        GroupInfoRow(
          icon: AppIcons.group,
          label: LocaleKeys.community_groupDetail_details_memberCountLabel.tr(),
          value: LocaleKeys.community_groupDetail_memberCount.tr(
            args: [memberCount.toString()],
          ),
        ),
        if (createdAt != null) ...[
          Divider(color: dividerColor),
          GroupInfoRow(
            icon: AppIcons.calendar,
            label: LocaleKeys.community_groupDetail_details_createdAtLabel.tr(),
            value: createdAt.shortDate,
          ),
        ],
      ],
    );
  }
}
