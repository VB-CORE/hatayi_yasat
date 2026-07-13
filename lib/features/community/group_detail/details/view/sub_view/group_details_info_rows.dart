part of '../group_details_view.dart';

final class _InfoRows extends StatelessWidget {
  const _InfoRows({required this.model});

  final GroupModel model;

  @override
  Widget build(BuildContext context) {
    final createdAt = model.createdAt;
    return Column(
      children: [
        GroupInfoRow(
          icon: model.type == GroupType.open
              ? AppIcons.globe
              : AppIcons.lockPerson,
          label: LocaleKeys.community_groupDetail_details_groupTypeLabel.tr(),
          value: model.type == GroupType.open
              ? LocaleKeys.community_groupDetail_details_groupTypeOpen.tr()
              : LocaleKeys.community_groupDetail_details_groupTypeClosed.tr(),
        ),
        const Divider(color: AppColors.ink100),
        GroupInfoRow(
          icon: AppIcons.group,
          label: LocaleKeys.community_groupDetail_details_memberCountLabel.tr(),
          value: LocaleKeys.community_groupDetail_memberCount.tr(
            args: [model.memberCount.toString()],
          ),
        ),
        if (createdAt != null) ...[
          const Divider(color: AppColors.ink100),
          GroupInfoRow(
            icon: AppIcons.calendar,
            label: LocaleKeys.community_groupDetail_details_createdAtLabel.tr(),
            value: DateFormat('d MMM y').format(createdAt),
          ),
        ],
      ],
    );
  }
}
