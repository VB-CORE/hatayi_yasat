part of '../notification_permission_view.dart';

/// Fake preview notification card stacked inside the navy hero. Mirrors
/// the V2 jsx tiles — translucent white pill with a coloured icon square.
final class _NotifPreviewCard extends StatelessWidget {
  const _NotifPreviewCard({
    required this.icon,
    required this.accent,
    required this.text,
    required this.offset,
  });

  final IconData icon;
  final Color accent;
  final String text;
  final int offset;

  @override
  Widget build(BuildContext context) {
    final scale = 1 - offset * 0.03;
    final opacity = 1 - offset * 0.2;
    return Transform.translate(
      offset: Offset(offset * 8.0, 0),
      child: Transform.scale(
        alignment: Alignment.centerLeft,
        scale: scale,
        child: Opacity(
          opacity: opacity,
          child: Container(
            padding: const EdgeInsets.fromLTRB(10, 10, 14, 10),
            decoration: BoxDecoration(
              // Brand-locked translucent white on the navy hero.
              color: ColorsCustom.white.withValues(alpha: 0.12),
              borderRadius: CustomRadius.medium,
              border: Border.all(
                color: ColorsCustom.white.withValues(alpha: 0.12),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: accent,
                    borderRadius: CustomRadius.small,
                  ),
                  child: Icon(
                    icon,
                    size: 16,
                    // Brand-locked white glyph on coloured chip.
                    color: ColorsCustom.white,
                  ),
                ),
                const EmptyBox(width: 10),
                Expanded(
                  child: Text(
                    text,
                    style: V2Typography.label(
                      // Brand-locked white text on navy hero.
                      color: ColorsCustom.white,
                      fontWeight: FontWeight.w600,
                    ),
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
