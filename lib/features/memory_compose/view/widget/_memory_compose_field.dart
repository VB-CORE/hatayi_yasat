part of '../memory_compose_view.dart';

class _MemoryComposeField extends StatelessWidget {
  const _MemoryComposeField({
    required this.label,
    required this.controller,
    this.maxLines = 1,
    this.keyboardType,
  });

  final String label;
  final TextEditingController controller;
  final int maxLines;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.general.colorScheme;
    final textTheme = context.general.textTheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: textTheme.labelMedium?.copyWith(
              color: colorScheme.onPrimaryFixedVariant,
              fontWeight: FontWeight.w700,
            ),
          ),
          const EmptyBox.smallHeight(),
          TextField(
            controller: controller,
            maxLines: maxLines,
            keyboardType: keyboardType,
            decoration: InputDecoration(
              filled: true,
              fillColor: colorScheme.secondary,
              border: const OutlineInputBorder(
                borderRadius: CustomRadius.medium,
                borderSide: BorderSide.none,
              ),
            ),
            style: textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}
