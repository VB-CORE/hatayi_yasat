part of '../merchant_panel_view.dart';

final class MerchantPanelNavigationBar extends StatelessWidget {
  const MerchantPanelNavigationBar({
    required this.hasPendingReply,
    super.key,
  });

  final bool hasPendingReply;

  @override
  Widget build(BuildContext context) {
    final tabController = DefaultTabController.of(context);

    return ListenableBuilder(
      listenable: tabController,
      builder: (context, _) {
        return NavigationBar(
          selectedIndex: tabController.index,
          backgroundColor: context.appColors.surface,
          onDestinationSelected: tabController.animateTo,
          destinations: [
            for (final item in MerchantPanelTab.values)
              NavigationDestination(
                icon: item == MerchantPanelTab.reviews && hasPendingReply
                    ? Badge(
                        backgroundColor: context.appColors.coral,
                        smallSize: AppIconSizes.small,
                        child: Icon(item.icon),
                      )
                    : Icon(item.icon),
                selectedIcon: Icon(
                  item.selectedIcon,
                  color: context.appColors.coral,
                ),
                label: item.label.tr(),
              ),
          ],
        );
      },
    );
  }
}
