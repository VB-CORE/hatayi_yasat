part of '../news_jobs_view.dart';

@immutable
final class _NewsJobsTabBar extends StatefulWidget {
  const _NewsJobsTabBar();

  @override
  State<_NewsJobsTabBar> createState() => _NewsJobsTabBarState();
}

class _NewsJobsTabBarState extends State<_NewsJobsTabBar>
    with _NewsJobsTabMixin {
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
                  width: constraints.maxWidth / 2,
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
                        tab: NewsJobTabs.news,
                        onPressed: () =>
                            _changeCurrentTabView(NewsJobTabs.news),
                        selectedTab: _currentTab,
                      ),
                    ),
                    Expanded(
                      child: _CustomTabButton(
                        tab: NewsJobTabs.jobs,
                        onPressed: () =>
                            _changeCurrentTabView(NewsJobTabs.jobs),
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

mixin _NewsJobsTabMixin on State<_NewsJobsTabBar> {
  void _changeCurrentTabView(NewsJobTabs tab) {
    DefaultTabController.maybeOf(context)?.animateTo(tab.index);
    setState(() {
      _currentTab = tab;
    });
  }

  NewsJobTabs _currentTab = NewsJobTabs.news;

  /// Returns the left position of the selected tab indicator.
  double? get _leftPosition =>
      _currentTab == NewsJobTabs.jobs ? null : WidgetSizes.spacingXxs;

  /// Returns the right position of the selected tab indicator.
  double? get _rightPosition =>
      _currentTab == NewsJobTabs.news ? null : WidgetSizes.spacingXxs;
}

final class _CustomTabButton extends StatelessWidget {
  const _CustomTabButton({
    required this.tab,
    required this.onPressed,
    required this.selectedTab,
  });
  final NewsJobTabs tab;
  final VoidCallback onPressed;
  final NewsJobTabs selectedTab;

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
