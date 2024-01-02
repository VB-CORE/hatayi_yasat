import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:vbaseproject/product/package/image/custom_network_image.dart';
import 'package:vbaseproject/product/utility/decorations/custom_radius.dart';
import 'package:vbaseproject/product/utility/padding/page_padding.dart';
import 'package:vbaseproject/product/widget/general/title/general_sub_title.dart';
import 'package:vbaseproject/product/widget/special/user_special_card.dart';

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
      shape: const RoundedRectangleBorder(
        borderRadius: CustomRadius.large,
      ),
      margin: EdgeInsets.zero,
      color: context.general.colorScheme.secondary.withOpacity(0.45),
      child: _NewsInformationArea(item: item),
    );
  }
}

class _NewsInformationArea extends StatelessWidget {
  const _NewsInformationArea({
    required this.item,
  });

  final NewsModel item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const PagePadding.horizontalLowSymmetric() +
          const PagePadding.verticalLowSymmetric(),
      child: Column(
        children: [
          GeneralSubTitle(
            value: item.title ?? '',
            fontWeight: FontWeight.bold,
            maxLine: 2,
          ),
          const UserSpecialCard(
            user: SpecialUser.creator,
          ),
        ],
      ),
    );
  }
}
