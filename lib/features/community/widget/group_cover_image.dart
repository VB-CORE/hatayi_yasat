import 'package:flutter/material.dart';
import 'package:lifeclient/core/theme/app_gradients.dart';
import 'package:lifeclient/product/package/image/custom_network_image.dart';

@immutable
final class GroupCoverImage extends StatelessWidget {
  const GroupCoverImage({
    required this.groupId,
    required this.imageUrl,
    super.key,
  });

  final String groupId;
  final String? imageUrl;

  // hashCode kararlı olmadığı için karakter kodlarından türetilen indeks.
  int get _gradientIndex =>
      groupId.codeUnits.fold<int>(0, (sum, unit) => sum + unit) %
      AppGradients.coverFallbacks.length;

  @override
  Widget build(BuildContext context) {
    final url = imageUrl;
    if (url == null) {
      return DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: AppGradients.coverFallbacks[_gradientIndex],
          ),
        ),
      );
    }
    return CustomNetworkImage(imageUrl: url, fit: BoxFit.cover);
  }
}
