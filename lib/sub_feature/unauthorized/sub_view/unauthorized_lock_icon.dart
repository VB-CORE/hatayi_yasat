part of '../unauthorized_view.dart';

final class _LockIcon extends StatelessWidget {
  const _LockIcon();

  static const double _backgroundOpacity = 0.15;
  static const double _borderOpacity = 0.4;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const PagePadding.generalAllNormal(),
      decoration: BoxDecoration(
        color: AppColors.coral.withValues(alpha: _backgroundOpacity),
        borderRadius: CustomRadius.extraLarge,
        border: Border.all(
          color: AppColors.coral.withValues(alpha: _borderOpacity),
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
