part of '../news_jobs_view.dart';

@immutable
final class _NewsEventJobsTabBar extends StatefulWidget {
  const _NewsEventJobsTabBar();

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
        decoration: BoxDecoration(
          color: context.general.colorScheme.onPrimaryFixed,
          borderRadius: CustomRadius.medium,
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Stack(
              children: [
                AnimatedPositioned(
                  bottom: WidgetSizes.spacingXxs,
                  top: WidgetSizes.spacingXxs,
                  left: _leftPosition,
                  right: _rightPosition,
                  width: constraints.maxWidth / 3,
                  duration: Durations.long1,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: context.general.colorScheme.secondary,
                      borderRadius: CustomRadius.medium,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: _CustomTabButton(
                        tab: NewsEventJobTabs.news,
                        onPressed: () =>
                            _changeCurrentTabView(NewsEventJobTabs.news),
                        selectedTab: _currentTab,
                      ),
                    ),
                    Expanded(
                      child: _CustomTabButton(
                        tab: NewsEventJobTabs.event,
                        onPressed: () =>
                            _changeCurrentTabView(NewsEventJobTabs.event),
                        selectedTab: _currentTab,
                      ),
                    ),
                    Expanded(
                      child: _CustomTabButton(
                        tab: NewsEventJobTabs.jobs,
                        onPressed: () =>
                            _changeCurrentTabView(NewsEventJobTabs.jobs),
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
    DefaultTabController.maybeOf(context)?.animateTo(tab.index);
    setState(() {
      _currentTab = tab;
    });
  }

  NewsEventJobTabs _currentTab = NewsEventJobTabs.news;

  /// Returns the left position of the selected tab indicator.
  double? get _leftPosition =>
      _currentTab == NewsEventJobTabs.jobs ? null : WidgetSizes.spacingXxs;

  /// Returns the right position of the selected tab indicator.
  double? get _rightPosition =>
      _currentTab == NewsEventJobTabs.news ? null : WidgetSizes.spacingXxs;
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
          ? context.general.textTheme.titleSmall
          : context.general.textTheme.titleSmall
              ?.copyWith(color: context.general.colorScheme.onSecondaryFixed);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
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
