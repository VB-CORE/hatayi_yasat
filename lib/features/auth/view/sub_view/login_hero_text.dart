part of '../login_view.dart';

final class _LoginHeroText extends StatelessWidget {
  const _LoginHeroText();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      children: [
        Text(
          LocaleKeys.auth_hero_subtitle.tr(),
          style: context.general.textTheme.labelSmall?.copyWith(
            color: ColorsCustom.endless,
            letterSpacing: 1.5,
            fontWeight: .w600,
          ),
        ),
        const EmptyBox.smallHeight(),
        RichText(
          text: TextSpan(
            style: context.general.textTheme.displayLarge?.copyWith(
              color: ColorsCustom.sambacus,
              fontWeight: .w600,
            ),
            children: [
              TextSpan(text: LocaleKeys.auth_hero_prefix.tr()),
              TextSpan(
                text: LocaleKeys.auth_hero_highlight.tr(),
                style: const TextStyle(
                  fontStyle: FontStyle.italic,
                  color: ColorsCustom.endless,
                ),
              ),
              const TextSpan(text: '\n'),
              TextSpan(text: LocaleKeys.auth_hero_suffix.tr()),
            ],
          ),
        ),
        const EmptyBox.smallHeight(),
        GeneralContentSubTitle(
          value: LocaleKeys.auth_hero_description.tr(),
          color: context.general.colorScheme.onSurfaceVariant,
        ),
      ],
    );
  }
}
