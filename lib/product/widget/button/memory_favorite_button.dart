import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/dependency/project_dependency_mixin.dart';
import 'package:lifeclient/product/feature/cache/hive_v2/model/memory_cache_model.dart';
import 'package:lifeclient/product/utility/constants/app_icon_sizes.dart';
import 'package:lifeclient/product/utility/constants/app_icons.dart';
import 'package:lifeclient/product/utility/decorations/colors_custom.dart';

/// Memory favorite button widget for toggling favorite status
final class MemoryFavoriteButton extends ConsumerStatefulWidget {
  const MemoryFavoriteButton({
    required this.memory,
    super.key,
  });

  final MemoryModel memory;

  @override
  ConsumerState<MemoryFavoriteButton> createState() =>
      _MemoryFavoriteButtonState();
}

class _MemoryFavoriteButtonState extends ConsumerState<MemoryFavoriteButton>
    with ProjectDependencyMixin {
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
    _checkFavoriteStatus();
  }

  void _checkFavoriteStatus() {
    final favoriteMemory =
        productCache.memoryCacheModel.get(widget.memory.documentId);
    setState(() {
      _isFavorite = favoriteMemory != null;
    });
  }

  Future<void> _toggleFavorite() async {
    try {
      if (_isFavorite) {
        // Remove from favorites
        final memoryCacheModel = MemoryCacheModel(memoryModel: widget.memory);
        productCache.memoryCacheModel.delete(memoryCacheModel);
        setState(() {
          _isFavorite = false;
        });

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Favorilerden kaldırıldı'),
              backgroundColor: ColorsCustom.brandeisBlue,
            ),
          );
        }
      } else {
        // Add to favorites
        final memoryCacheModel = MemoryCacheModel(memoryModel: widget.memory);
        productCache.memoryCacheModel.add(memoryCacheModel);
        setState(() {
          _isFavorite = true;
        });

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Favorilere eklendi'),
              backgroundColor: ColorsCustom.brandeisBlue,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Bir hata oluştu'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: _toggleFavorite,
      icon: Icon(
        _isFavorite ? AppIcons.favorite : AppIcons.favoriteBorder,
        color: _isFavorite ? Colors.red : ColorsCustom.white,
        size: AppIconSizes.medium,
      ),
    );
  }
}
