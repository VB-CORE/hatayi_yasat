part of '../compose_view.dart';

class _ComposeKindSegment extends StatelessWidget {
  const _ComposeKindSegment({required this.kind, required this.onChanged});

  final ComposeKind kind;
  final ValueChanged<ComposeKind> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (final k in ComposeKind.values) ...[
          _Chip(
            label: _labelFor(k),
            icon: _iconFor(k),
            active: k == kind,
            onTap: () => onChanged(k),
          ),
          if (k != ComposeKind.values.last) const EmptyBox.smallWidth(),
        ],
      ],
    );
  }

  String _labelFor(ComposeKind k) => switch (k) {
    ComposeKind.post => LocaleKeys.compose_kindPost.tr(),
    ComposeKind.memory => LocaleKeys.compose_kindMemory.tr(),
    ComposeKind.place => LocaleKeys.compose_kindPlace.tr(),
  };

  IconData _iconFor(ComposeKind k) => switch (k) {
    ComposeKind.post => Icons.diversity_3_rounded,
    ComposeKind.memory => Icons.photo_library_rounded,
    ComposeKind.place => Icons.place_rounded,
  };
}

class _Chip extends StatelessWidget {
  const _Chip({
    required this.label,
    required this.icon,
    required this.active,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.general.colorScheme;
    final activeFg = colorScheme.onPrimary;
    final inactiveFg = colorScheme.onPrimaryFixedVariant;
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: CustomRadius.small,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
          decoration: BoxDecoration(
            color: active ? colorScheme.primary : colorScheme.onPrimaryFixed,
            borderRadius: CustomRadius.small,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 16,
                color: active ? activeFg : inactiveFg,
              ),
              const SizedBox(width: 6),
              Flexible(
                child: Text(
                  label,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w700,
                    color: active ? activeFg : inactiveFg,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
