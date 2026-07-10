part of '../group_detail_sliver_header.dart';

final class _HeaderToolbar extends StatelessWidget {
  const _HeaderToolbar({required this.model, required this.titleOpacity});

  final GroupModel model;
  final double titleOpacity;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const _BackButton(),
        const EmptyBox.smallWidth(),
        Expanded(
          child: Opacity(
            opacity: titleOpacity,
            child: GeneralContentTitle(
              value: model.name,
              fontWeight: FontWeight.w700,
              maxLine: AppConstants.kOne,
            ),
          ),
        ),
        if (model.isCurrentUserAdmin)
          const Padding(
            padding: PagePadding.onlyRight(),
            child: _AdminBadge(),
          ),
      ],
    );
  }
}

final class _BackButton extends StatelessWidget {
  const _BackButton();

  static const double _backgroundOpacity = 0.4;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const PagePadding.allVeryLow(),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.navy900.withValues(
            alpha: _backgroundOpacity,
          ),
          shape: const CircleBorder(),
          padding: EdgeInsets.zero,
        ),
        onPressed: () => context.pop(),
        child: const Icon(AppIcons.arrowBack, color: AppColors.white),
      ),
    );
  }
}

final class _AdminBadge extends StatelessWidget {
  const _AdminBadge();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: DecoratedBox(
        decoration: const BoxDecoration(
          color: AppColors.coral,
          borderRadius: CustomRadius.xxLarge,
        ),
        child: Padding(
          padding: const PagePadding.horizontalLowVerticalVeryLowSymmetric(),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                AppIcons.lockPerson,
                size: AppIconSizes.smallX,
                color: AppColors.white,
              ),
              const EmptyBox(width: WidgetSizes.spacingXxs),
              GeneralContentSmallTitle(
                value: LocaleKeys.community_groupDetail_adminBadge.tr(),
                color: AppColors.white,
                fontWeight: FontWeight.w700,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

final class _HeaderTab extends StatelessWidget {
  const _HeaderTab({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: AppIconSizes.xMedium),
          const EmptyBox(width: WidgetSizes.spacingXxs),
          Text(label),
        ],
      ),
    );
  }
}
