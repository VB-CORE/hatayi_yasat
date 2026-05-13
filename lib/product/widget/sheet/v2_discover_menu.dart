import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart' show ContextExtension;
import 'package:lifeclient/product/init/application_theme.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/navigation/app_router.dart';
import 'package:lifeclient/product/utility/decorations/custom_radius.dart';
import 'package:lifeclient/product/utility/decorations/empty_box.dart';
import 'package:lifeclient/product/widget/brand/eyebrow.dart';
import 'package:lifeclient/product/widget/brand/hy_logo.dart';

/// V3 Keşfet menu — top-anchored overlay card with the four cross-feature
/// destinations (Özel Kurumlar / Konteyner Çarşılar / Turistik Yerler /
/// Faydalı Linkler). Mirrors `V3DiscoverMenu` from the design package.
///
/// Three of the four destinations already have routes; "Konteyner
/// Çarşılar" pops [ContainerMarketsRoute].
Future<void> showV2DiscoverMenu(BuildContext context) async {
  await showGeneralDialog<void>(
    context: context,
    barrierColor: const Color(0x8C0F2A47),
    barrierDismissible: true,
    barrierLabel: 'Keşfet',
    transitionDuration: const Duration(milliseconds: 220),
    pageBuilder: (_, __, ___) => const _DiscoverMenuBody(),
    transitionBuilder: (_, animation, __, child) {
      final curved = CurvedAnimation(
        parent: animation,
        curve: Curves.easeOutCubic,
      );
      return FadeTransition(
        opacity: curved,
        child: SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, -0.04),
            end: Offset.zero,
          ).animate(curved),
          child: child,
        ),
      );
    },
  );
}

class _DiscoverMenuBody extends StatelessWidget {
  const _DiscoverMenuBody();

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.general.colorScheme;
    return SafeArea(
      child: Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
          child: Material(
            color: colorScheme.secondary,
            borderRadius: CustomRadius.large,
            clipBehavior: Clip.antiAlias,
            elevation: 12,
            shadowColor: const Color(0x4D0F2A47),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 14, 8, 14),
                  child: Row(
                    children: [
                      const HyLogo(size: 32),
                      const EmptyBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              LocaleKeys.discover_title.tr(),
                              style: V2Typography.display(
                                fontSize: 17,
                                color: colorScheme.primary,
                              ),
                            ),
                            const EmptyBox(height: 2),
                            Eyebrow(
                              LocaleKeys.discover_eyebrow.tr(),
                              fontSize: 10.5,
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        key: const Key('discoverMenuClose'),
                        onPressed: () => Navigator.of(context).pop(),
                        icon: Icon(
                          Icons.close_rounded,
                          color: colorScheme.onSecondaryFixed,
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  height: 1,
                  thickness: 1,
                  color: colorScheme.onPrimaryContainer.withValues(alpha: 0.5),
                ),
                _DiscoverRow(
                  icon: Icons.account_balance_rounded,
                  iconColor: colorScheme.primary,
                  label: LocaleKeys.discover_agencyLabel.tr(),
                  description: LocaleKeys.discover_agencyDesc.tr(),
                  onTap: () {
                    Navigator.of(context).pop();
                    const SpecialAgencyRoute().push<void>(context);
                  },
                ),
                _DiscoverRow(
                  icon: Icons.inventory_2_rounded,
                  iconColor: colorScheme.error,
                  label: LocaleKeys.discover_containerLabel.tr(),
                  description: LocaleKeys.discover_containerDesc.tr(),
                  onTap: () {
                    Navigator.of(context).pop();
                    const ContainerMarketsRoute().push<void>(context);
                  },
                ),
                _DiscoverRow(
                  icon: Icons.photo_camera_rounded,
                  iconColor: colorScheme.onSecondaryContainer,
                  label: LocaleKeys.discover_tourismLabel.tr(),
                  description: LocaleKeys.discover_tourismDesc.tr(),
                  onTap: () {
                    Navigator.of(context).pop();
                    const TurismRoute().push<void>(context);
                  },
                ),
                _DiscoverRow(
                  icon: Icons.link_rounded,
                  iconColor: colorScheme.primaryContainer,
                  label: LocaleKeys.discover_linksLabel.tr(),
                  description: LocaleKeys.discover_linksDesc.tr(),
                  isLast: true,
                  onTap: () {
                    Navigator.of(context).pop();
                    const UsefulLinksRoute().push<void>(context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

final class _DiscoverRow extends StatelessWidget {
  const _DiscoverRow({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.description,
    required this.onTap,
    this.isLast = false,
  });

  final IconData icon;
  final Color iconColor;
  final String label;
  final String description;
  final VoidCallback onTap;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.general.colorScheme;
    final textTheme = context.general.textTheme;
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isLast
                  ? Colors.transparent
                  : colorScheme.onPrimaryContainer.withValues(alpha: 0.5),
            ),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: iconColor,
                borderRadius: CustomRadius.medium,
              ),
              child: Icon(icon, size: 20, color: colorScheme.onPrimary),
            ),
            const EmptyBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: textTheme.titleSmall?.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      color: colorScheme.onSurface,
                    ),
                  ),
                  const EmptyBox(height: 2),
                  Text(
                    description,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.bodySmall?.copyWith(
                      fontSize: 11.5,
                      color: colorScheme.onSecondaryFixed,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right_rounded,
              color: colorScheme.onSecondaryFixed,
            ),
          ],
        ),
      ),
    );
  }
}
