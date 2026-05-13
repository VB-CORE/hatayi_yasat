part of '../notification_permission_view.dart';

/// 300h navy gradient hero with MosaicGrid overlay + 3 fake preview
/// notification cards. Mirrors the V2 `V2NotifPermission` hero block.
final class _NotifPermissionHero extends StatelessWidget {
  const _NotifPermissionHero();

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 300,
      width: double.infinity,
      child: DecoratedBox(
        decoration: BoxDecoration(
          // Brand-locked navy hero gradient (navy → navy600).
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [ColorsCustom.navy, ColorsCustom.navy600],
          ),
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: MosaicGrid(tileSize: 16, opacity: 0.28),
            ),
            SafeArea(
              bottom: false,
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _NotifPreviewCard(
                      icon: Icons.storefront_rounded,
                      // Brand-locked coral accent — onboarding tile chrome.
                      accent: ColorsCustom.coral,
                      text: 'Yeni mekan: Künefeci Saim Usta · Antakya',
                      offset: 0,
                    ),
                    EmptyBox(height: 8),
                    _NotifPreviewCard(
                      icon: Icons.event_rounded,
                      // Brand-locked teal accent — onboarding tile chrome.
                      accent: ColorsCustom.teal,
                      text: 'Yarın 18:00 · Hatay Mozaik Festivali',
                      offset: 1,
                    ),
                    EmptyBox(height: 8),
                    _NotifPreviewCard(
                      icon: Icons.campaign_rounded,
                      // Brand-locked memorial gold accent.
                      accent: ColorsCustom.gold,
                      text: '500 mekan milestone — teşekkürler!',
                      offset: 2,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
