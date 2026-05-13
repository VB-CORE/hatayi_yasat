part of '../compose_view.dart';

class _ComposeToolbar extends StatelessWidget {
  const _ComposeToolbar({
    required this.controller,
    required this.maxLength,
    required this.onPickPhoto,
    required this.onPickPlace,
  });

  final TextEditingController controller;
  final int maxLength;
  final Future<void> Function() onPickPhoto;
  final Future<void> Function() onPickPlace;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.general.colorScheme;
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          color: colorScheme.secondary,
          border: Border(
            top: BorderSide(color: colorScheme.onPrimaryContainer),
          ),
        ),
        padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
        child: Row(
          children: [
            _ToolButton(
              icon: Icons.image_rounded,
              onTap: () => onPickPhoto(),
            ),
            const EmptyBox(width: 12),
            _ToolButton(
              icon: Icons.place_rounded,
              onTap: () => onPickPlace(),
            ),
            const EmptyBox(width: 12),
            const _ToolButton(icon: Icons.tag_rounded),
            const Spacer(),
            AnimatedBuilder(
              animation: controller,
              builder: (_, _) {
                final remaining = maxLength - controller.text.length;
                final tint = remaining < 30
                    ? colorScheme.error
                    : colorScheme.onSecondaryFixed;
                return Text(
                  '$remaining',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: tint,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _ToolButton extends StatelessWidget {
  const _ToolButton({required this.icon, this.onTap});

  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.general.colorScheme;
    return InkWell(
      onTap: onTap,
      borderRadius: CustomRadius.small,
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: colorScheme.onPrimaryFixed,
          borderRadius: CustomRadius.small,
        ),
        child: Icon(icon, size: 18, color: colorScheme.primary),
      ),
    );
  }
}
