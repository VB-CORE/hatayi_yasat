import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart' show ContextExtension;
import 'package:lifeclient/product/init/application_theme.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/utility/decorations/custom_radius.dart';
import 'package:lifeclient/product/utility/decorations/empty_box.dart';
import 'package:lifeclient/product/widget/brand/eyebrow.dart';
import 'package:lifeclient/product/widget/brand/mosaic_grid.dart';

/// V2 news card — hero gradient + dual-badge row + display title +
/// excerpt + actions row.
class V2NewsCard extends StatelessWidget {
  const V2NewsCard({
    required this.title,
    required this.excerpt,
    required this.source,
    required this.timeAgo,
    required this.heroColors,
    super.key,
    this.category,
    this.onTap,
    this.onShare,
    this.onBookmark,
    this.bookmarked = false,
  });

  final String title;
  final String excerpt;
  final String source;
  final String timeAgo;
  final List<Color> heroColors;
  final String? category;
  final VoidCallback? onTap;
  final VoidCallback? onShare;
  final VoidCallback? onBookmark;
  final bool bookmarked;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.general.colorScheme;
    final textTheme = context.general.textTheme;
    return InkWell(
      onTap: onTap,
      borderRadius: CustomRadius.large,
      child: Container(
        decoration: BoxDecoration(
          color: colorScheme.secondary,
          borderRadius: CustomRadius.large,
          border: Border.all(color: colorScheme.onPrimaryContainer),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _Hero(colors: heroColors),
            Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Eyebrow(
                        LocaleKeys.notifications_typeNews.tr(),
                        color: colorScheme.error,
                      ),
                      if (category != null) ...[
                        const EmptyBox.smallWidth(),
                        Eyebrow(
                          category!,
                          color: colorScheme.onSecondaryContainer,
                        ),
                      ],
                    ],
                  ),
                  const EmptyBox.smallHeight(),
                  Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: V2Typography.display(
                      fontSize: 18,
                      color: colorScheme.onSurface,
                    ),
                  ),
                  const EmptyBox.smallHeight(),
                  Text(
                    excerpt,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onPrimaryFixedVariant,
                      height: 1.5,
                    ),
                  ),
                  const EmptyBox.middleHeight(),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          '$source · $timeAgo',
                          style: textTheme.labelSmall?.copyWith(
                            color: colorScheme.onSecondaryFixed,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: onBookmark,
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        icon: Icon(
                          bookmarked
                              ? Icons.bookmark_rounded
                              : Icons.bookmark_border_rounded,
                          size: 18,
                          color: bookmarked
                              ? colorScheme.primary
                              : colorScheme.onSecondaryFixed,
                        ),
                      ),
                      const EmptyBox.smallWidth(),
                      IconButton(
                        onPressed: onShare,
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        icon: Icon(
                          Icons.ios_share_rounded,
                          size: 18,
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
      ),
    );
  }
}

class _Hero extends StatelessWidget {
  const _Hero({required this.colors});

  final List<Color> colors;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140,
      child: Stack(
        fit: StackFit.expand,
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: colors,
              ),
            ),
          ),
          const Positioned.fill(
            child: IgnorePointer(child: MosaicGrid()),
          ),
        ],
      ),
    );
  }
}
