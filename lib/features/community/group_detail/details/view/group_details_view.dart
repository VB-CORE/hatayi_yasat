import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/theme/app_colors.dart';
import 'package:lifeclient/features/community/group_detail/details/view/widget/group_admin_tile.dart';
import 'package:lifeclient/features/community/group_detail/details/view/widget/group_info_row.dart';
import 'package:lifeclient/features/community/model/group_member_model.dart';
import 'package:lifeclient/features/community/model/group_model.dart';
import 'package:lifeclient/features/community/model/group_type.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/utility/constants/app_icons.dart';
import 'package:lifeclient/product/utility/decorations/custom_radius.dart';
import 'package:lifeclient/product/utility/decorations/empty_box.dart';
import 'package:lifeclient/product/widget/dialog/general_icon_text_dialog.dart';
import 'package:lifeclient/product/widget/general/index.dart';

final class GroupDetailsView extends ConsumerWidget {
  const GroupDetailsView({required this.model, super.key});

  final GroupModel model;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView(
      padding: const PagePadding.horizontal16Symmetric(),
      children: [
        const EmptyBox.middleHeight(),
        _SectionLabel(
          value: LocaleKeys.community_groupDetail_details_aboutTitle.tr(),
        ),
        const EmptyBox.smallHeight(),
        _SectionCard(child: GeneralContentSubTitle(value: model.description)),
        const EmptyBox.middleHeight(),
        _SectionLabel(
          value: LocaleKeys.community_groupDetail_details_infoTitle.tr(),
        ),
        const EmptyBox.smallHeight(),
        _SectionCard(child: _InfoRows(model: model)),
        const EmptyBox.middleHeight(),
        _SectionLabel(
          value: LocaleKeys.community_groupDetail_details_adminsTitle.tr(),
        ),
        const EmptyBox.smallHeight(),
        _SectionCard(child: _AdminList(admins: model.admins)),
        const EmptyBox.largeHeight(),
        _LeaveGroupButton(onPressed: () => _showLeaveDialog(context)),
        if (model.isCurrentUserAdmin) ...[
          const EmptyBox.smallHeight(),
          _CloseGroupButton(onPressed: () => _showCloseGroupDialog(context)),
        ],
        const EmptyBox.largeHeight(),
      ],
    );
  }

  Future<void> _showLeaveDialog(BuildContext context) async {
    await GeneralIconTextDialog.show(
      context,
      const Icon(AppIcons.exitGroup),
      LocaleKeys.community_groupDetail_details_leaveConfirmTitle.tr(),
      LocaleKeys.community_groupDetail_details_leaveConfirmMessage.tr(),
      [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(
            LocaleKeys.community_groupDetail_details_leaveConfirmCancel.tr(),
          ),
        ),
        TextButton(
          style: TextButton.styleFrom(foregroundColor: AppColors.coral),
          // TODO(community): Firestore gruptan ayrılma isteği bağlanacak.
          onPressed: () {
            Navigator.of(context).pop();
            context.pop();
          },
          child: Text(
            LocaleKeys.community_groupDetail_details_leaveConfirmApprove.tr(),
          ),
        ),
      ],
    );
  }

  Future<void> _showCloseGroupDialog(BuildContext context) async {
    await GeneralIconTextDialog.show(
      context,
      const Icon(AppIcons.delete),
      LocaleKeys.community_groupDetail_details_closeGroupConfirmTitle.tr(),
      LocaleKeys.community_groupDetail_details_closeGroupConfirmMessage.tr(),
      [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(
            LocaleKeys.community_groupDetail_details_closeGroupConfirmCancel
                .tr(),
          ),
        ),
        TextButton(
          style: TextButton.styleFrom(foregroundColor: AppColors.coral),
          // TODO(community): Firestore'da grubun kapatılması/silinmesi
          // isteği bağlanacak.
          onPressed: () {
            Navigator.of(context).pop();
            context.pop();
          },
          child: Text(
            LocaleKeys.community_groupDetail_details_closeGroupConfirmApprove
                .tr(),
          ),
        ),
      ],
    );
  }
}

final class _SectionLabel extends StatelessWidget {
  const _SectionLabel({required this.value});

  final String value;

  @override
  Widget build(BuildContext context) {
    return GeneralContentSmallTitle(
      value: value,
      color: AppColors.navy300,
      fontWeight: FontWeight.w700,
    );
  }
}

final class _SectionCard extends StatelessWidget {
  const _SectionCard({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      shape: const RoundedRectangleBorder(borderRadius: CustomRadius.large),
      child: Padding(
        padding: const PagePadding.generalCardAll(),
        child: child,
      ),
    );
  }
}

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
            namedArgs: {'count': model.memberCount.toString()},
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

final class _AdminList extends StatelessWidget {
  const _AdminList({required this.admins});

  final List<GroupMemberModel> admins;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (final (index, admin) in admins.indexed) ...[
          if (index > 0) const EmptyBox.middleHeight(),
          GroupAdminTile(model: admin),
        ],
      ],
    );
  }
}

final class _LeaveGroupButton extends StatelessWidget {
  const _LeaveGroupButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.coral,
          side: const BorderSide(color: AppColors.coral),
          padding: const PagePadding.vertical12Symmetric(),
          shape: const RoundedRectangleBorder(
            borderRadius: CustomRadius.medium,
          ),
        ),
        icon: const Icon(AppIcons.exitGroup),
        label: Text(LocaleKeys.community_groupDetail_details_leaveGroup.tr()),
      ),
    );
  }
}

final class _CloseGroupButton extends StatelessWidget {
  const _CloseGroupButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.coral,
          foregroundColor: AppColors.white,
          padding: const PagePadding.vertical12Symmetric(),
          shape: const RoundedRectangleBorder(
            borderRadius: CustomRadius.medium,
          ),
        ),
        icon: const Icon(AppIcons.delete),
        label: Text(LocaleKeys.community_groupDetail_details_closeGroup.tr()),
      ),
    );
  }
}
