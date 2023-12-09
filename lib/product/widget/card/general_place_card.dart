import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:uuid/uuid.dart';
import 'package:vbaseproject/product/package/custom_network_image.dart';
import 'package:vbaseproject/product/utility/constants/app_icons.dart';
import 'package:vbaseproject/product/utility/decorations/style/custom_button_style.dart';
import 'package:vbaseproject/product/utility/padding/page_padding.dart';
import 'package:vbaseproject/product/widget/general/index.dart';
import 'package:vbaseproject/product/widget/spacer/dynamic_vertical_spacer.dart';

class GeneralPlaceCard extends StatelessWidget {
  const GeneralPlaceCard({
    required this.onCardTap,
    this.onBookmarkIconTap,
    super.key,
  });

  final VoidCallback onCardTap;
  final VoidCallback? onBookmarkIconTap;

  //  TODO: Static variables will be updated with real model properties.

  static const _defaultImage =
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTpCL7KhxLAe5VjNc-IsT8-N-6fCpXP32oHAcYqL7LoXF5Dp1-A8AyUyjto109DZ_dMsSc&usqp=CAU';

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onCardTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Image(imageUrl: _defaultImage, id: const Uuid().v4()),
          const VerticalSpace.xSmall(),
          _TitleRow(
            name: 'Test Place 1',
            isPlaceSaved: false,
            onSavePlaceTap: onBookmarkIconTap,
          ),
          const _Description(
            description:
                'Even during a disaster, an emergency shelter provides a safe place for people affected by the corona',
          ),
        ],
      ),
    );
  }
}

final class _Image extends StatelessWidget {
  const _Image({
    required this.imageUrl,
    required this.id,
  });

  final String imageUrl;
  final String id;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.sized.dynamicHeight(.24),
      child: Hero(
        tag: Key(id),
        child: CustomNetworkImage(
          imageUrl: imageUrl,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

final class _TitleRow extends StatelessWidget {
  const _TitleRow({
    required this.name,
    required this.isPlaceSaved,
    this.onSavePlaceTap,
  });

  final String name;
  final bool isPlaceSaved;
  final VoidCallback? onSavePlaceTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: GeneralContentTitle(
            value: name,
            fontWeight: FontWeight.bold,
            maxLine: 2,
          ),
        ),
        _BookmarkButton(
          isPlaceSaved: isPlaceSaved,
          onSavePlaceTap: onSavePlaceTap,
        ),
      ],
    );
  }
}

final class _BookmarkButton extends StatelessWidget {
  const _BookmarkButton({
    required this.isPlaceSaved,
    required this.onSavePlaceTap,
  });

  final bool isPlaceSaved;
  final VoidCallback? onSavePlaceTap;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onSavePlaceTap,
      padding: EdgeInsets.zero,
      style: CustomButtonStyle.shrinkWrap,
      icon: Icon(
        isPlaceSaved ? AppIcons.bookmark : AppIcons.bookmarkDefault,
      ),
    );
  }
}

final class _Description extends StatelessWidget {
  const _Description({required this.description});

  final String? description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const PagePadding.vertical6Symmetric(),
      child: GeneralContentSubTitle(
        value: description ?? '',
        maxLine: 2,
      ),
    );
  }
}
