import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:vbaseproject/product/utility/decorations/custom_radius.dart';
import 'package:vbaseproject/product/utility/size/index.dart';

final class SliderModel {
  SliderModel({required this.title, required this.imageUrl});

  final String title;
  final String imageUrl;
}

class CustomBannerSlider extends StatefulWidget {
  const CustomBannerSlider({
    required this.sliderItems,
    required this.onTapped,
    super.key,
  });
  final List<SliderModel> sliderItems;

  final ValueChanged<int> onTapped;

  @override
  State<CustomBannerSlider> createState() => _CustomBannerSliderState();
}

class _CustomBannerSliderState extends State<CustomBannerSlider> {
  final ValueNotifier<int> _currentPageNotifier = ValueNotifier<int>(0);
  final CarouselController _controller = CarouselController();

  void _updateCurrent(int index) {
    if (index == _currentPageNotifier.value) return;
    _currentPageNotifier.value = index;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider.builder(
          carouselController: _controller,
          itemCount: widget.sliderItems.length,
          itemBuilder: (_, index, __) {
            final coverPhoto = widget.sliderItems[index].imageUrl;
            if (coverPhoto.isEmpty) {
              return const SizedBox();
            }
            return InkWell(
              onTap: () {
                widget.onTapped.call(index);
              },
              child: ClipRRect(
                borderRadius: CustomRadius.medium,
                child: CachedNetworkImage(
                  imageUrl: coverPhoto,
                  fit: BoxFit.contain,
                ),
              ),
            );
          },
          options: _CustomCarouselOption(
            onPageChange: _updateCurrent,
          ),
        ),
        _Indicator(currentPageNotifier: _currentPageNotifier, widget: widget),
      ],
    );
  }
}

class _CustomCarouselOption extends CarouselOptions {
  _CustomCarouselOption({required ValueChanged<int> onPageChange})
      : super(
          viewportFraction: .9,
          initialPage: 1,
          enlargeCenterPage: true,
          enlargeStrategy: CenterPageEnlargeStrategy.zoom,
          autoPlay: true,
          enlargeFactor: 0.2,
          onPageChanged: (index, reason) {
            onPageChange.call(index);
          },
        );
}

class _Indicator extends StatelessWidget {
  const _Indicator({
    required ValueNotifier<int> currentPageNotifier,
    required this.widget,
  }) : _currentPageNotifier = currentPageNotifier;

  final ValueNotifier<int> _currentPageNotifier;
  final CustomBannerSlider widget;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: _currentPageNotifier,
      builder: (BuildContext context, int value, Widget? child) {
        return SizedBox(
          height: WidgetSizes.spacingM,
          child: Center(
            child: ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: widget.sliderItems.length,
              itemBuilder: (context, index) {
                return TabPageSelectorIndicator(
                  backgroundColor:
                      value == index ? Colors.grey : Colors.grey.shade300,
                  borderColor: Colors.white,
                  size: WidgetSizes.spacingM / 2,
                );
              },
            ),
          ),
        );
      },
    );
  }
}
