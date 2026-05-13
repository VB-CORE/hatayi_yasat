part of '../login_view.dart';

/// Stacked OAuth buttons (Google + Apple) followed by the underlined
/// "Misafir olarak devam et" link. FirebaseAuth is not wired yet — the
/// OAuth callbacks only show a "Yakında" SnackBar; only [onGuest]
/// completes the flow.
final class _LoginOAuthButtons extends StatelessWidget {
  const _LoginOAuthButtons({
    required this.onGoogle,
    required this.onApple,
    required this.onGuest,
  });

  final VoidCallback onGoogle;
  final VoidCallback onApple;
  final VoidCallback onGuest;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _OAuthButton(
          // Brand-locked white pill, navy text — matches OAuth chrome.
          background: ColorsCustom.white,
          foreground: ColorsCustom.navy,
          icon: const Icon(
            Icons.g_mobiledata_rounded,
            size: 22,
            color: ColorsCustom.navy,
          ),
          label: LocaleKeys.auth_signInGoogle.tr(),
          onTap: onGoogle,
          semanticKey: 'loginGoogleButton',
        ),
        const EmptyBox(height: 10),
        _OAuthButton(
          // Brand-locked black pill, white text — Apple sign-in chrome.
          background: ColorsCustom.black,
          foreground: ColorsCustom.white,
          icon: const Icon(
            Icons.apple,
            size: 18,
            color: ColorsCustom.white,
          ),
          label: LocaleKeys.auth_signInApple.tr(),
          onTap: onApple,
          semanticKey: 'loginAppleButton',
        ),
        const EmptyBox(height: 6),
        TextButton(
          key: const Key('loginGuestButton'),
          onPressed: onGuest,
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 13),
            foregroundColor: ColorsCustom.white,
          ),
          child: Text(
            LocaleKeys.auth_continueAsGuest.tr(),
            style: context.general.textTheme.bodyMedium?.copyWith(
              fontSize: 13.5,
              fontWeight: FontWeight.w600,
              decoration: TextDecoration.underline,
              // Brand-locked white@85 link on navy hero.
              color: ColorsCustom.white.withValues(alpha: 0.85),
              decorationColor: ColorsCustom.white.withValues(alpha: 0.85),
            ),
          ),
        ),
      ],
    );
  }
}

final class _OAuthButton extends StatelessWidget {
  const _OAuthButton({
    required this.background,
    required this.foreground,
    required this.icon,
    required this.label,
    required this.onTap,
    required this.semanticKey,
  });

  final Color background;
  final Color foreground;
  final Widget icon;
  final String label;
  final VoidCallback onTap;
  final String semanticKey;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ElevatedButton(
        key: Key(semanticKey),
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: background,
          foregroundColor: foreground,
          elevation: 0,
          shape: const RoundedRectangleBorder(
            borderRadius: CustomRadius.medium,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            const EmptyBox(width: 10),
            Text(
              label,
              style: V2Typography.label(
                fontSize: 14.5,
                color: foreground,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
