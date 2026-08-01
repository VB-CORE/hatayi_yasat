part of '../main_tab_view.dart';

class _BodyTabBarViewWidget extends StatelessWidget {
  const _BodyTabBarViewWidget({required this.tabItems});

  final List<TabModel> tabItems;

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      physics: const NeverScrollableScrollPhysics(),
      children: tabItems.map((e) => e.page).toList(),
    );
  }
}

final class _BottomAppBarWidget extends ConsumerWidget {
  const _BottomAppBarWidget({required this.tabItems});

  final List<TabModel> tabItems;

  static const double height = WidgetSizes.spacingXxl8;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isScrolledBottom = ref
        .watch(mainTabViewModelProvider)
        .isScrolledBottom;

    return AnimatedSlide(
      duration: Durations.medium2,
      curve: Curves.easeOut,
      offset: isScrolledBottom ? const Offset(0, 1) : Offset.zero,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(WidgetSizes.spacingXxl2),
          boxShadow: AppShadows.bottomBar,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(WidgetSizes.spacingXxl2),
          child: BottomAppBar(
            height: height,
            padding: EdgeInsets.zero,
            shape: const CircularNotchedRectangle(),
            elevation: kZero,
            color: context.general.appTheme.bottomAppBarTheme.color,
            child: _TabBar(tabItems: tabItems),
          ),
        ),
      ),
    );
  }
}

class _TabBar extends StatelessWidget {
  const _TabBar({required this.tabItems});

  final List<TabModel> tabItems;

  @override
  Widget build(BuildContext context) {
    return TabBar(
      padding: EdgeInsets.zero,
      dividerColor: Colors.transparent,
      labelPadding: EdgeInsets.zero,
      indicator: const BoxDecoration(),
      labelColor: context.general.colorScheme.primary,
      unselectedLabelColor:
          context.general.appTheme.bottomAppBarTheme.surfaceTintColor,
      labelStyle: context.general.textTheme.bodySmall?.copyWith(
        fontWeight: FontWeight.w400,
        height: 1,
      ),
      unselectedLabelStyle: context.general.textTheme.bodySmall?.copyWith(
        height: 1,
      ),
      tabs: tabItems
          .map(
            (e) => GeneralSemantic(
              semanticKey: e.semanticKey,
              child: Tab(
                text: e.title.tr(),
                icon: e.icon,
                iconMargin: const EdgeInsets.only(
                  bottom: WidgetSizes.spacingXxs,
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}
