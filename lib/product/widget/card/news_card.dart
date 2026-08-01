import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/theme/app_colors.dart';
import 'package:lifeclient/features/main/news_jobs/model/news_feed_model.dart';
import 'package:lifeclient/product/package/image/custom_network_image.dart';
import 'package:lifeclient/product/utility/constants/app_constants.dart';
import 'package:lifeclient/product/utility/decorations/custom_radius.dart';
import 'package:lifeclient/product/utility/decorations/empty_box.dart';
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
      child: SizedBox(
        height: context.sized.dynamicHeight(0.3),
        child: InkWell(
          onTap: onTap,
          child: Stack(
            children: [
              Positioned.fill(
                child: _NewsImage(item: item),
              ),
              const Positioned.fill(
                child: _NewsGradientOverlay(),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: _TransparentBox(item: item),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

final class _NewsImage extends StatelessWidget {
  const _NewsImage({
    required this.item,
  });

  final NewsFeedModel item;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: ValueKey(item.documentId),
      child: ClipRRect(
        borderRadius: CustomRadius.large,
        child: CustomNetworkImage(
          imageUrl: item.photoUrl,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

final class _NewsGradientOverlay extends StatelessWidget {
  const _NewsGradientOverlay();

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: ClipRRect(
        borderRadius: CustomRadius.large,
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppColors.navy.withValues(alpha: 0),
                AppColors.navy.withValues(alpha: .85),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _TransparentBox extends StatelessWidget {
  const _TransparentBox({required this.item});

  final NewsFeedModel item;

  @override
  Widget build(BuildContext context) {
    final author = item.author;
    return Card(
      color: Colors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: CustomRadius.large,
      ),
      margin: EdgeInsets.zero,
      child: Padding(
        padding:
            const PagePadding.horizontalLowSymmetric() +
            const PagePadding.verticalLowSymmetric(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (author != null && author.name.isNotEmpty)
              Wrap(
                children: [
                  CustomUserAvatar(
                    userName: author.name,
                    imageUrl: author.avatarUrl,
                    radius: WidgetSizes.spacingS,
                  ),
                  const EmptyBox.smallWidth(),
                  Text(
                    author.name,
                    style: context.general.textTheme.titleSmall?.copyWith(
                      color: AppColors.surface,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            Padding(
              padding: const PagePadding.onlyTop(),
              child: Text(
                item.title ?? '',
                maxLines: AppConstants.kTwo,
                style: context.general.textTheme.headlineLarge?.copyWith(
                  color: AppColors.surface,
                  fontWeight: FontWeight.w100,
                  height: 1.25,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
