part of '../merchant_panel_view.dart';

final class MerchantPanelPinnedHeader extends StatelessWidget {
  const MerchantPanelPinnedHeader({
    required this.storeId,
    super.key,
  });

  final String storeId;

  @override
  Widget build(BuildContext context) {
    final tabController = DefaultTabController.of(context);

    return ListenableBuilder(
      listenable: tabController,
      builder: (context, _) {
        return switch (MerchantPanelTab.values[tabController.index]) {
          MerchantPanelTab.reviews => MerchantReviewFilterBar(storeId: storeId),
          _ => const SizedBox.shrink(),
        };
      },
    );
  }
}
