part of '../login_view.dart';

/// KVKK + terms-of-service notice at the bottom of the login screen.
/// Mirrors the V2 jsx — small white@55 paragraph with two inline
/// "underlined" terms.
final class _LoginKvkkFooter extends StatelessWidget {
  const _LoginKvkkFooter();

  @override
  Widget build(BuildContext context) {
    final base = context.general.textTheme.bodySmall?.copyWith(
      fontSize: 11.5,
      height: 1.5,
      // Brand-locked white@55 fine print on navy hero.
      color: ColorsCustom.white.withValues(alpha: 0.55),
    );
    final highlight = base?.copyWith(
      decoration: TextDecoration.underline,
      color: ColorsCustom.white,
      decorationColor: ColorsCustom.white,
    );
    return Center(
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: base,
          children: [
            TextSpan(text: LocaleKeys.auth_kvkkPrefix.tr()),
            TextSpan(text: LocaleKeys.auth_kvkkTerms.tr(), style: highlight),
            TextSpan(text: LocaleKeys.auth_kvkkAnd.tr()),
            TextSpan(text: LocaleKeys.auth_kvkkPolicy.tr(), style: highlight),
            TextSpan(text: LocaleKeys.auth_kvkkSuffix.tr()),
          ],
        ),
      ),
    );
  }
}
