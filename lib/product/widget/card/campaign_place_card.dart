import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:vbaseproject/product/items/colors_custom.dart';
import 'package:vbaseproject/product/utility/padding/page_padding.dart';
import 'package:vbaseproject/product/utility/size/widget_size.dart';
import 'package:vbaseproject/product/utility/package/custom_network_image.dart';

class CampaignPlaceCard extends ConsumerWidget {
  const CampaignPlaceCard({
    required this.item,
    required this.onTap,
    super.key,
  });
  final CampaignModel item;
  final VoidCallback onTap;
  static const _defaultImage =
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTpCL7KhxLAe5VjNc-IsT8-N-6fCpXP32oHAcYqL7LoXF5Dp1-A8AyUyjto109DZ_dMsSc&usqp=CAU';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return LayoutBuilder(
      builder: (context, constraint) {
        return InkWell(
          onTap: onTap,
          child: Card(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(WidgetSizes.spacingS),
                bottom: Radius.circular(WidgetSizes.spacingS),
              ),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: _Image(item: item, defaultImage: _defaultImage),
                  ),
                  Positioned(
                    bottom: 0,
                    child: _Body(item: item, constraints: constraint),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({
    required this.item,
    required this.constraints,
  });

  final CampaignModel item;
  final BoxConstraints constraints;
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: constraints.maxWidth,
        maxHeight: constraints.maxHeight * 0.6,
      ),
      color: ColorsCustom.black.withOpacity(.4),
      child: Padding(
        padding: const PagePadding.allLow(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (item.name.ext.isNotNullOrNoEmpty) _Title(name: item.name!),
            const Flexible(child: Divider()),
            if (item.publisher.ext.isNotNullOrNoEmpty)
              _Publisher(publisher: item.publisher!),
          ],
        ),
      ),
    );
  }
}

class _Publisher extends StatelessWidget {
  const _Publisher({
    required this.publisher,
  });

  final String publisher;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Text(
          publisher,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: context.general.textTheme.titleSmall?.copyWith(
            color: context.general.colorScheme.onSecondary,
            fontWeight: FontWeight.bold,
            decoration: TextDecoration.underline,
            decorationColor: context.general.colorScheme.onSecondary,
          ),
        ),
        Text(
          'tarafindan yayinladi.',
          style: context.general.textTheme.titleSmall?.copyWith(
            color: context.general.colorScheme.onSecondary,
          ),
        ),
      ],
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({
    required this.name,
  });

  final String name;

  @override
  Widget build(BuildContext context) {
    return Text(
      name,
      style: context.general.textTheme.titleSmall?.copyWith(
        color: context.general.colorScheme.onSecondary,
      ),
    );
  }
}

class _Image extends StatelessWidget {
  const _Image({
    required this.item,
    required String defaultImage,
  }) : _defaultImage = defaultImage;

  final CampaignModel item;
  final String _defaultImage;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: Key(item.documentId),
      child: CustomNetworkImage(
        imageUrl: item.coverPhoto ?? _defaultImage,
        fit: BoxFit.cover,
      ),
    );
  }
}
