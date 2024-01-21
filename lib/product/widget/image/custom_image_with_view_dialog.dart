import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:vbaseproject/product/package/image/custom_network_image.dart';
import 'package:vbaseproject/product/widget/dialog/photo_view_dialog.dart';

@immutable
final class CustomImageWithViewDialog extends StatelessWidget {
  const CustomImageWithViewDialog({
    required this.image,
    this.height,
    super.key,
  });

  final String? image;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (image.ext.isNullOrEmpty) return;
        PhotoViewDialog(imageUrl: image!).show(context);
      },
      child: SizedBox(
        width: context.sized.width,
        height: height == null ? null : context.sized.dynamicHeight(0.3),
        child: CustomNetworkImage(
          imageUrl: image,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
