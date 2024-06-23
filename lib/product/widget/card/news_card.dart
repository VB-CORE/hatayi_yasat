import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/product/package/image/custom_network_image.dart';
import 'package:lifeclient/product/utility/constants/app_constants.dart';
import 'package:lifeclient/product/utility/decorations/custom_radius.dart';
import 'package:lifeclient/product/utility/decorations/empty_box.dart';
import 'package:lifeclient/product/widget/special/special_user.dart';

@immutable
final class NewsCard extends StatelessWidget {
  const NewsCard({required this.item, required this.onTap, super.key});

  final NewsModel item;
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

  final NewsModel item;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: ValueKey(item.documentId),
      child: ClipRRect(
        borderRadius: CustomRadius.large,
        child: CustomNetworkImage(
          imageUrl: item.image,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _TransparentBox extends StatelessWidget {
  const _TransparentBox({required this.item});

  final NewsModel item;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: CustomRadius.large,
      ),
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const PagePadding.horizontalLowSymmetric() +
            const PagePadding.verticalLowSymmetric(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              children: [
                CircleAvatar(
                  radius: WidgetSizes.spacingS,
                  backgroundImage: NetworkImage(SpecialUser.creator.photoUrl),
                ),
                const EmptyBox.smallWidth(),
                Text(
                  SpecialUser.creator.name,
                  style: context.general.textTheme.titleSmall?.copyWith(
                    color: context.general.colorScheme.secondary,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const PagePadding.onlyTop(),
              child: Text(
                item.title ?? '',
                maxLines: AppConstants.kTwo,
                style: context.general.textTheme.titleLarge?.copyWith(
                  color: context.general.colorScheme.secondary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
