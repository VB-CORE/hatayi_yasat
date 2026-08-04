import 'package:carousel_slider/carousel_slider.dart'; // veya projedeki paket importu
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/theme/app_colors.dart';
import 'package:lifeclient/product/model/auth/user/avatar_type_model.dart';
import 'package:lifeclient/product/model/auth/user/avatar_types.dart';
import 'package:lifeclient/product/utility/constants/duration_constant.dart';

final class EditProfilePhoto extends StatefulWidget {
  const EditProfilePhoto({
    required this.avatarType,
    required this.onSelect,
    super.key,
  });

  final int avatarType;
  final ValueChanged<int> onSelect;

  @override
  State<EditProfilePhoto> createState() => _EditProfilePhotoState();
}

final class _EditProfilePhotoState extends State<EditProfilePhoto> {
  late final CarouselSliderController _controller; // veya Controller sınıfınız

  List<AvatarTypeModel> get _types => AvatarTypes.all;

  int get _initialIndex {
    final index = _types.indexWhere((type) => type.id == widget.avatarType);
    return index < 0 ? 0 : index;
  }

  @override
  void initState() {
    super.initState();
    _controller = CarouselSliderController();
  }

  @override
  Widget build(BuildContext context) {
    final maxRadius = context.sized.dynamicWidth(0.14);
    final containerHeight = maxRadius * 3;

    return SizedBox(
      height: containerHeight,
      child: CarouselSlider.builder(
        carouselController: _controller,
        itemCount: _types.length,
        options: CarouselOptions(
          height: containerHeight,
          enlargeFactor: 0.40,
          viewportFraction: 0.35,
          initialPage: _initialIndex,
          enlargeCenterPage: true,
          onPageChanged: (index, reason) {
            widget.onSelect(_types[index].id);
          },
        ),
        itemBuilder: (context, index, realIndex) {
          final type = _types[index];
          final isSelected = type.id == widget.avatarType;

          return GestureDetector(
            onTap: () => _controller.animateToPage(
              index,
              duration: DurationConstant.durationLow,
              curve: Curves.easeOutCubic,
            ),
            child: Center(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  shape: .circle,
                  boxShadow: [
                    if (isSelected)
                      BoxShadow(
                        color: AppColors.coral.withValues(alpha: 0.45),
                        blurRadius: WidgetSizes.spacingL,
                        spreadRadius: WidgetSizes.spacingXSs,
                      ),
                  ],
                ),
                child: SizedBox(
                  width: maxRadius * 2,
                  height: maxRadius * 2,
                  child: Image.asset(type.path, fit: .cover),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
