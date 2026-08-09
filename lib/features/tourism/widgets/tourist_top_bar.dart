part of '../view/tourism_map_view.dart';

final class _TouristTopBar extends StatelessWidget {
  const _TouristTopBar();

  static const double _cardOpacity = 0.96;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const PagePadding.horizontal16Symmetric(),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: context.appColors.surface.withValues(alpha: _cardOpacity),
            borderRadius: BorderRadius.circular(AppRadius.lg),
            boxShadow: AppShadows.raised,
          ),
          child: Padding(
            padding: const PagePadding.generalAllLow(),
            child: Row(
              spacing: AppSpacing.xs,
              children: [
                IconButton(
                  onPressed: context.pop,
                  tooltip: MaterialLocalizations.of(context).backButtonTooltip,
                  padding: EdgeInsets.zero,
                  icon: Icon(AppIcons.backIos, color: context.appColors.navy),
                ),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GeneralContentTitle(
                        value: LocaleKeys.tourismView_title.tr(),
                      ),
                      const _TopBarSubtitle(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

final class _TopBarSubtitle extends ConsumerWidget {
  const _TopBarSubtitle();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final spotCount = ref.watch(
      tourismViewModelProvider.select((state) => state.placeList.length),
    );

    return GeneralContentSmallTitle(
      value: LocaleKeys.tourismView_subtitle.tr(args: [spotCount.toString()]),
    );
  }
}
