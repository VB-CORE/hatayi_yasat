part of '../unauthorized_view.dart';

final class _AttemptedPathChip extends StatelessWidget {
  const _AttemptedPathChip({required this.path});

  final String path;

  @override
  Widget build(BuildContext context) {
    final appColors = context.appColors;
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: CustomRadius.xxLarge,
        border: Border.all(
          color: appColors.navy300.withValues(alpha: 0.4),
        ),
      ),
      child: Padding(
        padding: const PagePadding.boxDesignLowHorizontal(),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              AppIcons.visibilityOff,
              size: AppIconSizes.xMedium,
              color: appColors.navy300,
            ),
            const EmptyBox.smallWidth(),
            GeneralContentSmallTitle(
              value: path,
              color: appColors.navy100,
              fontWeight: FontWeight.w600,
            ),
          ],
        ),
      ),
    );
  }
}
