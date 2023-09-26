import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:vbaseproject/product/utility/constants/app_constants.dart';
import 'package:vbaseproject/product/utility/size/widget_size.dart';
import 'package:vbaseproject/product/widget/package/custom_network_image.dart';

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
    return Card(
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(WidgetSizes.spacingS),
        ),
        child: Column(
          children: [
            Expanded(
              child: Hero(
                tag: Key(item.documentId),
                child: CustomNetworkImage(
                  imageUrl: item.coverPhoto ?? _defaultImage,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Text(
              item.name ?? '',
              style: context.general.textTheme.titleMedium,
              maxLines: AppConstants.kOne,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
