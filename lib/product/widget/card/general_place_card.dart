import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/product/model/enum/text_field/text_field_max_lengths.dart';
import 'package:lifeclient/product/package/image/custom_network_image.dart';
import 'package:lifeclient/product/utility/decorations/index.dart';
import 'package:lifeclient/product/utility/extension/store_model_etension.dart';
import 'package:lifeclient/product/widget/button/favorite_button/favorite_place_button.dart';
import 'package:lifeclient/product/widget/general/index.dart';
import 'package:lifeclient/product/widget/spacer/dynamic_vertical_spacer.dart';

@immutable
final class GeneralPlaceCard extends StatelessWidget {
  const GeneralPlaceCard({
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Image(
            imageUrl: storeModel.images.firstOrNull,
          ),
          const VerticalSpace.xSmall(),
          _TitleRow(
            model: storeModel,
            onSavePlaceTap: onBookmarkIconTap,
          ),
          _Description(
            description: storeModel.description,
          ),
        ],
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
    return ClipRRect(
      borderRadius: CustomRadius.medium,
      child: SizedBox(
        height: context.sized.dynamicHeight(.25),
        child: Hero(
          tag: imageUrl ?? '',
          child: CustomNetworkImage(
            imageUrl: imageUrl,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

final class _TitleRow extends StatelessWidget {
  const _TitleRow({
    required this.model,
    this.onSavePlaceTap,
  });

  final StoreModel model;
  final VoidCallback? onSavePlaceTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: GeneralContentTitle(
            value: model.updatedName,
            fontWeight: FontWeight.bold,
            maxLine: TextFieldMaxLengths.maxLineForText,
          ),
        ),
        FavoritePlaceButton(store: model),
      ],
    );
  }
}

final class _Description extends StatelessWidget {
  const _Description({required this.description});

  final String? description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const PagePadding.vertical6Symmetric(),
      child: GeneralContentSubTitle(
        value: description ?? '',
        maxLine: 2,
      ),
    );
  }
}
