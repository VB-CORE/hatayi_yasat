import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/product/package/image/custom_network_image.dart';
import 'package:lifeclient/product/utility/carousel/custom_carousel_options.dart';
import 'package:lifeclient/product/utility/decorations/custom_radius.dart';
import 'package:lifeclient/product/widget/button/open_url_general_button.dart';
import 'package:lifeclient/product/widget/button/share_advertisement_general_button.dart';
import 'package:lifeclient/sub_feature/advertisement_board/provider/advertisement_board_view_model.dart';

part 'advertisement_board_item.dart';
part 'advertisement_detail_view.dart';

final class AdvertisementSlider extends ConsumerStatefulWidget {
  const AdvertisementSlider({super.key});

  @override
  ConsumerState<AdvertisementSlider> createState() =>
      _AdvertisementSliderState();
}

final class _AdvertisementSliderState extends ConsumerState<AdvertisementSlider>
    with _AdvertisementSliderStateMixin {
  @override
  Widget build(BuildContext context) {
    final items = ref.watch(advertisementBoardViewModelProvider).advertisements;
    return SliverPadding(
      padding: const PagePadding.onlyTop(),
      sliver: _buildSlider(context, items).ext.sliver,
    );
  }

  Widget _buildSlider(
    BuildContext context,
    List<AdBoardModel> items,
  ) {
    if (items.isEmpty) {
      return const SizedBox.shrink();
    }

    return CarouselSlider.builder(
      itemBuilder: (context, index, realIndex) {
        return _buildItem(context, items[index]);
      },
      itemCount: items.length,
      options: CustomCarouselOptions.advertisement(),
    );
  }

  Padding _buildItem(BuildContext context, AdBoardModel item) {
    return Padding(
      padding: const PagePadding.horizontalLowSymmetric(),
      child: _AdvertisementItem(item),
    );
  }
}

mixin _AdvertisementSliderStateMixin on ConsumerState<AdvertisementSlider> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      await ref
          .read(advertisementBoardViewModelProvider.notifier)
          .fetchAdvertisements();
    });
  }
}
