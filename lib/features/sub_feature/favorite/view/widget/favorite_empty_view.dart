part of '../favorite_view.dart';

final class _FavoriteEmptyView extends StatelessWidget {
  const _FavoriteEmptyView();

  @override
  Widget build(BuildContext context) {
    return _FavoriteEmptyViewLayout(
      icon: AppIcons.favoriteBorder,
      iconBackground: context.appColors.coral100,
      iconColor: context.general.colorScheme.tertiary,
      title: LocaleKeys.favorite_emptyTitle.tr(),
      description: LocaleKeys.favorite_emptyDescription.tr(),
      child: Padding(
        padding: const PagePadding.onlyTopNormal(),
        child: GeneralButtonV2.active(
          action: () => const MainTabRoute().go(context),
          label: LocaleKeys.favorite_emptyCta.tr(),
          icon: AppIcons.store,
          backgroundColor: context.general.colorScheme.primary,
        ),
      ),
    );
  }
}

final class _FavoriteSearchEmptyView extends StatelessWidget {
  const _FavoriteSearchEmptyView({required this.searchWord});

  final String searchWord;

  @override
  Widget build(BuildContext context) {
    return _FavoriteEmptyViewLayout(
      icon: AppIcons.search,
      iconBackground: context.general.colorScheme.surfaceContainerHighest,
      iconColor: context.general.colorScheme.onSurfaceVariant,
      title: LocaleKeys.favorite_searchEmptyTitle.tr(),
      description: LocaleKeys.favorite_searchEmptyDescription.tr(
        args: [searchWord],
      ),
    );
  }
}

final class _FavoriteEmptyViewLayout extends StatelessWidget {
  const _FavoriteEmptyViewLayout({
    required this.icon,
    required this.iconBackground,
    required this.iconColor,
    required this.title,
    required this.description,
    this.child,
  });

  final IconData icon;
  final Color iconBackground;
  final Color iconColor;
  final String title;
  final String description;
  final Widget? child;

  static const double _iconCircleSize = 96;
  static const int _topSpacerFlex = 3;
  static const int _bottomSpacerFlex = 8;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const PagePadding.horizontalSymmetric(),
      child: Column(
        children: [
          const Spacer(flex: _topSpacerFlex),
          Container(
            width: _iconCircleSize,
            height: _iconCircleSize,
            decoration: BoxDecoration(
              color: iconBackground,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: IconSize.large.value, color: iconColor),
          ),
          const SizedBox(height: AppSpacing.xxxl),
          Center(child: GeneralContentTitle(value: title)),
          const SizedBox(height: AppSpacing.md),
          GeneralContentSubTitle(
            value: description,
            textAlign: TextAlign.center,
          ),
          ?child,
          const Spacer(flex: _bottomSpacerFlex),
        ],
      ),
    );
  }
}
