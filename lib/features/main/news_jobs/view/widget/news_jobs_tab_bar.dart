part of '../news_jobs_view.dart';

@immutable
final class _NewsEventJobsTabBar extends StatefulWidget {
  const _NewsEventJobsTabBar({required this.tabs});

  final List<NewsEventJobTabs> tabs;

  @override
  State<_NewsEventJobsTabBar> createState() => _NewsEventJobsTabBarState();
}

class _NewsEventJobsTabBarState extends State<_NewsEventJobsTabBar>
    with _NewsEventJobsTabMixin {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const PagePadding.horizontalSymmetric() + const PagePadding.onlyTop(),
      child: DecoratedBox(
        decoration: const BoxDecoration(
          color: AppColors.surface,
          borderRadius: CustomRadius.medium,
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final tabWidth = constraints.maxWidth / widget.tabs.length;
            return Stack(
              children: [
                AnimatedPositioned(
                  bottom: WidgetSizes.spacingXxs,
                  top: WidgetSizes.spacingXxs,
                  left: _leftPosition(tabWidth),
                  width: tabWidth - (WidgetSizes.spacingXxs * 2),
                  duration: Durations.short4,
                  child: const DecoratedBox(
                    decoration: BoxDecoration(
                      color: AppColors.coral,
                      borderRadius: CustomRadius.medium,
                    ),
                  ),
                ),
                Row(
                  children: [
                    for (final tab in widget.tabs)
                      Expanded(
                        child: _CustomTabButton(
                          tab: tab,
                          onPressed: () => _changeCurrentTabView(tab),
                          selectedTab: _currentTab,
                        ),
                      ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

mixin _NewsEventJobsTabMixin on State<_NewsEventJobsTabBar> {
  void _changeCurrentTabView(NewsEventJobTabs tab) {
    DefaultTabController.maybeOf(context)?.animateTo(widget.tabs.indexOf(tab));
    setState(() {
      _currentTab = tab;
    });
  }

  NewsEventJobTabs _currentTab = NewsEventJobTabs.news;

  /// Returns the left position of the selected tab indicator.
  double _leftPosition(double tabWidth) {
    final index = widget.tabs.indexOf(_currentTab);
    return (tabWidth * index) + WidgetSizes.spacingXxs;
  }
}

final class _CustomTabButton extends StatelessWidget {
  const _CustomTabButton({
    required this.tab,
    required this.onPressed,
    required this.selectedTab,
  });
  final NewsEventJobTabs tab;
  final VoidCallback onPressed;
  final NewsEventJobTabs selectedTab;

  TextStyle? _currentSelectedTextStyle(BuildContext context) =>
      selectedTab == tab
      ? context.general.textTheme.titleSmall?.copyWith(
          fontWeight: FontWeight.w600,
          color: AppColors.surface,
        )
      : context.general.textTheme.titleSmall?.copyWith(
          color: AppColors.ink700,
        );
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: CustomRadius.medium,
      child: SizedBox(
        height: WidgetSizes.spacingXxl7,
        child: Center(
          child: Text(
            tab.title,
            style: _currentSelectedTextStyle(context),
          ),
        ),
      ),
    );
  }
}
