import 'package:flutter/material.dart';
import 'package:lifeclient/core/theme/app_colors.dart';
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
      _fallbackGradients.length;

  static const List<List<Color>> _fallbackGradients = [
    [AppColors.coral300, AppColors.coral700],
    [AppColors.teal300, AppColors.navy500],
    [AppColors.olive300, AppColors.olive700],
    [AppColors.navy300, AppColors.teal600],
  ];

  @override
  Widget build(BuildContext context) {
    final url = imageUrl;
    if (url == null) {
      return DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: _fallbackGradients[_gradientIndex],
          ),
        ),
      );
    }
    return CustomNetworkImage(imageUrl: url, fit: BoxFit.cover);
  }
}
