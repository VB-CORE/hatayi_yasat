import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:vbaseproject/product/common/color_common.dart';
import 'package:vbaseproject/product/package/custom_network_image.dart';
import 'package:vbaseproject/product/utility/constants/app_constants.dart';
import 'package:vbaseproject/product/utility/padding/page_padding.dart';
import 'package:vbaseproject/product/widget/size/widget_size.dart';

class HomeAppBarSliver extends StatelessWidget {
  const HomeAppBarSliver({
    required this.isPinned,
    required this.title,
    required this.id,
    required this.imageUrl,
    required this.isTitleOnImage,
    this.actions,
    super.key,
  });

  factory HomeAppBarSliver.fromStore({
    required StoreModel model,
    required bool isPinned,
    List<Widget>? actions,
  }) {
    return HomeAppBarSliver(
      isPinned: isPinned,
      title: model.name,
      id: model.documentId,
      imageUrl: model.images.firstOrNull,
      actions: actions,
      isTitleOnImage: true,
    );
  }

  factory HomeAppBarSliver.fromCampaign({
    required CampaignModel model,
    required bool isPinned,
  }) {
    return HomeAppBarSliver(
      isPinned: isPinned,
      title: model.name ?? '',
      id: model.documentId,
      imageUrl: model.coverPhoto,
      isTitleOnImage: true,
    );
  }

  factory HomeAppBarSliver.fromNews({
    required NewsModel model,
    required bool isPinned,
  }) {
    return HomeAppBarSliver(
      isPinned: isPinned,
      title: model.title ?? '',
      id: model.documentId,
      imageUrl: model.image,
      isTitleOnImage: false,
    );
  }

  final bool isPinned;
  final bool isTitleOnImage;
  final String title;
  final String id;
  final String? imageUrl;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: WidgetSizes.spacingXxlL13,
      pinned: true,
      leading: const _LeftCloseButton(),
      actionsIconTheme: IconThemeData(
        color: context.general.colorScheme.onSurface,
      ),
      actions: actions,
      title: !isPinned ? null : Text(title),
      flexibleSpace: FlexibleSpaceBar(
        title: isTitleOnImage
            ? Container(
                color: isPinned
                    ? null
                    : ColorCommon(context)
                        .whiteAndBlackForTheme
                        .withOpacity(0.5),
                width: context.sized.width,
                child: Padding(
                  padding: const PagePadding.onlyLeft(),
                  child: isPinned
                      ? null
                      : Text(
                          title,
                          maxLines: AppConstants.kThree,
                          overflow: TextOverflow.ellipsis,
                          style: context.general.textTheme.titleLarge?.copyWith(
                            color: ColorCommon(context).blackAndWhiteForTheme,
                          ),
                        ),
                ),
              )
            : const SizedBox.shrink(),
        titlePadding: EdgeInsets.zero,
        centerTitle: false,
        background: Hero(
          tag: ValueKey(id),
          child: CustomNetworkImage(
            imageUrl: imageUrl,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

class _LeftCloseButton extends StatelessWidget {
  const _LeftCloseButton();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const PagePadding.allVeryLow(),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor:
              context.general.colorScheme.background.withOpacity(0.5),
          shape: const CircleBorder(),
          padding: EdgeInsets.zero,
        ),
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: Icon(
          Icons.arrow_back,
          color: context.general.colorScheme.onBackground,
        ),
      ),
    );
  }
}
