part of '../mosaic_collapsing_page.dart';

final class _MosaicHeaderCard extends StatelessWidget {
  const _MosaicHeaderCard({
    required this.borderRadius,
    required this.showShadow,
    required this.padding,
    required this.child,
  });

  final double borderRadius;
  final bool showShadow;
  final EdgeInsetsGeometry padding;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(color: AppColors.ink50),
        boxShadow: showShadow ? AppShadows.card : null,
      ),
      child: child,
    );
  }
}
