part of '../group_details_view.dart';

final class _LeaveGroupButton extends StatelessWidget {
  const _LeaveGroupButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final tertiary = context.general.colorScheme.tertiary;
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: tertiary,
          side: BorderSide(color: tertiary),
          padding: const PagePadding.vertical12Symmetric(),
          shape: const RoundedRectangleBorder(
            borderRadius: CustomRadius.medium,
          ),
        ),
        icon: const Icon(AppIcons.exitGroup),
        label: Text(LocaleKeys.community_groupDetail_details_leaveGroup.tr()),
      ),
    );
  }
}

final class _CloseGroupButton extends StatelessWidget {
  const _CloseGroupButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.general.colorScheme;
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.tertiary,
          foregroundColor: colorScheme.onTertiary,
          padding: const PagePadding.vertical12Symmetric(),
          shape: const RoundedRectangleBorder(
            borderRadius: CustomRadius.medium,
          ),
        ),
        icon: const Icon(AppIcons.delete),
        label: Text(LocaleKeys.community_groupDetail_details_closeGroup.tr()),
      ),
    );
  }
}
