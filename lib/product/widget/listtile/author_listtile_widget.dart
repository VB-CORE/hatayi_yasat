import 'package:flutter/material.dart';
import 'package:vbaseproject/product/package/image/custom_circle_network_image.dart';
import 'package:vbaseproject/product/utility/constants/app_icons.dart';
import 'package:vbaseproject/product/utility/decorations/custom_circle_radius.dart';
import 'package:vbaseproject/product/utility/padding/page_padding.dart';
import 'package:vbaseproject/product/widget/general/index.dart';
import 'package:vbaseproject/product/widget/size/widget_size.dart';

@immutable
final class AuthorListTileWidget extends StatelessWidget {
  const AuthorListTileWidget({
    required this.image,
    required this.text,
    required this.description,
    this.onDeleteTapped,
    super.key,
  });

  final String image;
  final String text;
  final String description;
  final VoidCallback? onDeleteTapped;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _AuthorCircleAvatar(image: image),
        Expanded(
          flex: 8,
          child: Padding(
            padding: const PagePadding.onlyLeft10(),
            child: ListTile(
              dense: true,
              minLeadingWidth: 0,
              contentPadding: EdgeInsets.zero,
              horizontalTitleGap: WidgetSizes.spacingXs,
              title: _AuthorText(text: text),
              subtitle: description.isEmpty
                  ? null
                  : GeneralContentSubTitle(
                      value: description,
                    ),
              trailing: onDeleteTapped == null
                  ? null
                  : IconButton(
                      onPressed: onDeleteTapped,
                      icon: const Icon(AppIcons.delete),
                    ),
            ),
          ),
        ),
      ],
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
    return GeneralBodyTitle(
      text,
      fontWeight: FontWeight.bold,
      textDecoration: TextDecoration.underline,
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
    return CustomCircleNetworkImage(
      imageUrl: image,
      radius: CustomCircleRadius.medium,
    );
  }
}
