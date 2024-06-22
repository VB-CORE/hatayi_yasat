import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/product/model/enum/text_field/text_field_max_lengths.dart';
import 'package:lifeclient/product/package/image/custom_network_image.dart';
import 'package:lifeclient/product/utility/constants/app_icon_sizes.dart';
import 'package:lifeclient/product/utility/constants/index.dart';
import 'package:lifeclient/product/utility/decorations/index.dart';
import 'package:lifeclient/product/utility/extension/store_model_etension.dart';
import 'package:lifeclient/product/utility/mixin/app_provider_mixin.dart';
import 'package:lifeclient/product/widget/button/favorite_button/favorite_place_button.dart';
import 'package:lifeclient/product/widget/general/index.dart';
import 'package:lifeclient/product/widget/general/title/general_body_small_title.dart';

@immutable
final class GeneralPlaceGridCard extends StatelessWidget {
  const GeneralPlaceGridCard({
    required this.onCardTap,
    required this.storeModel,
    this.onBookmarkIconTap,
    super.key,
  });

  final VoidCallback onCardTap;
  final VoidCallback? onBookmarkIconTap;
  final StoreModel storeModel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onCardTap,
      child: Card(
        child: ClipRRect(
          borderRadius: CustomRadius.medium,
          child: Stack(
            children: [
              Positioned.fill(
                child: Column(
                  children: [
                    Expanded(
                      child: _Image(
                        imageUrl: storeModel.images.firstOrNull,
                      ),
                    ),
                    _TitleRow(model: storeModel),
                  ],
                ),
              ),
              Positioned(
                top: WidgetSizes.spacingXSs,
                right: WidgetSizes.spacingXSs,
                child: CircleAvatar(
                  radius: CustomCircleRadius.medium,
                  backgroundColor:
                      context.general.colorScheme.secondary.withOpacity(0.9),
                  child: FavoritePlaceButton(store: storeModel),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

final class _Image extends StatelessWidget {
  const _Image({
    required this.imageUrl,
  });

  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: imageUrl ?? '',
      child: CustomNetworkImage(
        imageUrl: imageUrl,
        fit: BoxFit.cover,
      ),
    );
  }
}

class _TitleRow extends ConsumerWidget with AppProviderStateMixin {
  const _TitleRow({
    required this.model,
  });

  final StoreModel model;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final town = productProvider(ref).fetchTownFromCode(model.townCode);

    return Padding(
      padding: const PagePadding.allLow(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GeneralBodyTitle(
            model.updatedName,
            fontWeight: FontWeight.bold,
            maxLines: TextFieldMaxLengths.minLine,
          ),
          Row(
            children: [
              const Icon(AppIcons.location, size: AppIconSizes.smallX),
              GeneralBodySmallTitle(
                town,
                fontWeight: FontWeight.w400,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
