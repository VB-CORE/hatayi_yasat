import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart' show ContextExtension;
import 'package:lifeclient/product/init/application_theme.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/navigation/app_router.dart';
import 'package:lifeclient/product/utility/decorations/colors_custom.dart';
import 'package:lifeclient/product/utility/decorations/custom_radius.dart';
import 'package:lifeclient/product/utility/decorations/empty_box.dart';
import 'package:lifeclient/product/widget/brand/hy_logo.dart';
import 'package:lifeclient/product/widget/brand/mosaic_grid.dart';

part 'widget/_login_hero_lockup.dart';
part 'widget/_login_headline_block.dart';
part 'widget/_login_oauth_buttons.dart';
part 'widget/_login_kvkk_footer.dart';

/// V2 mozaik login screen. FirebaseAuth is NOT wired yet — OAuth buttons
/// show a "Yakında" SnackBar; the guest link navigates straight into
/// [MainTabRoute] using the `'guest'` stub from `_auth_session.dart`.
final class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Brand-locked navy hero — V2 keeps the auth surface dark in both
      // light and dark mode, so we read raw brand tokens here.
      backgroundColor: ColorsCustom.navy,
      body: Stack(
        fit: StackFit.expand,
        children: [
          const Positioned.fill(
            child: MosaicGrid(tileSize: 16, opacity: 0.25),
          ),
          const DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  // Brand-locked hero gradient (navy → navy600).
                  ColorsCustom.navy,
                  ColorsCustom.navy600,
                ],
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 20, 24, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _LoginHeroLockup(),
                  const Spacer(),
                  const _LoginHeadlineBlock(),
                  const EmptyBox(height: 28),
                  _LoginOAuthButtons(
                    onGoogle: () => _showComingSoon(context),
                    onApple: () => _showComingSoon(context),
                    onGuest: () => const MainTabRoute().go(context),
                  ),
                  const EmptyBox(height: 12),
                  const _LoginKvkkFooter(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showComingSoon(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(LocaleKeys.auth_comingSoon.tr())),
    );
  }
}
