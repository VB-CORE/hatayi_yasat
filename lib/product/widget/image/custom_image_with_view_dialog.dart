import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:lifeclient/product/package/image/custom_network_image.dart';
import 'package:lifeclient/product/widget/bounceable/bounceable.dart';
import 'package:lifeclient/product/widget/dialog/photo_view_dialog.dart';

@immutable
final class CustomImageWithViewDialog extends StatelessWidget {
  const CustomImageWithViewDialog({
    required this.image,
    this.height,
    this.width,
    super.key,
  });

  final String? image;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    final hasImage = !image.ext.isNullOrEmpty;

    return CustomBounceable(
      onTap: hasImage
          ? () {
              PhotoViewDialog(imageUrl: image!).show(context);
            }
          : null,
      child: SizedBox(
        width: width ?? context.sized.width,
        height: height ?? context.sized.dynamicHeight(.3),
        child: CustomNetworkImage(
          imageUrl: image,
          height: height,
          width: width,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
