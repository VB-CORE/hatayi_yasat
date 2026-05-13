part of '../compose_view.dart';

class _ComposePlacePickerButton extends StatelessWidget {
  const _ComposePlacePickerButton({required this.place, required this.onClear});

  final ComposePlaceTag? place;
  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.general.colorScheme;
    final p = place;
    if (p == null) return const SizedBox.shrink();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: colorScheme.error.withValues(alpha: 0.12),
        borderRadius: const BorderRadius.all(Radius.circular(99)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.place_rounded, size: 14, color: colorScheme.error),
          const SizedBox(width: 4),
          Text(
            '${p.name} · ${p.district}',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: colorScheme.error,
            ),
          ),
          const SizedBox(width: 4),
          InkWell(
            onTap: onClear,
            borderRadius: const BorderRadius.all(Radius.circular(99)),
            child: Icon(
              Icons.close_rounded,
              size: 14,
              color: colorScheme.error,
            ),
          ),
        ],
      ),
    );
  }
}
