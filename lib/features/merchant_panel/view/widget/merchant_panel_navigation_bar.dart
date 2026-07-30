part of '../merchant_panel_view.dart';

final class MerchantPanelNavigationBar extends StatelessWidget {
  const MerchantPanelNavigationBar({
    required this.tab,
    required this.hasPendingReply,
    required this.onChanged,
    super.key,
  });

  final MerchantPanelTab tab;
  final bool hasPendingReply;
  final ValueChanged<MerchantPanelTab> onChanged;

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: tab.index,
      backgroundColor: context.appColors.surface,
      onDestinationSelected: (index) =>
          onChanged(MerchantPanelTab.values[index]),
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
  }
}
