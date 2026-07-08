part of '../user_qr_view.dart';

@immutable
final class _UserQrInfoRow extends StatelessWidget {
  const _UserQrInfoRow({
    required this.icon,
    required this.title,
    required this.description,
  });

  final IconData icon;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.general.colorScheme;

    return Row(
      children: [
        Container(
          width: WidgetSizes.spacingXxl4,
          height: WidgetSizes.spacingXxl4,
          decoration: BoxDecoration(
            color: colorScheme.primary.withValues(alpha: 0.08),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: colorScheme.primary),
        ),
        const HorizontalSpace.standard(),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GeneralBodyTitle(
                title,
                fontWeight: FontWeight.w800,
                color: colorScheme.primary,
                textAlign: TextAlign.start,
              ),
              const EmptyBox.xSmallHeight(),
              GeneralContentSubTitle(
                value: description,
                color: colorScheme.onSurfaceVariant,
                textAlign: TextAlign.start,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
