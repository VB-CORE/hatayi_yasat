part of '../login_view.dart';

final class _LoginLegalText extends StatelessWidget {
  const _LoginLegalText();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () => unawaited(KvkkCheckBox.navigate(context)),
        child: Text(
          LocaleKeys.auth_legal.tr(),
          textAlign: TextAlign.center,
          style: context.general.textTheme.bodySmall?.copyWith(
            color: context.general.colorScheme.onSurfaceVariant,
            decoration: TextDecoration.underline,
          ),
        ),
      ),
    );
  }
}
