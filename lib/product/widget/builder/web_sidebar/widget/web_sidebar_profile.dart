part of '../web_sidebar.dart';

final class _WebSidebarProfile extends ConsumerWidget {
  const _WebSidebarProfile({
    required this.onProfileTap,
    required this.onLoginTap,
  });

  final VoidCallback onProfileTap;
  final VoidCallback onLoginTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authViewModelProvider).user;
    final colorScheme = context.general.colorScheme;

    if (user == null) {
      return Padding(
        padding: const PagePadding.generalAllNormal(),
        child: SizedBox(
          width: double.infinity,
          child: FilledButton.icon(
            onPressed: onLoginTap,
            icon: const HugeIcon(
              icon: HugeIcons.strokeRoundedLogin01,
              size: WidgetSizes.spacingMx,
            ),
            label: Text(LocaleKeys.button_login.tr()),
          ),
        ),
      );
    }

    return Padding(
      padding: const PagePadding.generalAllLow(),
      child: InkWell(
        onTap: onProfileTap,
        borderRadius: BorderRadius.circular(AppRadius.md),
        hoverColor: colorScheme.primary.withValues(alpha: .04),
        child: Padding(
          padding: const PagePadding.allLow(),
          child: Row(
            spacing: AppSpacing.sm,
            children: [
              CustomUserAvatar(
                userName: user.displayName,
                avatarType: user.avatarType,
                radius: WidgetSizes.spacingL,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: AppSpacing.xxs / 2,
                  children: [
                    Text(
                      user.displayName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppText.body.copyWith(
                        color: colorScheme.onSurface,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    if (user.email.isNotEmpty)
                      Text(
                        user.email,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppText.caption.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                  ],
                ),
              ),
              Icon(
                AppIcons.rightSelect,
                size: WidgetSizes.spacingL,
                color: colorScheme.onSurfaceVariant,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
