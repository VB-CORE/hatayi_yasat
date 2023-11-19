import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:vbaseproject/product/common/color_common.dart';
import 'package:vbaseproject/product/package/custom_network_image.dart';
import 'package:vbaseproject/product/utility/decorations/custom_radius.dart';
import 'package:vbaseproject/product/utility/padding/page_padding.dart';
import 'package:vbaseproject/product/widget/listtile/author_listtile_widget.dart';

class NewsCardV2 extends StatelessWidget {
  const NewsCardV2({required this.item, required this.onTap, super.key});

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

class _NewsImage extends StatelessWidget {
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
      color: ColorCommon(context).blackAndWhiteForTheme.withOpacity(0.45),
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
    // TODO: Geçici olarak koyuldu. Kaldırılacak.
    const dummyImage =
        'https://fastly.picsum.photos/id/821/200/200.jpg?hmac=xmadfEZKXLrqLIgmvr2YTIFvhOms4m95Y-KXrpF_VhI';
    const dummyName = 'Baba Yaga Coffee';
    return Padding(
      padding: const PagePadding.horizontalLowSymmetric() +
          const PagePadding.onlyTopMedium(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _NewsTitle(title: item.title),
          AuthorListTileWidget(
            image: dummyImage,
            text: dummyName,
            color: ColorCommon(context).whiteAndBlackForTheme,
          ),
        ],
      ),
    );
  }
}

class _NewsTitle extends StatelessWidget {
  const _NewsTitle({
    required this.title,
  });

  final String? title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title ?? '',
      maxLines: 1,
      textAlign: TextAlign.left,
      overflow: TextOverflow.ellipsis,
      style: context.general.textTheme.titleLarge?.copyWith(
        color: ColorCommon(context).whiteAndBlackForTheme,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
