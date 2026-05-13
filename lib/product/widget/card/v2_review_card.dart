import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart' show ContextExtension;
import 'package:lifeclient/product/init/application_theme.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/model/social/review_model.dart';
import 'package:lifeclient/product/utility/decorations/empty_box.dart';

/// V2 mozaik review card — avatar (or 'A' for anonymous) + name + star
/// rating + body + timestamp. Mirrors the design `V2ReviewItem` and is
/// reused on the place detail "Yorumlar" tab.
class V2ReviewCard extends StatelessWidget {
  const V2ReviewCard({required this.review, super.key});

  final ReviewModel review;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.general.colorScheme;
    final textTheme = context.general.textTheme;
    final displayName = review.anonymous
        ? LocaleKeys.placeDetailV2_anonymousUser.tr()
        : (review.authorName.isEmpty
              ? LocaleKeys.placeDetailV2_anonymousUser.tr()
              : review.authorName);

    return Container(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
      decoration: BoxDecoration(
        color: colorScheme.secondary,
        border: Border(
          bottom: BorderSide(
            color: colorScheme.onPrimaryContainer,
            width: 0.5,
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Avatar(
            anonymous: review.anonymous,
            name: displayName,
          ),
          const EmptyBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        displayName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onSurface,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    if (review.anonymous) ...[
                      const EmptyBox.smallWidth(),
                      _AnonymousBadge(),
                    ],
                  ],
                ),
                const EmptyBox(height: 3),
                Row(
                  children: [
                    _StarRow(rating: review.rating),
                    const EmptyBox(width: 6),
                    Text(
                      '· ${_relativeTime(review.createdAt)}',
                      style: textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSecondaryFixed,
                      ),
                    ),
                  ],
                ),
                const EmptyBox(height: 6),
                Text(
                  review.text,
                  style: textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onPrimaryFixedVariant,
                    height: 1.55,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  const _Avatar({required this.anonymous, required this.name});

  final bool anonymous;
  final String name;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.general.colorScheme;
    final textTheme = context.general.textTheme;
    final initial = anonymous
        ? 'A'
        : (name.trim().isEmpty
              ? 'A'
              : name.trim().characters.first.toUpperCase());
    return Container(
      width: 36,
      height: 36,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: anonymous
            ? colorScheme.onPrimaryFixed
            : colorScheme.primary.withValues(alpha: 0.12),
        shape: BoxShape.circle,
      ),
      child: anonymous
          ? Icon(
              Icons.person_rounded,
              size: 18,
              color: colorScheme.onSecondaryFixed,
            )
          : Text(
              initial,
              style: textTheme.titleSmall?.copyWith(
                color: colorScheme.primary,
                fontWeight: FontWeight.w800,
              ),
            ),
    );
  }
}

class _AnonymousBadge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colorScheme = context.general.colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: colorScheme.onPrimaryFixed,
        borderRadius: const BorderRadius.all(Radius.circular(6)),
      ),
      child: Text(
        LocaleKeys.placeDetailV2_anonymousBadge.tr().toUpperCase(),
        style: V2Typography.eyebrow(
          fontSize: 9,
          color: colorScheme.onSecondaryFixed,
        ),
      ),
    );
  }
}

class _StarRow extends StatelessWidget {
  const _StarRow({required this.rating});

  final int rating;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.general.colorScheme;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var i = 1; i <= 5; i++)
          Padding(
            padding: const EdgeInsets.only(right: 1),
            child: Icon(
              i <= rating ? Icons.star_rounded : Icons.star_outline_rounded,
              size: 13,
              color: i <= rating
                  ? colorScheme.tertiary
                  : colorScheme.onPrimaryContainer,
            ),
          ),
      ],
    );
  }
}

String _relativeTime(DateTime when) {
  final delta = DateTime.now().difference(when);
  if (delta.inMinutes < 1) return 'şimdi';
  if (delta.inMinutes < 60) return '${delta.inMinutes} dk';
  if (delta.inHours < 24) return '${delta.inHours} saat';
  if (delta.inDays < 7) return '${delta.inDays} gün';
  return '${(delta.inDays / 7).floor()} hafta';
}
