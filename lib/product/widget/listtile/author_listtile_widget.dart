import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:vbaseproject/product/utility/constants/app_constants.dart';
import 'package:vbaseproject/product/widget/size/widget_size.dart';

final class AuthorListTileWidget extends StatelessWidget {
  const AuthorListTileWidget({
    required this.image,
    required this.text,
    required this.color,
    super.key,
  });

  final String image;
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      dense: true,
      horizontalTitleGap: WidgetSizes.spacingXs,
      leading: _AuthorCircleAvatar(image: image),
      title: _AuthorText(text: text, color: color),
    );
  }
}

class _AuthorText extends StatelessWidget {
  const _AuthorText({
    required this.text,
    required this.color,
  });

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: context.general.textTheme.titleMedium?.copyWith(
        fontWeight: FontWeight.bold,
        color: color,
      ),
    );
  }
}

class _AuthorCircleAvatar extends StatelessWidget {
  const _AuthorCircleAvatar({
    required this.image,
  });

  final String image;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: AppConstants.kFourteen.toDouble(),
      backgroundImage: NetworkImage(image),
    );
  }
}
