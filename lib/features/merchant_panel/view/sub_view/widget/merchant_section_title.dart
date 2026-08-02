part of '../merchant_store_edit_sub_view.dart';

final class _MerchantSectionTitle extends StatelessWidget {
  const _MerchantSectionTitle({
    required this.icon,
    required this.title,
    this.subtitle,
  });

  final IconData icon;
  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    final subtitle = this.subtitle;
    return Padding(
      padding: const PagePadding.verticalLowSymmetric(),
      child: Row(
        spacing: AppSpacing.xs,
        children: [
          Icon(icon, size: AppIconSizes.medium, color: context.appColors.coral),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppText.title),
                if (subtitle != null) Text(subtitle, style: AppText.caption),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
