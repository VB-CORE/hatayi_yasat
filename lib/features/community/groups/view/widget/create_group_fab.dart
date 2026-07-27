part of '../groups_view.dart';

@immutable
final class _CreateGroupFab extends StatelessWidget {
  const _CreateGroupFab();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: WidgetSizes.spacingXxl12),
      child: FloatingActionButton(
        onPressed: () => const CreateGroupRoute().go(context),
        child: const Icon(AppIcons.add),
      ),
    );
  }
}
