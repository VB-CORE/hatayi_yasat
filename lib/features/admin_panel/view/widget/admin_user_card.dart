part of '../admin_users_tab.dart';

extension on AdminPermission {
  IconData get icon => switch (this) {
    AdminPermission.createIssue => AppIcons.createIssue,
    AdminPermission.createGroup => AppIcons.createGroup,
  };
}

@immutable
final class _AdminUserCard extends StatelessWidget {
  const _AdminUserCard({
    required this.user,
    required this.onTap,
    super.key,
  });

  final AppUser user;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.general.colorScheme;
    return ListTile(
      onTap: onTap,
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        backgroundColor: colorScheme.secondaryContainer,
        child: GeneralContentSmallTitle(
          value: user.displayName.initials(take: 1),
          color: colorScheme.onSecondaryContainer,
          fontWeight: FontWeight.w700,
        ),
      ),
      title: Row(
        children: [
          Flexible(
            child: Text(
              user.displayName,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (user.role == UserRole.merchant) ...[
            const EmptyBox.smallWidth(),
            const AdminVerifiedBadge(),
          ],
        ],
      ),
      subtitle: Text(
        user.email,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (final permission in AdminPermission.values) ...[
            Tooltip(
              message: permission.titleKey.tr(),
              child: Icon(
                permission.icon,
                color: permission.isEnabledFor(user)
                    ? colorScheme.primary
                    : colorScheme.outlineVariant,
              ),
            ),
            const EmptyBox.smallWidth(),
          ],
          const Icon(AppIcons.rightArrow),
        ],
      ),
    );
  }
}
