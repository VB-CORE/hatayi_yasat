part of '../unauthorized_view.dart';

final class _LockIcon extends StatelessWidget {
  const _LockIcon();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const PagePadding.generalAllNormal(),
      decoration: BoxDecoration(
        color: AppColors.coral.withValues(alpha: 0.15),
        borderRadius: CustomRadius.extraLarge,
        border: Border.all(
          color: AppColors.coral.withValues(alpha: 0.4),
        ),
      ),
      child: const Icon(
        AppIcons.lockPerson,
        color: AppColors.coral,
        size: AppIconSizes.xLarge,
      ),
    );
  }
}
