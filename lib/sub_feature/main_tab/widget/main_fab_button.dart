part of '../main_tab_view.dart';

final class _SpeedDialFabWidget extends ConsumerWidget {
  const _SpeedDialFabWidget();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authViewModelProvider);
    final hasApplication = authState.hasApplication;
    final isAuthenticated = authState.isAuthenticated;

    final items = SpeedDialChildModelList(
      context: context,
      hasApplication: hasApplication,
    ).speedDialChildItems;
    final isScrolledBottom = ref
        .watch(mainTabViewModelProvider)
        .isScrolledBottom;

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
