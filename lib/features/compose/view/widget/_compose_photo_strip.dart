part of '../compose_view.dart';

class _ComposePhotoStrip extends StatelessWidget {
  const _ComposePhotoStrip({required this.photos, required this.onRemove});

  final List<File> photos;
  final ValueChanged<int> onRemove;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.general.colorScheme;
    return SizedBox(
      height: 96,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: photos.length,
        separatorBuilder: (_, _) => const EmptyBox.smallWidth(),
        itemBuilder: (_, index) {
          final file = photos[index];
          return Stack(
            children: [
              ClipRRect(
                borderRadius: CustomRadius.medium,
                child: SizedBox(
                  width: 96,
                  height: 96,
                  child: Image.file(file, fit: BoxFit.cover),
                ),
              ),
              Positioned(
                top: 4,
                right: 4,
                child: InkWell(
                  onTap: () => onRemove(index),
                  borderRadius: const BorderRadius.all(Radius.circular(99)),
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: colorScheme.onSurface.withValues(alpha: 0.6),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(99),
                      ),
                    ),
                    child: Icon(
                      Icons.close_rounded,
                      size: 14,
                      color: colorScheme.onPrimary,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
