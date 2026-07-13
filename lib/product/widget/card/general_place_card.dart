import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/theme/app_colors.dart';
import 'package:lifeclient/core/theme/app_radius.dart';
import 'package:lifeclient/core/theme/app_shadows.dart';
import 'package:lifeclient/core/theme/app_spacing.dart';
import 'package:lifeclient/core/theme/app_text.dart';
import 'package:lifeclient/product/package/image/custom_network_image.dart';
import 'package:lifeclient/product/utility/extension/category_visual.dart';
import 'package:lifeclient/product/utility/extension/store_model_etension.dart';
import 'package:lifeclient/product/utility/mixin/app_provider_mixin.dart';
import 'package:lifeclient/product/utility/mock/place_meta_mock.dart';
import 'package:lifeclient/product/widget/bounceable/bounceable.dart';
import 'package:lifeclient/product/widget/button/favorite_button/favorite_place_button.dart';
import 'package:lifeclient/product/widget/pill/status_pill.dart';
import 'package:lifeclient/product/widget/rating/place_rating_label.dart';

@immutable
final class GeneralPlaceCard extends StatelessWidget {
  const GeneralPlaceCard({
    required this.onCardTap,
    required this.storeModel,
    super.key,
  });

  static const double _imageWidth = 104;

  final VoidCallback onCardTap;
  final StoreModel storeModel;

  @override
  Widget build(BuildContext context) {
    return CustomBounceable(
      onTap: onCardTap,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppRadius.lg),
          border: Border.all(color: AppColors.ink50),
          boxShadow: AppShadows.card,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppRadius.lg),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  width: _imageWidth,
                  child: _PlaceImageBlock(model: storeModel),
                ),
                Expanded(child: _Body(model: storeModel)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

final class _PlaceImageBlock extends StatelessWidget {
  const _PlaceImageBlock({required this.model});

  final StoreModel model;

  @override
  Widget build(BuildContext context) {
    final image = model.images.firstOrNull;
    final accent = CategoryVisual.accentFor(model.category);
    if (image == null || image.isEmpty) {
      return _MosaicPlaceholder(accent: accent, category: model.category);
    }
    return Stack(
      fit: StackFit.expand,
      children: [
        CustomNetworkImage(imageUrl: image, fit: BoxFit.cover),
        Positioned(
          left: AppSpacing.xs,
          bottom: AppSpacing.xs,
          child: _CategoryGlassLabel(category: model.category),
        ),
      ],
    );
  }
}

final class _MosaicPlaceholder extends StatelessWidget {
  const _MosaicPlaceholder({required this.accent, required this.category});

  final Color accent;
  final CategoryModel? category;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [accent, AppColors.navy],
        ),
      ),
      child: Center(
        child: Icon(
          CategoryVisual.iconFor(category),
          color: AppColors.white,
          size: 36,
        ),
      ),
    );
  }
}

final class _CategoryGlassLabel extends StatelessWidget {
  const _CategoryGlassLabel({required this.category});

  final CategoryModel? category;

  @override
  Widget build(BuildContext context) {
    final name = category?.displayName;
    if (name == null || name.isEmpty) return const SizedBox.shrink();
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.xs,
        vertical: AppSpacing.xxs,
      ),
      decoration: BoxDecoration(
        color: AppColors.navy.withValues(alpha: 0.78),
        borderRadius: BorderRadius.circular(AppRadius.sm),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            CategoryVisual.iconFor(category),
            color: AppColors.white,
            size: 12,
          ),
          const SizedBox(width: AppSpacing.xxs),
          Text(
            name,
            style: AppText.micro.copyWith(color: AppColors.white),
          ),
        ],
      ),
    );
  }
}

class _Body extends ConsumerWidget with AppProviderStateMixin {
  const _Body({required this.model});

  final StoreModel model;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final town = productProvider(ref).fetchTownFromCode(model.townCode);
    final meta = PlaceMetaMock(model);
    final category = model.category?.displayName;
    final subtitle = [
      if (category != null && category.isNotEmpty) category,
      if (town.isNotEmpty) town,
    ].join(' · ');

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  model.updatedName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppText.bodyLg.copyWith(
                    color: AppColors.navy,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              FavoritePlaceButton(store: model),
            ],
          ),
          if (subtitle.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: AppSpacing.xxs),
              child: Text(
                subtitle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppText.caption.copyWith(color: AppColors.ink400),
              ),
            ),
          const SizedBox(height: AppSpacing.xs),
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.xxs,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              StatusPill(store: model),
              PlaceRatingLabel(
                rating: meta.ratingLabel,
                reviewCount: meta.reviewCount,
              ),
              Text(
                meta.distanceLabel,
                style: AppText.caption.copyWith(color: AppColors.ink400),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
