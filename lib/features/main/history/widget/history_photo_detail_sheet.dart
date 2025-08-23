import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/features/main/history/provider/history_view_model.dart';
import 'package:lifeclient/product/package/image/custom_network_image.dart';
import 'package:lifeclient/product/package/share/custom_share.dart';
import 'package:lifeclient/product/utility/constants/app_icon_sizes.dart';
import 'package:lifeclient/product/utility/constants/app_icons.dart';
import 'package:lifeclient/product/utility/decorations/colors_custom.dart';
import 'package:lifeclient/product/widget/button/memory_favorite_button.dart';

@immutable
final class HistoryPhotoDetailSheet extends ConsumerStatefulWidget {
  const HistoryPhotoDetailSheet({
    required this.memory,
    super.key,
  });

  final MemoryModel memory;

  @override
  ConsumerState<HistoryPhotoDetailSheet> createState() =>
      _HistoryPhotoDetailSheetState();
}

class _HistoryPhotoDetailSheetState
    extends ConsumerState<HistoryPhotoDetailSheet> {
  static const double _heightRatio = 0.9;
  int _currentIndex = 0;
  MemoryModel get currentMemory => widget.memory;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.sized.dynamicHeight(_heightRatio),
      decoration: const BoxDecoration(
        color: ColorsCustom.black,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppIconSizes.medium),
        ),
      ),
      child: Column(
        children: [
          _SheetHeader(
            currentIndex: _currentIndex,
            totalCount: currentMemory.imageUrls?.length ?? 0,
          ),
          Expanded(
            child: _PhotoPageView(
              memory: currentMemory,
              onPageChanged: _onPageChanged,
            ),
          ),
          _BottomInfo(memory: currentMemory),
        ],
      ),
    );
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
    ref
        .read(historyViewModelProvider.notifier)
        .updateSelectedMemoryIndex(index);
  }
}

/// Sheet header with counter and close button
final class _SheetHeader extends StatelessWidget {
  const _SheetHeader({
    required this.currentIndex,
    required this.totalCount,
  });

  final int currentIndex;
  final int totalCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const PagePadding.horizontalSymmetric() +
          const PagePadding.vertical6Symmetric(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _CounterText(currentIndex: currentIndex, totalCount: totalCount),
          const _CloseButton(),
        ],
      ),
    );
  }
}

/// Counter text showing current position
final class _CounterText extends StatelessWidget {
  const _CounterText({
    required this.currentIndex,
    required this.totalCount,
  });

  final int currentIndex;
  final int totalCount;

  static const int _indexOffset = 1;

  @override
  Widget build(BuildContext context) {
    if (totalCount == 1) return const SizedBox.shrink();
    return Text(
      '${currentIndex + _indexOffset} / $totalCount',
      style: context.general.textTheme.titleMedium?.copyWith(
        color: ColorsCustom.white,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}

/// Close button for the sheet
final class _CloseButton extends StatelessWidget {
  const _CloseButton();

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => Navigator.of(context).pop(),
      icon: const Icon(
        AppIcons.close,
        color: ColorsCustom.white,
        size: AppIconSizes.large,
      ),
    );
  }
}

/// Photo page view container
final class _PhotoPageView extends StatelessWidget {
  const _PhotoPageView({
    required this.memory,
    required this.onPageChanged,
  });

  final MemoryModel memory;
  final ValueChanged<int> onPageChanged;

  @override
  Widget build(BuildContext context) {
    final imageUrls = memory.imageUrls;
    if (imageUrls == null || imageUrls.isEmpty) {
      return const SizedBox.shrink();
    }
    return PageView.builder(
      onPageChanged: onPageChanged,
      itemCount: imageUrls.length,
      itemBuilder: (context, index) {
        return InteractiveViewer(
          child: Column(
            children: [
              Expanded(
                child: CustomNetworkImage(
                  imageUrl: imageUrls[index],
                  fit: BoxFit.contain,
                  placeholder: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

/// Bottom info section with gradient background
final class _BottomInfo extends StatelessWidget {
  const _BottomInfo({
    required this.memory,
  });

  final MemoryModel memory;

  static const double _gradientOpacity = 0.7;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const PagePadding.all(),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            ColorsCustom.transparent,
            ColorsCustom.black.withValues(alpha: _gradientOpacity),
          ],
        ),
      ),
      child: Column(
        spacing: AppIconSizes.small,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _MemoryTitle(title: memory.title),
          ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: context.sized.dynamicHeight(0.3),
            ),
            child: SingleChildScrollView(
              child: _MemoryDescription(description: memory.description),
            ),
          ),
          _ActionButtons(memory: memory),
        ],
      ),
    );
  }
}

/// Memory title text
final class _MemoryTitle extends StatelessWidget {
  const _MemoryTitle({
    required this.title,
  });

  final String? title;


  @override
  Widget build(BuildContext context) {
    if (title == null || title!.isEmpty) return const SizedBox.shrink();
    return Text(
      title!,
      style: context.general.textTheme.headlineSmall?.copyWith(
        color: ColorsCustom.white,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

/// Memory description text
final class _MemoryDescription extends StatelessWidget {
  const _MemoryDescription({
    required this.description,
  });

  final String? description;

  @override
  Widget build(BuildContext context) {
    if (description == null || description!.isEmpty) {
      return const SizedBox.shrink();
    }
    return Text(
      description!,
      style: context.general.textTheme.bodyMedium?.copyWith(
        color: ColorsCustom.white,
        fontWeight: FontWeight.w800,
      ),
    );
  }
}

/// Action buttons row
final class _ActionButtons extends StatelessWidget {
  const _ActionButtons({
    required this.memory,
  });

  final MemoryModel memory;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _ShareButton(memory: memory),
        MemoryFavoriteButton(memory: memory),
      ],
    );
  }
}

/// Share button
final class _ShareButton extends StatelessWidget {
  const _ShareButton({
    required this.memory,
  });

  final MemoryModel memory;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => CustomShare.shareMemory(memory),
      icon: const Icon(
        AppIcons.share,
        color: ColorsCustom.white,
        size: AppIconSizes.medium,
      ),
    );
  }
}

/// Individual photo item in the page view
