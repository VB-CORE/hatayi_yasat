import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:vbaseproject/product/common/color_common.dart';
import 'package:vbaseproject/product/package/custom_network_image.dart';
import 'package:vbaseproject/product/utility/decorations/style/custom_button_style.dart';
import 'package:vbaseproject/product/widget/spacer/dynamic_vertical_spacer.dart';

class GeneralPlaceCard extends ConsumerWidget {
  const GeneralPlaceCard({
    required this.item,
    required this.onCardTap,
    this.onBookmarkIconTap,
    super.key,
  });

  final StoreModel item;
  final VoidCallback onCardTap;
  final VoidCallback? onBookmarkIconTap;

  static const _defaultImage =
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTpCL7KhxLAe5VjNc-IsT8-N-6fCpXP32oHAcYqL7LoXF5Dp1-A8AyUyjto109DZ_dMsSc&usqp=CAU';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final imageUrl = item.images.firstOrNull ?? _defaultImage;
    return InkWell(
      onTap: onCardTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Image(imageUrl: imageUrl, id: item.documentId),
          const VerticalSpace.xSmall(),
          _TitleRow(
            name: item.name,
            isPlaceSaved: item.isApproved,
            onSavePlaceTap: onBookmarkIconTap,
          ),
          const VerticalSpace.xxSmall(),
          _Description(description: item.description),
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
      height: context.sized.height * 0.3,
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
          child: Text(
            name,
            style: context.general.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: ColorCommon(context).whiteAndBlackForTheme,
              fontSize: context.general.textTheme.titleMedium?.fontSize,
            ),
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
        isPlaceSaved ? Icons.bookmark : Icons.bookmark_border_outlined,
        color: context.general.colorScheme.primary,
      ),
    );
  }
}

final class _Description extends StatelessWidget {
  const _Description({required this.description});

  final String? description;

  @override
  Widget build(BuildContext context) {
    return Text(
      description ?? '',
      style: context.general.textTheme.titleMedium?.copyWith(
        color: ColorCommon(context).whiteAndBlackForTheme,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
