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
import 'package:lifeclient/product/widget/button/favorite_button/favorite_place_button.dart';
import 'package:lifeclient/product/widget/rating/place_rating_label.dart';

@immutable
final class GeneralPlaceGridCard extends StatelessWidget {
  const GeneralPlaceGridCard({
    required this.onCardTap,
    required this.storeModel,
    this.elevation,
    this.isEnabledToFavorite = true,
    super.key,
  });

  final VoidCallback onCardTap;
  final StoreModel storeModel;
  final double? elevation;
  final bool isEnabledToFavorite;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: AppColors.ink50),
        boxShadow: AppShadows.card,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppRadius.lg),
        child: InkWell(
          onTap: onCardTap,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    _GridImage(model: storeModel),
                    if (isEnabledToFavorite)
                      Positioned(
                        top: AppSpacing.xs,
                        right: AppSpacing.xs,
                        child: _FavoriteCircle(store: storeModel),
                      ),
                    Positioned(
                      left: AppSpacing.xs,
                      bottom: AppSpacing.xs,
                      child: _CategoryGlassLabel(category: storeModel.category),
                    ),
                  ],
                ),
              ),
              _GridBody(model: storeModel),
            ],
          ),
        ),
      ),
    );
  }
}

final class _GridImage extends StatelessWidget {
  const _GridImage({required this.model});

  final StoreModel model;

  @override
  Widget build(BuildContext context) {
    final image = model.images.firstOrNull;
    final accent = CategoryVisual.accentFor(model.category);
    if (image == null || image.isEmpty) {
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
            CategoryVisual.iconFor(model.category),
            color: AppColors.white,
            size: 36,
          ),
        ),
      );
    }
    return CustomNetworkImage(imageUrl: image, fit: BoxFit.cover);
  }
}

final class _FavoriteCircle extends StatelessWidget {
  const _FavoriteCircle({required this.store});

  final StoreModel store;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.xxs),
      decoration: BoxDecoration(
        color: AppColors.surface,
        shape: BoxShape.circle,
        boxShadow: AppShadows.card,
      ),
      child: FavoritePlaceButton(store: store),
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

class _GridBody extends ConsumerWidget with AppProviderStateMixin {
  const _GridBody({required this.model});

  final StoreModel model;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final town = productProvider(ref).fetchTownFromCode(model.townCode);
    final meta = PlaceMetaMock(model);
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.xs),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            model.updatedName,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppText.body.copyWith(
              color: AppColors.navy,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: AppSpacing.xxs),
          Row(
            children: [
              const Icon(
                Icons.location_on,
                size: 12,
                color: AppColors.ink400,
              ),
              const SizedBox(width: AppSpacing.xxs),
              Expanded(
                child: Text(
                  town,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppText.caption.copyWith(color: AppColors.ink400),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xxs),
          PlaceRatingLabel(
            rating: meta.ratingLabel,
            reviewCount: meta.reviewCount,
            iconSize: 13,
          ),
        ],
      ),
    );
  }
}
