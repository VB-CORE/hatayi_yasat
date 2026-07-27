part of '../main_tab_view.dart';

final class _SpeedDialFabWidget extends ConsumerWidget {
  const _SpeedDialFabWidget();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = SpeedDialChildModelList(context: context).speedDialChildItems;
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
