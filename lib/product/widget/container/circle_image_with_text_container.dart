import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:vbaseproject/product/widget/general/title/index.dart';
import 'package:vbaseproject/product/widget/shadow/general_shadow.dart';
import 'package:vbaseproject/product/widget/size/index.dart';

/// CircleImageWithTextContainer is a widget that shows author image and name
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
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor ?? context.general.colorScheme.secondary,
        borderRadius: context.border.highBorderRadius,
        boxShadow: [
          GeneralShadow.sampleGrayShadow(),
        ],
      ),
      child: Padding(
        padding: context.padding.low,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _ImageCircleAvatar(imageUrl: imageUrl),
            context.sized.emptySizedWidthBoxLow,
            context.sized.emptySizedWidthBoxLow,
            _NameTextConstrainedBox(name: name),
          ],
        ),
      ),
    );
  }
}

class _ImageCircleAvatar extends StatelessWidget {
  const _ImageCircleAvatar({
    required this.imageUrl,
    super.key,
  });

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundImage: NetworkImage(
        imageUrl,
      ),
      radius: WidgetSizes.spacingSs,
    );
  }
}

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
      ),
    );
  }
}
