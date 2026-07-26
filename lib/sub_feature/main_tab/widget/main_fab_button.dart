part of '../main_tab_view.dart';

final class _SpeedDialFabWidget extends ConsumerWidget {
  const _SpeedDialFabWidget();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final canCreateGroup = ref.watch(
      authViewModelProvider.select(
        (state) => state.user?.canCreateGroup ?? false,
      ),
    );
    final items = SpeedDialChildModelList(
      context: context,
      canCreateGroup: canCreateGroup,
    ).speedDialChildItems;
    return CustomSpeedDial(
      children: items
          .map(
            (e) => CustomSpeedDialRouteChild(
              context: context,
              location: e.location,
              label: e.title,
            ),
          )
          .toList(),
    );
  }
}
