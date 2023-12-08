import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:vbaseproject/product/package/custom_network_image.dart';
import 'package:vbaseproject/product/utility/decorations/custom_radius.dart';
import 'package:vbaseproject/product/utility/decorations/empty_box.dart';
import 'package:vbaseproject/product/widget/general/index.dart';

@immutable
final class EventCard extends StatelessWidget {
  const EventCard({
    required this.onTap,
    required this.campaignModel,
    super.key,
  });

  final VoidCallback onTap;
  final CampaignModel campaignModel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap.call,
      child: Column(
        children: [
          _EventImage(image: campaignModel.photo),
          const EmptyBox.smallHeight(),
          GeneralContentSubTitle(
            value: campaignModel.name ?? '',
            maxLine: 2,
            fontWeight: FontWeight.bold,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

@immutable
final class _EventImage extends StatelessWidget {
  const _EventImage({
    required this.image,
  });

  final String? image;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.sized.dynamicHeight(0.16),
      child: ClipRRect(
        borderRadius: CustomRadius.large,
        child: CustomNetworkImage(
          imageUrl: image,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
