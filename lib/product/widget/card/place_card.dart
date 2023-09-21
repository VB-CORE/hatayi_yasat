import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:vbaseproject/product/utility/padding/page_padding.dart';
import 'package:vbaseproject/product/utility/size/index.dart';
import 'package:vbaseproject/product/utility/state/product_provider.dart';
import 'package:vbaseproject/product/widget/package/custom_network_image.dart';

class PlaceCard extends ConsumerWidget {
  const PlaceCard({
    required this.item,
    required this.onTap,
    super.key,
  });
  final StoreModel item;
  final VoidCallback onTap;
  static const _defaultImage =
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTpCL7KhxLAe5VjNc-IsT8-N-6fCpXP32oHAcYqL7LoXF5Dp1-A8AyUyjto109DZ_dMsSc&usqp=CAU';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final imageUrl = item.images.firstOrNull ?? _defaultImage;
    return InkWell(
      onTap: onTap,
      child: Card(
        child: CupertinoListTile(
          padding: EdgeInsets.zero,
          title: Center(
            child: AspectRatio(
              aspectRatio: 4 / 3,
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(WidgetSizes.spacingS),
                ),
                child: Hero(
                  tag: Key(item.documentId),
                  child: CustomNetworkImage(
                    imageUrl: imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          subtitle: Padding(
            padding: const PagePadding.allLow(),
            child: Row(
              children: [
                Expanded(
                  flex: 5,
                  child: Text(
                    item.name,
                    style: context.general.textTheme.titleLarge,
                    maxLines: 2,
                  ),
                ),
                Padding(
                  padding: const PagePadding.onlyLeft(),
                  child: Text(
                    ref
                        .watch(ProductProvider.provider.notifier)
                        .fetchTownFromCode(item.townCode),
                    style: context.general.textTheme.titleSmall,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
