import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart' show ContextExtension;
import 'package:lifeclient/product/init/application_theme.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/navigation/app_router.dart';
import 'package:lifeclient/product/utility/decorations/colors_custom.dart';
import 'package:lifeclient/product/utility/decorations/custom_radius.dart';
import 'package:lifeclient/product/utility/decorations/empty_box.dart';
import 'package:lifeclient/product/widget/brand/eyebrow.dart';
import 'package:lifeclient/product/widget/brand/mosaic_grid.dart';

part 'widget/_notif_permission_hero.dart';
part 'widget/_notif_permission_body.dart';
part 'widget/_notif_permission_preview_card.dart';

/// V2 mozaik notification-permission onboarding screen.
///
/// Shows 2-3 stacked preview cards inside a navy hero, then asks for
/// `firebase_messaging` permission on the primary CTA. Both CTAs send
/// the user to [MainTabRoute] — denying the permission only surfaces a
/// SnackBar so the user knows they can re-enable from Settings later.
final class NotificationPermissionView extends StatefulWidget {
  const NotificationPermissionView({super.key});

  @override
  State<NotificationPermissionView> createState() =>
      _NotificationPermissionViewState();
}

class _NotificationPermissionViewState
    extends State<NotificationPermissionView> {
  bool _requesting = false;

  Future<void> _onAllow() async {
    if (_requesting) return;
    setState(() => _requesting = true);
    final settings = await FirebaseMessaging.instance.requestPermission();
    if (!mounted) return;
    final granted =
        settings.authorizationStatus == AuthorizationStatus.authorized ||
        settings.authorizationStatus == AuthorizationStatus.provisional;
    if (!granted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(LocaleKeys.auth_comingSoon.tr())),
      );
    }
    setState(() => _requesting = false);
    if (!mounted) return;
    const MainTabRoute().go(context);
  }

  void _onSkip() => const MainTabRoute().go(context);

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.general.colorScheme;
    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            const _NotifPermissionHero(),
            Expanded(
              child: _NotifPermissionBody(
                requesting: _requesting,
                onAllow: _onAllow,
                onSkip: _onSkip,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
