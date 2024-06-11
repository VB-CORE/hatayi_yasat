import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/product/model/enum/text_field/text_field_max_lengths.dart';
import 'package:lifeclient/product/package/image/custom_network_image.dart';
import 'package:lifeclient/product/utility/decorations/index.dart';
import 'package:lifeclient/product/utility/extension/store_model_etension.dart';
import 'package:lifeclient/product/widget/button/favorite_button/favorite_place_button.dart';
import 'package:lifeclient/product/widget/general/index.dart';

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
      child: ClipRRect(
        borderRadius: CustomRadius.medium,
        child: Stack(
          children: [
            Positioned.fill(
              child: _Image(
                imageUrl: storeModel.images.firstOrNull,
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: ColoredBox(
                color: context.general.colorScheme.primary.withOpacity(0.7),
                child: _TitleRow(model: storeModel),
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

final class _TitleRow extends StatelessWidget {
  const _TitleRow({
    required this.model,
  });

  final StoreModel model;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const PagePadding.allLow(),
      child: GeneralBodyTitle(
        model.updatedName,
        fontWeight: FontWeight.bold,
        maxLines: TextFieldMaxLengths.maxLineForText,
        color: context.general.colorScheme.onPrimary,
      ),
    );
  }
}
