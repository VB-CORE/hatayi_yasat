part of '../main_tab_view.dart';

final class _SpeedDialFabWidget extends StatelessWidget {
  const _SpeedDialFabWidget({required this.dialItems});

  final List<SpeedDialChildModel> dialItems;

  @override
  Widget build(BuildContext context) {
    return CustomSpeedDial(
      children: dialItems
          .map(
            (e) => CustomSpeedDialChild(
              context: context,
              destination: e.destination,
              label: e.title,
            ),
          )
          .toList(),
    );
  }
}
