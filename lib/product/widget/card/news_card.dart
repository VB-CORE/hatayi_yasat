import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/theme/app_colors.dart';
import 'package:lifeclient/core/theme/app_spacing.dart';
import 'package:lifeclient/core/theme/app_text.dart';
import 'package:lifeclient/features/main/news_jobs/model/news_feed_model.dart';
import 'package:lifeclient/features/main/news_jobs/provider/news_bookmark_view_model.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/package/image/custom_network_image.dart';
import 'package:lifeclient/product/utility/constants/app_constants.dart';
import 'package:lifeclient/product/utility/constants/app_icon_sizes.dart';
import 'package:lifeclient/product/utility/constants/app_icons.dart';
import 'package:lifeclient/product/utility/decorations/custom_radius.dart';
import 'package:lifeclient/product/utility/decorations/empty_box.dart';
import 'package:lifeclient/product/utility/extension/date_time_extension.dart';
import 'package:lifeclient/product/widget/bounceable/bounceable.dart';
import 'package:lifeclient/product/widget/card/news/news_category_chip.dart';
import 'package:lifeclient/product/widget/card/news/news_read_more_button.dart';
import 'package:lifeclient/product/widget/circle_avatar/custom_user_avatar.dart';

@immutable
final class NewsCard extends StatelessWidget {
  const NewsCard({required this.item, required this.onTap, super.key});

  final NewsFeedModel item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const PagePadding.generalCardAll(),
      child: CustomBounceable(
        onTap: onTap,
        child: DecoratedBox(
          decoration: const BoxDecoration(
            color: AppColors.surface,
            borderRadius: CustomRadius.large,
          ),
          child: ClipRRect(
            borderRadius: CustomRadius.large,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    _NewsImage(item: item),
                    Positioned(
                      top: AppSpacing.xs,
                      left: AppSpacing.xs,
                      right: AppSpacing.xs,
                      child: NewsCategoryBadgeRow(type: item.type),
                    ),
                  ],
                ),
                Padding(
                  padding: const PagePadding.generalAllLow(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: AppSpacing.xxs,
                    children: [
                      _NewsMetaCaption(item: item),
                      Text(
                        item.title ?? '',
                        maxLines: AppConstants.kTwo,
                        overflow: TextOverflow.ellipsis,
                        style: AppText.title,
                      ),
                      if (item.body case final body? when body.isNotEmpty)
                        Text(
                          body,
                          maxLines: AppConstants.kTwo,
                          overflow: TextOverflow.ellipsis,
                          style: AppText.bodySm,
                        ),
                      Padding(
                        padding: const PagePadding.onlyTop(),
                        child: _NewsActionRow(item: item, onReadMore: onTap),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

final class _NewsImage extends StatelessWidget {
  const _NewsImage({required this.item});

  final NewsFeedModel item;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: ValueKey(item.documentId),
      child: SizedBox(
        width: double.infinity,
        height: context.sized.dynamicHeight(0.2),
        child: CustomNetworkImage(imageUrl: item.photoUrl, fit: BoxFit.cover),
      ),
    );
  }
}

final class _NewsMetaCaption extends StatelessWidget {
  const _NewsMetaCaption({required this.item});

  final NewsFeedModel item;

  @override
  Widget build(BuildContext context) {
    final author = item.author;
    final hasAuthor = author != null && author.name.isNotEmpty;
    final timeAgo = item.date?.timeAgo;

    if (!hasAuthor && timeAgo == null) return const SizedBox.shrink();

    final metaText = [
      if (hasAuthor) author.name,
      ?timeAgo,
    ].join(' · ');

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (hasAuthor) ...[
          CustomUserAvatar(
            userName: author.name,
            imageUrl: author.avatarUrl,
            radius: WidgetSizes.spacingS,
          ),
          const EmptyBox.smallWidth(),
        ],
        Flexible(
          child: Text(
            metaText,
            maxLines: AppConstants.kOne,
            overflow: TextOverflow.ellipsis,
            style: AppText.caption,
          ),
        ),
      ],
    );
  }
}

final class _NewsActionRow extends ConsumerWidget {
  const _NewsActionRow({required this.item, required this.onReadMore});

  final NewsFeedModel item;
  final VoidCallback onReadMore;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSaved = ref.watch(
      newsBookmarkViewModelProvider(item.documentId).select(
        (state) => state.isSaved,
      ),
    );

    return Row(
      children: [
        _NewsActionButton(
          icon: isSaved ? AppIcons.bookmark : AppIcons.bookmarkBorder,
          label: LocaleKeys.button_save.tr(),
          color: isSaved ? AppColors.coral : AppColors.navy300,
          onTap: () => ref
              .read(newsBookmarkViewModelProvider(item.documentId).notifier)
              .toggle(),
        ),
        const EmptyBox.smallWidth(),
        _NewsActionButton(
          icon: AppIcons.share,
          label: LocaleKeys.button_share.tr(),
          color: AppColors.navy300,
          onTap: _shareNews,
        ),
        const Spacer(),
        NewsReadMoreButton(onTap: onReadMore),
      ],
    );
  }

  void _shareNews() {
    if (item.body.ext.isNullOrEmpty) return;
    final bodyBuilder = StringBuffer(item.title ?? AppConstants.appName)
      ..write('\n\n')
      ..write(item.body);
    bodyBuilder.toString().ext.share();
  }
}

final class _NewsActionButton extends StatelessWidget {
  const _NewsActionButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: CustomRadius.small,
      child: Padding(
        padding: const PagePadding.generalIconAll(),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          spacing: AppSpacing.xxs,
          children: [
            Icon(icon, size: AppIconSizes.xMedium, color: color),
            Text(label, style: AppText.caption.copyWith(color: color)),
          ],
        ),
      ),
    );
  }
}
