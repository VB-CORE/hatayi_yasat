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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isScrolledBottom =
        ref.watch(mainTabViewModelProvider).isScrolledBottom;

    return ClipRRect(
      borderRadius: BorderRadius.circular(WidgetSizes.spacingXxl2),
      child: BottomAppBar(
        height: WidgetSizes.spacingXxl8,
        padding: EdgeInsets.zero,
        notchMargin: WidgetSizes.spacingXxs / 2,
        shape: const CircularNotchedRectangle(),
        elevation: kZero,
        color: context.general.colorScheme.secondary.withValues(
          alpha: isScrolledBottom ? .7 : 1,
        ),
        child: _TabBar(tabItems: tabItems),
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
      dividerColor: ColorsCustom.transparent,
      labelPadding: EdgeInsets.zero,
      indicator: const BoxDecoration(),
      unselectedLabelColor: context.general.colorScheme.primary.withValues(
        alpha: .3,
      ),
      labelStyle: context.general.textTheme.bodyMedium,
      unselectedLabelStyle: context.general.textTheme.bodySmall,
      tabs:
          tabItems
              .map(
                (e) => GeneralSemantic(
                  semanticKey: e.semanticKey,
                  child: Tab(text: e.title.tr(), icon: e.icon),
                ),
              )
              .toList(),
    );
  }
}
