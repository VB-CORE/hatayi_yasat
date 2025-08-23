import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/dependency/project_dependency_mixin.dart';
import 'package:lifeclient/product/feature/cache/hive_v2/model/memory_cache_model.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
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
    with ProjectDependencyMixin, _MemoryFavoriteButtonMixin {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: _toggleFavorite,
      icon: Icon(
        _isFavorite ? AppIcons.favorite : AppIcons.favoriteBorder,
        color: _isFavorite ? ColorsCustom.imperilRead : ColorsCustom.white,
        size: AppIconSizes.medium,
      ),
    );
  }
}

mixin _MemoryFavoriteButtonMixin
    on ProjectDependencyMixin, ConsumerState<MemoryFavoriteButton> {
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
    if (_isFavorite) {
      // Remove from favorites
      _removeFavorite();
      return;
    }
    _addFavorite();
  }

  void _addFavorite() {
    // Add to favorites
    final memoryCacheModel = MemoryCacheModel(memoryModel: widget.memory);
    productCache.memoryCacheModel.add(memoryCacheModel);
    setState(() {
      _isFavorite = true;
    });

    _showMessage(LocaleKeys.message_addedFavorite.tr());
  }

  void _removeFavorite() {
    // Remove from favorites
    final memoryCacheModel = MemoryCacheModel(memoryModel: widget.memory);
    productCache.memoryCacheModel.delete(memoryCacheModel);
    setState(() {
      _isFavorite = false;
    });

    _showMessage(LocaleKeys.message_removedFavorite.tr());
  }

  // Fix issue show to top this message
  void _showMessage(String message) {
    if (!mounted) return;
    appProvider.scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: ColorsCustom.brandeisBlue,
      ),
    );
  }
}
