import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart' show ContextExtension;
import 'package:lifeclient/product/init/application_theme.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/model/social/sample_social_data.dart';
import 'package:lifeclient/product/utility/decorations/custom_radius.dart';
import 'package:lifeclient/product/utility/decorations/empty_box.dart';

/// Akış · Etkinlikler — tarih bloğu + başlık + chip'ler + katılım sayacı.
class FeedEventsList extends StatelessWidget {
  const FeedEventsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      child: Column(
        children: [
          for (final e in V2SampleData.events) ...[
            _EventCard(event: e),
            const EmptyBox.smallHeight(),
          ],
        ],
      ),
    );
  }
}

class _EventCard extends StatelessWidget {
  const _EventCard({required this.event});

  final V2Event event;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.general.colorScheme;
    final textTheme = context.general.textTheme;
    return Container(
      decoration: BoxDecoration(
        color: colorScheme.secondary,
        borderRadius: CustomRadius.large,
        border: Border.all(color: colorScheme.onPrimaryContainer),
      ),
      clipBehavior: Clip.antiAlias,
      padding: const EdgeInsets.all(14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _DateBlock(event: event),
          const EmptyBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    // Category pill — tinted from the data-bound accent so
                    // the V2 mosaic colour-coding (coral / teal / gold /
                    // olive per category) is preserved.
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 7,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: event.accent.withValues(alpha: 0.1),
                        borderRadius: CustomRadius.small,
                      ),
                      child: Text(
                        event.category.toUpperCase(),
                        style: V2Typography.label(
                          fontSize: 9.5,
                          color: event.accent,
                        ),
                      ),
                    ),
                    const EmptyBox(width: 6),
                    const _FreeChip(),
                  ],
                ),
                const EmptyBox.smallHeight(),
                Text(
                  event.title,
                  style: V2Typography.display(
                    fontSize: 18,
                    color: colorScheme.primary,
                  ),
                ),
                const EmptyBox.xSmallHeight(),
                Text(
                  event.desc,
                  style: textTheme.bodySmall?.copyWith(
                    fontSize: 12.5,
                    height: 1.45,
                    color: colorScheme.onPrimaryFixedVariant,
                  ),
                ),
                const EmptyBox(height: 10),
                Row(
                  children: [
                    Icon(
                      Icons.place_rounded,
                      size: 13,
                      color: colorScheme.onSecondaryFixed,
                    ),
                    const EmptyBox(width: 3),
                    Expanded(
                      child: Text(
                        '${event.place} · ${event.district}',
                        style: textTheme.labelMedium?.copyWith(
                          fontSize: 12,
                          color: colorScheme.onPrimaryFixedVariant,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const EmptyBox(width: 6),
                    Text(
                      LocaleKeys.feed_goingCount.tr(
                        namedArgs: {'count': event.going.toString()},
                      ),
                      style: V2Typography.label(
                        fontSize: 11.5,
                        color: colorScheme.error,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DateBlock extends StatelessWidget {
  const _DateBlock({required this.event});

  final V2Event event;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.general.colorScheme;
    final textTheme = context.general.textTheme;
    return Container(
      width: 64,
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: event.accent.withValues(alpha: 0.1),
        borderRadius: CustomRadius.medium,
      ),
      child: Column(
        children: [
          Text(
            event.month,
            style: V2Typography.label(
              fontSize: 10.5,
              color: event.accent,
            ),
          ),
          const EmptyBox(height: 1),
          Text(
            event.day,
            style: V2Typography.display(
              fontSize: 28,
              color: colorScheme.primary,
            ),
          ),
          const EmptyBox(height: 1),
          Text(
            '${event.weekday} · ${event.time}',
            style: textTheme.labelSmall?.copyWith(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: colorScheme.onPrimaryFixedVariant,
            ),
          ),
        ],
      ),
    );
  }
}

class _FreeChip extends StatelessWidget {
  const _FreeChip();

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.general.colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
      decoration: BoxDecoration(
        color: colorScheme.primaryContainer.withValues(alpha: 0.18),
        borderRadius: CustomRadius.small,
      ),
      child: Text(
        LocaleKeys.feed_freeBadge.tr(),
        style: V2Typography.label(
          fontSize: 9.5,
          color: colorScheme.primaryContainer,
        ),
      ),
    );
  }
}
