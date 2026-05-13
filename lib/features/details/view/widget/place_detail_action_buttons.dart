part of '../place_detail_view.dart';

/// Header-card action row: Yol tarifi (filled navy), Ara (coral tint),
/// Yorum (teal tint). All sized to share row width equally.
final class _PlaceDetailActionButtons extends StatelessWidget {
  const _PlaceDetailActionButtons({
    required this.onCall,
    required this.onDirections,
    required this.onWriteReview,
  });

  final Future<void> Function() onCall;
  final Future<void> Function() onDirections;
  final Future<void> Function() onWriteReview;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.general.colorScheme;
    return Row(
      children: [
        Expanded(
          child: _ActionButton(
            key: const Key('placeDetailDirectionsButton'),
            icon: Icons.directions_rounded,
            label: LocaleKeys.placeDetailV2_directions.tr(),
            background: colorScheme.primary,
            foreground: colorScheme.onPrimary,
            onTap: onDirections,
          ),
        ),
        const EmptyBox(width: 6),
        Expanded(
          child: _ActionButton(
            key: const Key('placeDetailCallButton'),
            icon: Icons.phone_rounded,
            label: LocaleKeys.placeDetailV2_callPhone.tr(),
            background: colorScheme.error.withValues(alpha: 0.12),
            foreground: colorScheme.error,
            onTap: onCall,
          ),
        ),
        const EmptyBox(width: 6),
        Expanded(
          child: _ActionButton(
            key: const Key('placeDetailWriteReviewButton'),
            icon: Icons.rate_review_rounded,
            label: LocaleKeys.placeDetailV2_writeReview.tr(),
            background: colorScheme.onSecondaryContainer.withValues(
              alpha: 0.12,
            ),
            foreground: colorScheme.onSecondaryContainer,
            onTap: onWriteReview,
          ),
        ),
      ],
    );
  }
}

final class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.icon,
    required this.label,
    required this.background,
    required this.foreground,
    required this.onTap,
    super.key,
  });

  final IconData icon;
  final String label;
  final Color background;
  final Color foreground;
  final Future<void> Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: background,
      borderRadius: CustomRadius.medium,
      child: InkWell(
        onTap: () => onTap(),
        borderRadius: CustomRadius.medium,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 15, color: foreground),
              const EmptyBox(width: 6),
              Flexible(
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: V2Typography.label(fontSize: 12, color: foreground),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
