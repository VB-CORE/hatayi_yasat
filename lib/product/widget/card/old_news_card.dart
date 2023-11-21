import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:vbaseproject/product/common/color_common.dart';
import 'package:vbaseproject/product/package/custom_network_image.dart';
import 'package:vbaseproject/product/utility/decorations/empty_box.dart';
import 'package:vbaseproject/product/utility/formatter/custom_date_time_formatter.dart';
import 'package:vbaseproject/product/utility/padding/page_padding.dart';

class OldNewsCard extends StatelessWidget {
  const OldNewsCard({
    required this.item,
    required this.onTap,
    super.key,
  });
  final NewsModel item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        height: context.sized.dynamicHeight(.45),
        child: Stack(
          children: [
            Positioned.fill(
              child: _NewsImage(item: item),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: _GradientBox(item: item),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: _TextArea(item: item),
            ),
          ],
        ),
      ),
    );
  }
}

class _GradientBox extends StatelessWidget {
  const _GradientBox({
    required this.item,
  });

  final NewsModel item;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            ColorCommon(context).whiteAndBlackForTheme.withOpacity(0),
            ColorCommon(context).whiteAndBlackForTheme.withOpacity(0.4),
            ColorCommon(context).whiteAndBlackForTheme.withOpacity(0.7),
            ColorCommon(context).whiteAndBlackForTheme.withOpacity(0.9),
          ],
        ),
      ),
      child: _TextArea(item: item),
    );
  }
}

class _TextArea extends StatelessWidget {
  const _TextArea({
    required this.item,
  });

  final NewsModel item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const PagePadding.allLow(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _NewsTitle(item: item),
          const EmptyBox.xSmallHeight(),
          _NewsDateTime(item: item),
        ],
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
      child: CustomNetworkImage(
        imageUrl: item.image,
        fit: BoxFit.cover,
      ),
    );
  }
}

class _NewsTitle extends StatelessWidget {
  const _NewsTitle({
    required this.item,
  });

  final NewsModel item;

  @override
  Widget build(BuildContext context) {
    return Text(
      item.title ?? '',
      maxLines: 2,
      textAlign: TextAlign.left,
      overflow: TextOverflow.ellipsis,
      style: context.general.textTheme.headlineSmall?.copyWith(
        fontWeight: FontWeight.bold,
        color: ColorCommon(context).blackAndWhiteForTheme,
      ),
    );
  }
}

class _NewsDateTime extends StatelessWidget {
  const _NewsDateTime({
    required this.item,
  });

  final NewsModel item;

  @override
  Widget build(BuildContext context) {
    return Text(
      CustomDateTimeFormatter.formatValueTr(
        item.createdAt ?? DateTime.now(),
      ),
      textAlign: TextAlign.left,
      overflow: TextOverflow.ellipsis,
      style: context.general.textTheme.titleSmall?.copyWith(
        fontWeight: FontWeight.bold,
        color: ColorCommon(context).blackAndWhiteForTheme,
      ),
    );
  }
}
