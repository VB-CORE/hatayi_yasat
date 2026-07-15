part of '../unauthorized_view.dart';

final class _AttemptedPathChip extends StatelessWidget {
  const _AttemptedPathChip({required this.path});

  final String path;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: CustomRadius.xxLarge,
        border: Border.all(
          color: AppColors.navy300.withValues(alpha: 0.4),
        ),
      ),
      child: Padding(
        padding: const PagePadding.boxDesignLowHorizontal(),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              AppIcons.visibilityOff,
              size: AppIconSizes.xMedium,
              color: AppColors.navy300,
            ),
            const EmptyBox.smallWidth(),
            GeneralContentSmallTitle(
              value: path,
              color: AppColors.navy100,
              fontWeight: FontWeight.w600,
            ),
          ],
        ),
      ),
    );
  }
}
