part of '../merchant_panel_view.dart';

final class MerchantPanelPinnedHeader extends StatelessWidget {
  const MerchantPanelPinnedHeader({
    required this.tab,
    required this.storeId,
    super.key,
  });

  final MerchantPanelTab tab;
  final String storeId;

  @override
  Widget build(BuildContext context) {
    return switch (tab) {
      MerchantPanelTab.reviews => MerchantReviewFilterBar(storeId: storeId),
      _ => const SizedBox.shrink(),
    };
  }
}
