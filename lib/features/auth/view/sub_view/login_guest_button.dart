part of '../login_view.dart';

final class _LoginGuestButton extends StatelessWidget {
  const _LoginGuestButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: onTap,
        child: Text(
          LocaleKeys.auth_signIn_guest.tr(),
          style: context.general.textTheme.titleSmall?.copyWith(
            decoration: TextDecoration.underline,
            color: context.general.colorScheme.primary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
