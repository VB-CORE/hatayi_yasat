import 'package:flutter/material.dart';
import 'package:lifeclient/product/utility/decorations/colors_custom.dart';

enum V2NavTab { home, places, favorites, profile }

/// V2 bottom navigation — 4 tabs + a centered coral add button.
/// Mirrors the V2 design `V2BottomNav`. Add button floats up via
/// negative translation; the surrounding bar keeps room for it.
class V2BottomNav extends StatelessWidget {
  const V2BottomNav({
    super.key,
    this.active = V2NavTab.home,
    this.onChanged,
    this.onAdd,
  });

  final V2NavTab active;
  final ValueChanged<V2NavTab>? onChanged;
  final VoidCallback? onAdd;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 22),
      decoration: const BoxDecoration(
        color: ColorsCustom.white,
        border: Border(top: BorderSide(color: ColorsCustom.ink50)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _NavTile(
            icon: Icons.home_rounded,
            label: 'Akış',
            active: active == V2NavTab.home,
            onTap: () => onChanged?.call(V2NavTab.home),
          ),
          _NavTile(
            icon: Icons.storefront_rounded,
            label: 'Mekanlar',
            active: active == V2NavTab.places,
            onTap: () => onChanged?.call(V2NavTab.places),
          ),
          _AddBtn(onTap: onAdd),
          _NavTile(
            icon: Icons.favorite_rounded,
            label: 'Favoriler',
            active: active == V2NavTab.favorites,
            onTap: () => onChanged?.call(V2NavTab.favorites),
          ),
          _NavTile(
            icon: Icons.person_rounded,
            label: 'Profil',
            active: active == V2NavTab.profile,
            onTap: () => onChanged?.call(V2NavTab.profile),
          ),
        ],
      ),
    );
  }
}

class _NavTile extends StatelessWidget {
  const _NavTile({
    required this.icon,
    required this.label,
    required this.active,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final tint = active ? ColorsCustom.navy : ColorsCustom.ink400;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 22, color: tint),
            const SizedBox(height: 3),
            Text(
              label,
              style: TextStyle(
                fontSize: 10.5,
                color: tint,
                fontWeight: active ? FontWeight.w700 : FontWeight.w600,
                letterSpacing: 0.1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AddBtn extends StatelessWidget {
  const _AddBtn({this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: const Offset(0, -12),
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: ColorsCustom.coral,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: ColorsCustom.coral.withValues(alpha: 0.33),
                blurRadius: 18,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: const Icon(Icons.add_rounded, color: Colors.white, size: 26),
        ),
      ),
    );
  }
}
