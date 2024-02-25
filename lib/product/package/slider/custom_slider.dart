import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/product/common/color_common.dart';
import 'package:lifeclient/product/package/image/custom_network_image.dart';
import 'package:lifeclient/product/utility/decorations/custom_radius.dart';

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
              onTap: () => widget.onTapped.call(index),
              child: ClipRRect(
                borderRadius: CustomRadius.medium,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Positioned.fill(
                      child: CustomNetworkImage(
                        imageUrl: coverPhoto,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: _Title(text: widget.sliderItems[index].title),
                    ),
                  ],
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

class _Title extends StatelessWidget {
  const _Title({required this.text});

  final String text;
  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: ColorCommon(context).whiteAndBlackForTheme.withOpacity(.7),
      child: Padding(
        padding: const PagePadding.allLow(),
        child: Text(
          text,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: context.general.textTheme.titleSmall?.copyWith(
            color: ColorCommon(context).blackAndWhiteForTheme,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class _CustomCarouselOption extends CarouselOptions {
  _CustomCarouselOption({required ValueChanged<int> onPageChange})
      : super(
          viewportFraction: .9,
          initialPage: 1,
          enlargeCenterPage: true,
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
