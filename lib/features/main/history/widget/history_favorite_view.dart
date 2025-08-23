import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/dependency/project_dependency_items.dart';
import 'package:lifeclient/features/main/history/widget/history_photo_detail_sheet.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/package/image/custom_network_image.dart';
import 'package:lifeclient/product/utility/constants/app_icon_sizes.dart';
import 'package:lifeclient/product/utility/constants/app_icons.dart';
import 'package:lifeclient/product/utility/decorations/colors_custom.dart';
import 'package:lifeclient/product/utility/decorations/custom_radius.dart';
import 'package:lifeclient/product/widget/button/memory_favorite_button.dart';

/// History favorites sheet widget that displays user's favorite memories
final class HistoryFavoriteSheet extends StatefulWidget {
  const HistoryFavoriteSheet({super.key});

  @override
  State<HistoryFavoriteSheet> createState() => _HistoryFavoriteSheetState();
}

/// State class for HistoryFavoriteSheet widget
final class _HistoryFavoriteSheetState extends State<HistoryFavoriteSheet> {
  late final List<MemoryModel> favoriteMemories;

  @override
  void initState() {
    super.initState();
    favoriteMemories = ProjectDependencyItems.productCache.memoryCacheModel
        .getAll()
        .map((cacheModel) => cacheModel.memoryModel)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.historyPage_favorites_title.tr()),
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(AppIcons.close),
          ),
        ],
      ),
      body: Container(
        height: context.sized.dynamicHeight(0.8),
        padding: const PagePadding.all(),
        child: favoriteMemories.isEmpty
            ? _buildEmptyFavorites()
            : _buildFavoritesList(favoriteMemories),
      ),
    );
  }

  /// Builds the empty favorites state widget
  Widget _buildEmptyFavorites() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            AppIcons.favoriteBorder,
            size: AppIconSizes.xLarge * 2,
            color: ColorsCustom.warmGrey,
          ),
          const SizedBox(height: AppIconSizes.medium),
          Text(
            LocaleKeys.historyPage_favorites_emptyTitle.tr(),
            style: context.general.textTheme.titleMedium?.copyWith(
              fontSize: AppIconSizes.medium,
              color: ColorsCustom.warmGrey,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: AppIconSizes.small),
          Text(
            LocaleKeys.historyPage_favorites_emptyDescription.tr(),
            textAlign: TextAlign.center,
            style: context.general.textTheme.bodyMedium?.copyWith(
              fontSize: AppIconSizes.small,
              color: ColorsCustom.warmGrey,
            ),
          ),
        ],
      ),
    );
  }

  /// Builds the favorites list widget
  Widget _buildFavoritesList(List<MemoryModel> memories) {
    return ListView.builder(
      itemCount: memories.length,
      itemBuilder: (context, index) {
        final memory = memories[index];
        return Card(
          margin: const PagePadding.verticalSymmetric(),
          child: ListTile(
            contentPadding: const PagePadding.all(),
            leading: _buildMemoryImage(memory),
            title: _buildMemoryTitle(memory),
            subtitle: _buildMemoryDescription(memory),
            trailing: MemoryFavoriteButton(memory: memory),
            onTap: () => _handleMemoryTap(memory),
          ),
        );
      },
    );
  }

  /// Builds the memory image widget
  Widget _buildMemoryImage(MemoryModel memory) {
    const double imageSize = 80;

    return ClipRRect(
      borderRadius: CustomRadius.small,
      child: SizedBox(
        width: imageSize,
        height: imageSize,
        child: memory.imageUrls?.isNotEmpty ?? false
            ? CustomNetworkImage(
                imageUrl: memory.imageUrls!.first,
                fit: BoxFit.cover,
              )
            : const Icon(
                AppIcons.gallery,
                size: AppIconSizes.large,
                color: ColorsCustom.warmGrey,
              ),
      ),
    );
  }

  /// Builds the memory title widget
  Widget? _buildMemoryTitle(MemoryModel memory) {
    if (memory.title == null || memory.title!.isEmpty) return null;
    return Text(
      memory.title ?? LocaleKeys.historyPage_favorites_untitledMemory.tr(),
      style: context.general.textTheme.titleMedium?.copyWith(
        fontWeight: FontWeight.w600,
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  /// Builds the memory description widget
  Widget _buildMemoryDescription(MemoryModel memory) {
    return Text(
      memory.description ?? LocaleKeys.historyPage_favorites_noDescription.tr(),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: context.general.textTheme.bodySmall?.copyWith(
        color: ColorsCustom.warmGrey,
      ),
    );
  }

  /// Handles memory item tap
  void _handleMemoryTap(MemoryModel memory) {
    Navigator.of(context).pop(); // Close bottom sheet first
    _showMemoryDetail(memory);
  }

  /// Shows memory detail bottom sheet
  Future<void> _showMemoryDetail(MemoryModel memory) async {
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => HistoryPhotoDetailSheet(memory: memory),
    );
  }
}
