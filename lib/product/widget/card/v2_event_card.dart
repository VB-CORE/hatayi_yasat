import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart' show ContextExtension;
import 'package:lifeclient/product/init/application_theme.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/utility/decorations/custom_radius.dart';
import 'package:lifeclient/product/utility/decorations/empty_box.dart';
import 'package:lifeclient/product/widget/brand/eyebrow.dart';

/// V2 etkinlik kartı — sol kenarda gradient tarih bloğu, sağda başlık,
/// konum, ücretsiz/ücretli rozeti, katılımcı sayısı ve "Katılıyorum" butonu.
class V2EventCard extends StatelessWidget {
  const V2EventCard({
    required this.title,
    required this.dateMonth,
    required this.dateDay,
    required this.location,
    required this.attending,
    required this.heroColors,
    super.key,
    this.excerpt,
    this.isFree = false,
    this.amAttending = false,
    this.onTap,
    this.onAttend,
  });

  final String title;
  final String dateMonth;
  final String dateDay;
  final String location;
  final int attending;
  final List<Color> heroColors;
  final String? excerpt;
  final bool isFree;
  final bool amAttending;
  final VoidCallback? onTap;
  final VoidCallback? onAttend;

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
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _DateBlock(
                month: dateMonth,
                day: dateDay,
                colors: heroColors,
                textColor: colorScheme.onPrimary,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(14, 14, 14, 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Eyebrow(
                                LocaleKeys.feed_segmentEtkinlikler.tr(),
                                color: colorScheme.error,
                              ),
                              if (isFree) ...[
                                const EmptyBox.smallWidth(),
                                Eyebrow(
                                  LocaleKeys.feedV2_freeTag.tr(),
                                  color: colorScheme.onSecondaryContainer,
                                ),
                              ],
                            ],
                          ),
                          const EmptyBox.xSmallHeight(),
                          Text(
                            title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: V2Typography.display(
                              fontSize: 16,
                              color: colorScheme.onSurface,
                            ),
                          ),
                          const EmptyBox.xSmallHeight(),
                          Row(
                            children: [
                              Icon(
                                Icons.place_rounded,
                                size: 13,
                                color: colorScheme.onSecondaryFixed,
                              ),
                              const EmptyBox(width: 4),
                              Expanded(
                                child: Text(
                                  location,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: textTheme.bodySmall?.copyWith(
                                    color: colorScheme.onSecondaryFixed,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          if (excerpt != null && excerpt!.isNotEmpty) ...[
                            const EmptyBox.xSmallHeight(),
                            Text(
                              excerpt!,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: textTheme.bodySmall?.copyWith(
                                color: colorScheme.onPrimaryFixedVariant,
                                height: 1.4,
                              ),
                            ),
                          ],
                        ],
                      ),
                      const EmptyBox.smallHeight(),
                      Row(
                        children: [
                          Text(
                            LocaleKeys.feedV2_attendees.tr(
                              namedArgs: {'count': '$attending'},
                            ),
                            style: textTheme.labelSmall?.copyWith(
                              color: colorScheme.onSecondaryFixed,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const Spacer(),
                          ElevatedButton(
                            onPressed: onAttend,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: amAttending
                                  ? colorScheme.primaryContainer
                                  : colorScheme.error,
                              foregroundColor: colorScheme.onPrimary,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              minimumSize: Size.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              shape: const RoundedRectangleBorder(
                                borderRadius: CustomRadius.small,
                              ),
                            ),
                            child: Text(
                              LocaleKeys.feedV2_iAmAttending.tr(),
                              style: const TextStyle(
                                fontSize: 11.5,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DateBlock extends StatelessWidget {
  const _DateBlock({
    required this.month,
    required this.day,
    required this.colors,
    required this.textColor,
  });

  final String month;
  final String day;
  final List<Color> colors;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 64,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: colors,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            month.toUpperCase(),
            style: V2Typography.eyebrow(
              fontSize: 10,
              color: textColor,
            ),
          ),
          const EmptyBox.xSmallHeight(),
          Text(
            day,
            style: V2Typography.display(
              fontSize: 30,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}
