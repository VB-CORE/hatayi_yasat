part of '../group_details_view.dart';

final class _LeaveGroupButton extends StatelessWidget {
  const _LeaveGroupButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.coral,
          side: const BorderSide(color: AppColors.coral),
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
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.coral,
          foregroundColor: AppColors.white,
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
