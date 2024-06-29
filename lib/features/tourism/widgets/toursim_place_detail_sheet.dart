import 'package:flutter/material.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/product/package/image/custom_network_image.dart';
import 'package:lifeclient/product/widget/text/title_description_text.dart';

final class ToursimPlaceDetailSheet extends StatelessWidget {
  const ToursimPlaceDetailSheet({required this.model, super.key});
  final TouristicPlaceModel model;

  static void show(BuildContext context, TouristicPlaceModel model) {
    showModalBottomSheet<void>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(WidgetSizes.spacingL),
        ),
      ),
      builder: (context) => ToursimPlaceDetailSheet(model: model),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(
        top: Radius.circular(WidgetSizes.spacingL),
      ),
      child: ListView(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(WidgetSizes.spacingL),
            ),
            child: CustomNetworkImage(
              imageUrl: model.photo,
              // height: context.sized.dynamicHeight(0.3),
            ),
          ),
          Padding(
            padding: const PagePadding.allLow(),
            child: TitleDescription(
              title: model.title ?? '',
              description: model.description ?? '',
            ),
          ),
        ],
      ),
    );
  }
}
