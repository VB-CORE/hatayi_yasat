part of '../login_view.dart';

final class _LoginLegalText extends StatefulWidget {
  const _LoginLegalText();

  @override
  State<_LoginLegalText> createState() => _LoginLegalTextState();
}

final class _LoginLegalTextState extends State<_LoginLegalText> {
  late final TapGestureRecognizer _kvkkRecognizer;

  @override
  void initState() {
    super.initState();
    _kvkkRecognizer = TapGestureRecognizer()
      ..onTap = () => unawaited(KvkkCheckBox.navigate(context));
  }

  @override
  void dispose() {
    _kvkkRecognizer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final baseStyle = context.general.textTheme.bodySmall?.copyWith(
      color: context.general.colorScheme.onSurfaceVariant,
    );

    return Center(
      child: Text.rich(
        TextSpan(
          style: baseStyle,
          children: [
            TextSpan(text: LocaleKeys.auth_legalPrefix.tr()),
            TextSpan(
              text: LocaleKeys.general_kvkk.tr(),
              style: baseStyle?.copyWith(
                fontWeight: FontWeight.w600,
                decoration: TextDecoration.underline,
              ),
              recognizer: _kvkkRecognizer,
            ),
            TextSpan(text: LocaleKeys.auth_legalSuffix.tr()),
          ],
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
