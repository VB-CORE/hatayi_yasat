import 'package:flutter/material.dart';
import 'package:lifeclient/product/model/social/sample_social_data.dart';
import 'package:lifeclient/product/init/application_theme.dart';
import 'package:lifeclient/product/utility/decorations/colors_custom.dart';
import 'package:lifeclient/product/widget/brand/hy_logo.dart';

/// V2 top bar — logo + city full name + city switcher dot + search + bell.
class V2TopBar extends StatelessWidget implements PreferredSizeWidget {
  const V2TopBar({
    super.key,
    this.cityId = 'hatay',
    this.hasUnread = true,
    this.onCity,
    this.onSearch,
    this.onNotifications,
  });

  final String cityId;
  final bool hasUnread;
  final VoidCallback? onCity;
  final VoidCallback? onSearch;
  final VoidCallback? onNotifications;

  @override
  Size get preferredSize => const Size.fromHeight(64);

  @override
  Widget build(BuildContext context) {
    final city = V2SampleData.cityById(cityId);
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: const BoxDecoration(
        color: ColorsCustom.white,
        border: Border(
          bottom: BorderSide(color: ColorsCustom.ink50),
        ),
      ),
      child: Row(
        children: [
          const HyLogo(),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  city.fullName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: V2Typography.display(
                    fontSize: 17,
                    color: ColorsCustom.navy,
                  ),
                ),
                const SizedBox(height: 2),
                InkWell(
                  onTap: onCity,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.location_on_rounded,
                        size: 12,
                        color: ColorsCustom.coral,
                      ),
                      const SizedBox(width: 2),
                      Text(
                        city.name,
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: ColorsCustom.ink500,
                        ),
                      ),
                      const Icon(
                        Icons.expand_more_rounded,
                        size: 14,
                        color: ColorsCustom.ink400,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          _IconBtn(icon: Icons.search_rounded, onTap: onSearch),
          _IconBtn(
            icon: Icons.notifications_rounded,
            onTap: onNotifications,
            badge: hasUnread,
          ),
        ],
      ),
    );
  }
}

class _IconBtn extends StatelessWidget {
  const _IconBtn({required this.icon, this.onTap, this.badge = false});

  final IconData icon;
  final VoidCallback? onTap;
  final bool badge;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: SizedBox(
        width: 38,
        height: 38,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Icon(icon, size: 20, color: ColorsCustom.ink700),
            if (badge)
              const Positioned(
                top: 8,
                right: 8,
                child: _Dot(),
              ),
          ],
        ),
      ),
    );
  }
}

class _Dot extends StatelessWidget {
  const _Dot();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        color: ColorsCustom.coral,
        shape: BoxShape.circle,
        border: Border.all(color: ColorsCustom.white, width: 2),
      ),
    );
  }
}
