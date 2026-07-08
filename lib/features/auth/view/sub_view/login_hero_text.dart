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
            color: context.general.colorScheme.tertiary,
            letterSpacing: WidgetSizes.spacingXSSs,
          ),
        ),
        const EmptyBox.smallHeight(),
        RichText(
          text: TextSpan(
            style: context.general.textTheme.displayLarge?.copyWith(
              color: context.general.colorScheme.primary,
            ),
            children: [
              TextSpan(text: LocaleKeys.auth_hero_prefix.tr()),
              TextSpan(
                text: LocaleKeys.auth_hero_highlight.tr(),
                style: TextStyle(
                  fontStyle: .italic,
                  color: context.general.colorScheme.tertiary,
                ),
              ),
              const TextSpan(text: '\n'),
              TextSpan(text: LocaleKeys.auth_hero_suffix.tr()),
            ],
          ),
        ),
        const EmptyBox.middleHeight(),
        GeneralContentSubTitle(
          value: LocaleKeys.auth_hero_description.tr(),
          color: context.general.colorScheme.onSurfaceVariant,
        ),
      ],
    );
  }
}
