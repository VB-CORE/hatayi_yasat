import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:vbaseproject/product/package/custom_network_image.dart';
import 'package:vbaseproject/product/utility/decorations/custom_radius.dart';
import 'package:vbaseproject/product/utility/padding/page_padding.dart';
import 'package:vbaseproject/product/widget/general/title/index.dart';
import 'package:vbaseproject/product/widget/shadow/general_shadow.dart';

/// `CircleImageWithTextContainer` shows image with text in circle container
///
/// Params:
/// * `imageUrl` is image url for circle avatar
/// * `name` is text for name
/// * `backgroundColor` is background color for container
final class CircleImageWithTextContainer extends StatelessWidget {
  const CircleImageWithTextContainer({
    required this.imageUrl,
    required this.name,
    super.key,
    this.backgroundColor,
  });

  final Color? backgroundColor;
  final String imageUrl;
  final String name;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: backgroundColor ?? context.general.colorScheme.secondary,
        borderRadius: context.border.highBorderRadius,
        boxShadow: [
          GeneralShadow.sampleGrayShadow(),
        ],
      ),
      child: Padding(
        padding: const PagePadding.allVeryLow(),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _ImageCircleAvatar(imageUrl: imageUrl),
            Padding(
              padding: const PagePadding.onlyLeftLow() +
                  const PagePadding.onlyRightLow(),
              child: _NameTextConstrainedBox(name: name),
            ),
          ],
        ),
      ),
    );
  }
}

@immutable
final class _ImageCircleAvatar extends StatelessWidget {
  const _ImageCircleAvatar({
    required this.imageUrl,
    super.key,
  });

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: CustomRadius.extraLarge,
      child: SizedBox.square(
        dimension: CustomRadius.extraLarge.topLeft.x,
        child: CustomNetworkImage(
          imageUrl: imageUrl,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

@immutable
final class _NameTextConstrainedBox extends StatelessWidget {
  const _NameTextConstrainedBox({
    required this.name,
  });

  final String name;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: context.sized.dynamicWidth(0.3),
      ),
      child: GeneralContentSubTitle(
        value: name,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
