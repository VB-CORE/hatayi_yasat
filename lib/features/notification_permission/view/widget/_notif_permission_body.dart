part of '../notification_permission_view.dart';

/// Bottom body of the notification permission screen — eyebrow,
/// display heading, body copy, primary CTA (request permission) and
/// secondary skip button.
final class _NotifPermissionBody extends StatelessWidget {
  const _NotifPermissionBody({
    required this.requesting,
    required this.onAllow,
    required this.onSkip,
  });

  final bool requesting;
  final VoidCallback onAllow;
  final VoidCallback onSkip;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.general.colorScheme;
    final textTheme = context.general.textTheme;
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 28, 24, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Eyebrow(LocaleKeys.auth_notifPermissionStep.tr()),
          const EmptyBox(height: 8),
          Text(
            LocaleKeys.auth_notifPermissionTitle.tr(),
            style: V2Typography.display(
              fontSize: 28,
              color: colorScheme.onSurface,
            ),
          ),
          const EmptyBox(height: 14),
          Text(
            LocaleKeys.auth_notifPermissionBody.tr(),
            style: textTheme.bodyMedium?.copyWith(
              fontSize: 13.5,
              height: 1.6,
              color: colorScheme.onPrimaryFixedVariant,
            ),
          ),
          const Spacer(),
          SizedBox(
            height: 50,
            child: ElevatedButton(
              key: const Key('notifPermissionAllowButton'),
              onPressed: requesting ? null : onAllow,
              style: ElevatedButton.styleFrom(
                backgroundColor: colorScheme.error,
                foregroundColor: colorScheme.onPrimary,
                elevation: 0,
                shape: const RoundedRectangleBorder(
                  borderRadius: CustomRadius.medium,
                ),
              ),
              child: requesting
                  ? SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation(
                          colorScheme.onPrimary,
                        ),
                      ),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.notifications_active_rounded,
                          size: 18,
                          color: colorScheme.onPrimary,
                        ),
                        const EmptyBox(width: 8),
                        Text(
                          LocaleKeys.auth_notifPermissionAllow.tr(),
                          style: V2Typography.label(
                            fontSize: 14.5,
                            color: colorScheme.onPrimary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
            ),
          ),
          const EmptyBox(height: 4),
          TextButton(
            key: const Key('notifPermissionSkipButton'),
            onPressed: requesting ? null : onSkip,
            style: TextButton.styleFrom(
              foregroundColor: colorScheme.onSecondaryFixed,
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
            child: Text(
              LocaleKeys.auth_notifPermissionSkip.tr(),
              style: textTheme.bodyMedium?.copyWith(
                fontSize: 13.5,
                fontWeight: FontWeight.w600,
                color: colorScheme.onSecondaryFixed,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
