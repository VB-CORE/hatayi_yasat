part of '../main_tab_view.dart';

final class _SpeedDialFabWidget extends ConsumerWidget {
  const _SpeedDialFabWidget();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = SpeedDialChildModelList(context: context).speedDialChildItems;
    final isScrolledBottom = ref
        .watch(mainTabViewModelProvider)
        .isScrolledBottom;
    final isAuthenticated = ref.watch(authViewModelProvider).isAuthenticated;

    return AnimatedScale(
      duration: Durations.medium2,
      curve: Curves.easeOut,
      scale: isScrolledBottom ? 0 : 1,
      child: CustomSpeedDial(
        children: items
            .map(
              (e) => CustomSpeedDialRouteChild(
                context: context,
                location: e.location,
                label: e.title,
                showLoginRequiredHint: !isAuthenticated,
              ),
            )
            .toList(),
      ),
    );
  }
}
