import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart' show ContextExtension;
import 'package:lifeclient/product/init/application_theme.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/model/social/sample_social_data.dart';
import 'package:lifeclient/product/utility/decorations/colors_custom.dart';
import 'package:lifeclient/product/utility/decorations/custom_radius.dart';
import 'package:lifeclient/product/utility/decorations/empty_box.dart';

/// Akış · Haberler — admin tarafından paylaşılan haber kartları.
class FeedNewsList extends StatelessWidget {
  const FeedNewsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      child: Column(
        children: [
          for (final n in V2SampleData.news) ...[
            _NewsCard(item: n),
            const EmptyBox.smallHeight(),
          ],
        ],
      ),
    );
  }
}

class _NewsCard extends StatelessWidget {
  const _NewsCard({required this.item});

  final V2NewsItem item;

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 130,
            decoration: BoxDecoration(
              // Brand-locked gradient hero — pairs the news item's accent
              // with the navy brand floor regardless of theme.
              gradient: LinearGradient(
                colors: [item.accent, ColorsCustom.navy],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                _Pill(text: item.tag),
                const Spacer(),
                _Pill(
                  text: LocaleKeys.feed_officialSourceBadge.tr(),
                  icon: Icons.verified_rounded,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: V2Typography.display(
                    fontSize: 18,
                    color: colorScheme.primary,
                  ),
                ),
                const EmptyBox.smallHeight(),
                Text(
                  item.excerpt,
                  style: textTheme.bodyMedium?.copyWith(
                    fontSize: 13,
                    height: 1.5,
                    color: colorScheme.onPrimaryFixedVariant,
                  ),
                ),
                const EmptyBox(height: 10),
                Row(
                  children: [
                    Icon(
                      Icons.public_rounded,
                      size: 14,
                      color: colorScheme.onSecondaryFixed,
                    ),
                    const EmptyBox(width: 4),
                    Text(
                      item.authorName,
                      style: V2Typography.label(
                        fontSize: 12,
                        color: colorScheme.onPrimaryFixedVariant,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      ' · ${item.timeAgo}',
                      style: textTheme.labelSmall?.copyWith(
                        fontSize: 12,
                        color: colorScheme.onSecondaryFixed,
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

class _Pill extends StatelessWidget {
  const _Pill({required this.text, this.icon});

  final String text;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    // Sits over a dark brand hero — locked to white text/icons for contrast.
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: ColorsCustom.white.withValues(alpha: 0.18),
        borderRadius: CustomRadius.small,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 10, color: ColorsCustom.white),
            const EmptyBox(width: 3),
          ],
          Text(
            text,
            style: V2Typography.label(
              fontSize: 9.5,
              color: ColorsCustom.white,
            ),
          ),
        ],
      ),
    );
  }
}
