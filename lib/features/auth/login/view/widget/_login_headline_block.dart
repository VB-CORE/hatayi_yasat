part of '../login_view.dart';

/// Eyebrow + display headline + body description block sitting above the
/// OAuth buttons. The headline uses an italic teal accent for the middle
/// word ("birlikte") to mirror the V2 design.
final class _LoginHeadlineBlock extends StatelessWidget {
  const _LoginHeadlineBlock();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LocaleKeys.auth_eyebrow.tr().toUpperCase(),
          style: V2Typography.eyebrow(
            // Brand-locked coral eyebrow on the navy hero.
            color: ColorsCustom.coral300,
          ),
        ),
        const EmptyBox(height: 14),
        RichText(
          text: TextSpan(
            style: V2Typography.display(
              fontSize: 44,
              // Brand-locked white on navy hero.
              color: ColorsCustom.white,
            ),
            children: [
              TextSpan(text: '${LocaleKeys.auth_loginHeadline.tr()} '),
              TextSpan(
                text: LocaleKeys.auth_loginHeadlineAccent.tr(),
                style: V2Typography.display(
                  fontSize: 44,
                  // Brand-locked teal accent on navy hero.
                  color: ColorsCustom.teal200,
                  fontStyle: FontStyle.italic,
                ),
              ),
              const TextSpan(text: '\n'),
              TextSpan(text: LocaleKeys.auth_loginHeadlineSuffix.tr()),
            ],
          ),
        ),
        const EmptyBox(height: 14),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 320),
          child: Text(
            LocaleKeys.auth_loginBody.tr(),
            style: context.general.textTheme.bodyMedium?.copyWith(
              fontSize: 14,
              height: 1.55,
              // Brand-locked white@70 on navy hero.
              color: ColorsCustom.white.withValues(alpha: 0.78),
            ),
          ),
        ),
      ],
    );
  }
}
