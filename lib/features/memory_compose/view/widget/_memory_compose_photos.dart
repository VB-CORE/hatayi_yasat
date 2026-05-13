part of '../memory_compose_view.dart';

class _MemoryComposePhotos extends StatelessWidget {
  const _MemoryComposePhotos({
    required this.photos,
    required this.onAdd,
    required this.onRemove,
  });

  final List<File> photos;
  final Future<void> Function() onAdd;
  final ValueChanged<int> onRemove;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.general.colorScheme;
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        for (var i = 0; i < photos.length; i++)
          _Tile(file: photos[i], onRemove: () => onRemove(i)),
        InkWell(
          onTap: () => onAdd(),
          borderRadius: CustomRadius.medium,
          child: Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: colorScheme.onPrimaryFixed,
              borderRadius: CustomRadius.medium,
              border: Border.all(color: colorScheme.onPrimaryContainer),
            ),
            child: Icon(
              Icons.add_a_photo_outlined,
              color: colorScheme.primary,
            ),
          ),
        ),
      ],
    );
  }
}

class _Tile extends StatelessWidget {
  const _Tile({required this.file, required this.onRemove});

  final File file;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.general.colorScheme;
    return Stack(
      children: [
        ClipRRect(
          borderRadius: CustomRadius.medium,
          child: SizedBox(
            width: 80,
            height: 80,
            child: Image.file(file, fit: BoxFit.cover),
          ),
        ),
        Positioned(
          top: 4,
          right: 4,
          child: InkWell(
            onTap: onRemove,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: colorScheme.onSurface.withValues(alpha: 0.6),
                borderRadius: const BorderRadius.all(Radius.circular(99)),
              ),
              child: Icon(
                Icons.close_rounded,
                size: 12,
                color: colorScheme.surface,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
