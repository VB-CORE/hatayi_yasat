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

/// V2 mosaic style bottom navigation. 4 sekme + ortada compose FAB.
/// İlk iki sekme solda, son iki sekme sağda; çentik FAB için açık kalır.
final class _BottomAppBarWidget extends ConsumerWidget {
  const _BottomAppBarWidget({required this.tabItems});

  final List<TabModel> tabItems;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = context.general.colorScheme;
    return BottomAppBar(
      height: 76,
      padding: EdgeInsets.zero,
      notchMargin: 8,
      shape: const CircularNotchedRectangle(),
      elevation: 0,
      color: colorScheme.secondary,
      child: TabBar(
        padding: EdgeInsets.zero,
        labelPadding: EdgeInsets.zero,
        dividerColor: Colors.transparent,
        indicator: const BoxDecoration(),
        splashBorderRadius: CustomRadius.medium,
        overlayColor: WidgetStateProperty.all(
          colorScheme.primary.withValues(alpha: 0.06),
        ),
        tabs: [
          for (var i = 0; i < tabItems.length; i++)
            _BottomNavTab(
              item: tabItems[i],
              addTrailingGap: i == 1, // 2. sekmeden sonra FAB boşluğu
            ),
        ],
      ),
    );
  }
}

class _BottomNavTab extends StatelessWidget {
  const _BottomNavTab({
    required this.item,
    this.addTrailingGap = false,
  });

  final TabModel item;
  final bool addTrailingGap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.general.colorScheme;
    return GeneralSemantic(
      semanticKey: item.semanticKey,
      child: Tab(
        height: 64,
        iconMargin: const EdgeInsets.only(bottom: 4),
        child: Padding(
          padding: EdgeInsets.only(right: addTrailingGap ? 56 : 0),
          child: AnimatedBuilder(
            animation: DefaultTabController.of(context),
            builder: (context, _) {
              final controller = DefaultTabController.of(context);
              final tabs = controller.length;
              final selected =
                  controller.index == _indexOf(context, item, tabs);
              final tint = selected
                  ? colorScheme.primary
                  : colorScheme.onSecondaryFixed;
              return Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(item.icon, size: 22, color: tint),
                  const SizedBox(height: 3),
                  Text(
                    item.title.tr(),
                    style: V2Typography.label(
                      fontSize: 10.5,
                      color: tint,
                      fontWeight: selected ? FontWeight.w700 : FontWeight.w600,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  int _indexOf(BuildContext context, TabModel target, int total) {
    final state = context.findAncestorStateOfType<_MainTabViewState>();
    if (state == null) return 0;
    return state._tabItems.indexOf(target);
  }
}
