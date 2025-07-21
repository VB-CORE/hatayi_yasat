part of '../history_view.dart';

@immutable
final class _PhotoDetailSheet extends ConsumerStatefulWidget {
  const _PhotoDetailSheet({
    required this.memory,
    required this.allMemories,
    required this.initialIndex,
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
      height: context.sized.dynamicHeight(0.9),
      decoration: const BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: _buildPhotoPageView(),
          ),
          _buildBottomInfo(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '${_currentIndex + 1} / ${widget.allMemories.length}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(
              Icons.close,
              color: Colors.white,
              size: 28,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPhotoPageView() {
    return PageView.builder(
      controller: _pageController,
      onPageChanged: (index) {
        setState(() {
          _currentIndex = index;
        });
        ref
            .read(historyViewModelProvider.notifier)
            .updateSelectedMemoryIndex(index);
      },
      itemCount: widget.allMemories.length,
      itemBuilder: (context, index) {
        return _PhotoDetailItem(memory: widget.allMemories[index]);
      },
    );
  }

  Widget _buildBottomInfo() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.transparent,
            Colors.black.withOpacity(0.7),
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            currentMemory.title ?? 'Untitled Memory',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            currentMemory.description ?? 'No description available',
            style: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              IconButton(
                onPressed: () {
                  // TODO: Implement share functionality
                },
                icon: const Icon(
                  Icons.share,
                  color: Colors.white,
                ),
              ),
              IconButton(
                onPressed: () {
                  // TODO: Implement favorite functionality
                },
                icon: const Icon(
                  Icons.favorite_border,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

@immutable
final class _PhotoDetailItem extends StatelessWidget {
  const _PhotoDetailItem({required this.memory});

  final MemoryModel memory;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: memory.imageUrl != null && memory.imageUrl!.isNotEmpty
            ? CustomNetworkImage(
                imageUrl: memory.imageUrl,
                fit: BoxFit.contain,
              )
            : Container(
                color: Colors.grey[800],
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.broken_image,
                        color: Colors.grey[400],
                        size: 80,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Image not available',
                        style: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
