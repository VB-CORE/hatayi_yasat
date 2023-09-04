import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomNetworkImage extends StatelessWidget {
  const CustomNetworkImage({super.key, this.imageUrl, this.fit});
  final String? imageUrl;
  final BoxFit? fit;
  @override
  Widget build(BuildContext context) {
    if (imageUrl == null) {
      return const SizedBox();
    }
    return CachedNetworkImage(
      imageUrl: imageUrl!,
      fit: fit,
    );
  }
}
