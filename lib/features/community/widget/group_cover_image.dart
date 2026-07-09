import 'package:flutter/material.dart';
import 'package:lifeclient/core/theme/app_colors.dart';
import 'package:lifeclient/product/package/image/custom_network_image.dart';

/// Grup kapak görseli — görsel yoksa grup id'sine göre seçilen gradient
/// zemin gösterir.
@immutable
final class GroupCoverImage extends StatelessWidget {
  const GroupCoverImage({
    required this.groupId,
    required this.imageUrl,
    super.key,
  });

  final String groupId;
  final String? imageUrl;

  // TODO(community): Gerçek kapak görselleri backend'den gelince gradient
  // fallback yalnızca görselsiz gruplarda görünecek.
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
            colors:
                _fallbackGradients[groupId.hashCode.abs() %
                    _fallbackGradients.length],
          ),
        ),
      );
    }
    return CustomNetworkImage(imageUrl: url, fit: BoxFit.cover);
  }
}
