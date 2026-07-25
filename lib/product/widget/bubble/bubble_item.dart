import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:lifeclient/core/theme/app_colors.dart';
import 'package:lifeclient/product/package/image/custom_network_image.dart';
import 'package:lifeclient/product/widget/bubble/bubble_data.dart';

final class BubbleItem extends StatelessWidget {
  const BubbleItem({required this.data, required this.radius, super.key});

  final BubbleData data;
  final double radius;

  bool get _hasImage => data.imageUrl.ext.isNotNullOrNoEmpty;

  @override
  Widget build(BuildContext context) {
    final size = radius * 2;

    return SizedBox(
      width: size,
      height: size,
      child: ClipOval(
        child: _hasImage ? _imageContent(context) : _fallbackContent(context),
      ),
    );
  }

  Widget _imageContent(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        ColoredBox(color: data.color),
        CustomNetworkImage(
          imageUrl: data.imageUrl,
          fit: .cover,
          placeholder: _fallbackContent(context),
        ),
        if (data.title.isNotEmpty) _titleOverlay(context),
      ],
    );
  }

  Widget _fallbackContent(BuildContext context) {
    final initial = data.title.isNotEmpty ? data.title[0] : '';
    return ColoredBox(
      color: data.color,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Center(
            child: Text(
              initial,
              style: context.general.textTheme.headlineMedium?.copyWith(
                color: AppColors.white,
                fontWeight: FontWeight.bold,
                fontSize: radius * 0.7,
              ),
            ),
          ),
          if (data.title.isNotEmpty) _titleOverlay(context),
        ],
      ),
    );
  }

  Widget _titleOverlay(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: FractionallySizedBox(
        heightFactor: 0.5,
        widthFactor: 1,
        alignment: Alignment.bottomCenter,
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppColors.navy.withValues(alpha: 0),
                AppColors.navy,
              ],
              stops: const [0, 1],
            ),
          ),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.all(radius * 0.2),
              child: Text(
                data.title,
                style: context.general.textTheme.titleSmall?.copyWith(
                  color: AppColors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: radius * 0.25,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
