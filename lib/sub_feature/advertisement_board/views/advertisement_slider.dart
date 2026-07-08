import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/theme/app_colors.dart';
import 'package:lifeclient/core/theme/app_radius.dart';
import 'package:lifeclient/core/theme/app_shadows.dart';
import 'package:lifeclient/core/theme/app_spacing.dart';
import 'package:lifeclient/core/theme/app_text.dart';
import 'package:lifeclient/product/generated/assets.gen.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/package/image/custom_network_image.dart';
import 'package:lifeclient/product/utility/carousel/custom_carousel_options.dart';
import 'package:lifeclient/product/widget/button/open_url_general_button.dart';
import 'package:lifeclient/product/widget/button/share_advertisement_general_button.dart';
import 'package:lifeclient/sub_feature/advertisement_board/provider/advertisement_board_view_model.dart';
import 'package:url_launcher/url_launcher.dart';

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
  static const double _sliderHeight = 178;
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    final items = ref.watch(advertisementBoardViewModelProvider).advertisements;
    final pageCount = items.length + 1;
    return SliverPadding(
      padding: const PagePadding.onlyTop(),
      sliver: SliverToBoxAdapter(
        child: Column(
          children: [
            CarouselSlider.builder(
              itemCount: pageCount,
              itemBuilder: (context, index, realIndex) {
                final child =
                    index == 0 ? const _HouseAdCard() : _AdvertisementItem(
                        items[index - 1],
                      );
                return Padding(
                  padding: const PagePadding.horizontalLowSymmetric(),
                  child: child,
                );
              },
              options: CustomCarouselOptions.advertisement(
                height: _sliderHeight,
                onPageChanged: (index, reason) {
                  setState(() => _current = index);
                },
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            _AdvertisementDots(count: pageCount, current: _current),
          ],
        ),
      ),
    );
  }
}

final class _AdvertisementDots extends StatelessWidget {
  const _AdvertisementDots({required this.count, required this.current});

  final int count;
  final int current;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (var index = 0; index < count; index++)
          AnimatedContainer(
            duration: Durations.short4,
            margin: const EdgeInsets.symmetric(horizontal: 3),
            width: index == current ? 18 : 6,
            height: 6,
            decoration: BoxDecoration(
              color: index == current ? AppColors.coral : AppColors.ink200,
              borderRadius: BorderRadius.circular(AppRadius.pill),
            ),
          ),
      ],
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
