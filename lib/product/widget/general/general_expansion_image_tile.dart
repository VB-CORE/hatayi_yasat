import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:vbaseproject/product/package/image/custom_network_image.dart';
import 'package:vbaseproject/product/utility/decorations/custom_border_side.dart';
import 'package:vbaseproject/product/utility/padding/page_padding.dart';
import 'package:vbaseproject/product/widget/general/index.dart';
import 'package:vbaseproject/product/widget/size/index.dart';

@immutable
final class GeneralExpansionImageTile extends StatelessWidget {
  const GeneralExpansionImageTile({
    required this.pageTitle,
    required this.children,
    required this.imageUrl,
    required this.subTitle,
    super.key,
  });

  final String pageTitle;
  final String subTitle;
  final List<Widget> children;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: context.border.roundedRectangleAllBorderNormal
          .copyWith(side: CustomBorderSides.medium),
      elevation: 0,
      child: ExpansionTile(
        shape: LinearBorder.none,
        leading: _LeadingImage(imageUrl: imageUrl),
        title: GeneralBodyTitle(
          pageTitle.tr(context: context),
          fontWeight: FontWeight.bold,
        ),
        subtitle: GeneralContentSmallTitle(
          value: subTitle,
        ),
        childrenPadding: const PagePadding.horizontal16Symmetric(),
        children: children,
      ),
    );
  }
}

@immutable
final class _LeadingImage extends StatelessWidget {
  const _LeadingImage({
    required this.imageUrl,
  });

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: SizedBox(
        width: WidgetSizes.spacingXxl3,
        height: WidgetSizes.spacingXxl3,
        child: CustomNetworkImage(
          imageUrl: imageUrl,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
