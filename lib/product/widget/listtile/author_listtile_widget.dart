import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:vbaseproject/product/utility/decorations/custom_circle_radius.dart';
import 'package:vbaseproject/product/widget/size/widget_size.dart';

final class AuthorListTileWidget extends StatelessWidget {
  const AuthorListTileWidget({
    required this.image,
    required this.text,
    super.key,
    this.trailingWidget,
  });

  final String image;
  final String text;
  final Widget? trailingWidget;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      visualDensity: const VisualDensity(vertical: -4),
      dense: true,
      contentPadding: EdgeInsets.zero,
      horizontalTitleGap: WidgetSizes.spacingXs,
      leading: _AuthorCircleAvatar(image: image),
      title: _AuthorText(text: text),
      trailing: trailingWidget,
    );
  }
}

final class _AuthorText extends StatelessWidget {
  const _AuthorText({
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    // TODO: Fix => PR birleşince General text widget ile değiştirilecek.
    return Text(
      text,
      style: context.general.textTheme.titleMedium?.copyWith(
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

final class _AuthorCircleAvatar extends StatelessWidget {
  const _AuthorCircleAvatar({
    required this.image,
  });

  final String image;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: CustomCircleRadius.medium,
      backgroundImage: NetworkImage(image),
    );
  }
}
