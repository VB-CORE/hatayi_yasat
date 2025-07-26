part of '../history_view.dart';

@immutable
final class _PhotoDetailSheet extends ConsumerStatefulWidget {
  const _PhotoDetailSheet({
    required this.memory,
    required this.allMemories,
    required this.initialIndex,
    super.key,
  });

  final MemoryModel memory;
  final List<MemoryModel> allMemories;
  final int initialIndex;

  @override
  ConsumerState<_PhotoDetailSheet> createState() => _PhotoDetailSheetState();
}

class _PhotoDetailSheetState extends ConsumerState<_PhotoDetailSheet> {
  late PageController _pageController;
  late int _currentIndex;

  static const double _heightRatio = 0.9;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  MemoryModel get currentMemory => widget.allMemories[_currentIndex];

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
            totalCount: widget.allMemories.length,
          ),
          Expanded(
            child: _PhotoPageView(
              pageController: _pageController,
              allMemories: widget.allMemories,
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
    super.key,
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
    super.key,
  });

  final int currentIndex;
  final int totalCount;

  static const int _indexOffset = 1;

  @override
  Widget build(BuildContext context) {
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
  const _CloseButton({super.key});

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
    required this.pageController,
    required this.allMemories,
    required this.onPageChanged,
    super.key,
  });

  final PageController pageController;
  final List<MemoryModel> allMemories;
  final ValueChanged<int> onPageChanged;

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: pageController,
      onPageChanged: onPageChanged,
      itemCount: allMemories.length,
      itemBuilder: (context, index) {
        return _PhotoDetailItem(memory: allMemories[index]);
      },
    );
  }
}

/// Bottom info section with gradient background
final class _BottomInfo extends StatelessWidget {
  const _BottomInfo({
    required this.memory,
    super.key,
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
            ColorsCustom.black.withOpacity(_gradientOpacity),
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _MemoryTitle(title: memory.title),
          const SizedBox(height: AppIconSizes.small),
          _MemoryDescription(description: memory.description),
          const SizedBox(height: AppIconSizes.xMedium),
          const _ActionButtons(),
        ],
      ),
    );
  }
}

/// Memory title text
final class _MemoryTitle extends StatelessWidget {
  const _MemoryTitle({
    required this.title,
    super.key,
  });

  final String? title;

  static const String _defaultTitle = 'Untitled Memory';

  @override
  Widget build(BuildContext context) {
    return Text(
      title ?? _defaultTitle,
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
    super.key,
  });

  final String? description;

  static const String _defaultDescription = 'No description available';
  static const double _textOpacity = 0.8;

  @override
  Widget build(BuildContext context) {
    return Text(
      description ?? _defaultDescription,
      style: context.general.textTheme.bodyMedium?.copyWith(
        color: ColorsCustom.white.withOpacity(_textOpacity),
      ),
    );
  }
}

/// Action buttons row
final class _ActionButtons extends StatelessWidget {
  const _ActionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        _ShareButton(),
        _FavoriteButton(),
      ],
    );
  }
}

/// Share button
final class _ShareButton extends StatelessWidget {
  const _ShareButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        // TODO: Implement share functionality
      },
      icon: const Icon(
        AppIcons.share,
        color: ColorsCustom.white,
        size: AppIconSizes.medium,
      ),
    );
  }
}

/// Favorite button
final class _FavoriteButton extends StatelessWidget {
  const _FavoriteButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        // TODO: Implement favorite functionality
      },
      icon: const Icon(
        AppIcons.favoriteBorder,
        color: ColorsCustom.white,
        size: AppIconSizes.medium,
      ),
    );
  }
}

/// Individual photo item in the page view
@immutable
final class _PhotoDetailItem extends StatelessWidget {
  const _PhotoDetailItem({
    required this.memory,
    super.key,
  });

  final MemoryModel memory;

  static const double _marginHorizontal = 8;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: _marginHorizontal),
      decoration: const BoxDecoration(
        borderRadius: CustomRadius.medium,
      ),
      child: ClipRRect(
        borderRadius: CustomRadius.medium,
        child: _buildImageContent(),
      ),
    );
  }

  Widget _buildImageContent() {
    final hasImages = memory.imageUrls != null && memory.imageUrls!.isNotEmpty;

    if (hasImages) {
      return CustomNetworkImage(
        imageUrl: memory.imageUrls?.first,
        fit: BoxFit.contain,
      );
    }

    return const _PhotoPlaceholder();
  }
}

/// Placeholder when photo is not available
final class _PhotoPlaceholder extends StatelessWidget {
  const _PhotoPlaceholder({super.key});

  static const String _placeholderText = 'Image not available';

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: ColorsCustom.darkGray,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              AppIcons.gallery,
              color: ColorsCustom.warmGrey,
              size: AppIconSizes.xLarge,
            ),
            const SizedBox(height: AppIconSizes.xMedium),
            Text(
              _placeholderText,
              style: context.general.textTheme.titleMedium?.copyWith(
                color: ColorsCustom.warmGrey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
