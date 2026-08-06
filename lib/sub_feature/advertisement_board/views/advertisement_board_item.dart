part of 'advertisement_slider.dart';

final class _AdvertisementItem extends StatelessWidget {
  const _AdvertisementItem(this.item);

  final AdBoardModel item;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async => _onPressed(context),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppRadius.xl),
        child: SizedBox.expand(
          child: CustomNetworkImage(
            imageUrl: item.image,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Future<void> _onPressed(BuildContext context) async {
    final link = item.link;
    if (link.ext.isNullOrEmpty) {
      return;
    }

    return showModalBottomSheet<void>(
      builder: (_) => _AdvertisementDetailView(item),
      context: context,
    );
  }
}

final class _HouseAdCard extends StatelessWidget {
  const _HouseAdCard();

  static const String _contactEmail = 'medya@hatayiyasat.app';

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.coral,
        borderRadius: BorderRadius.circular(AppRadius.xl),
        boxShadow: AppShadows.card,
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              LocaleKeys.advertisementBoard_houseAdTitle.tr(),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: AppText.label.copyWith(
                color: AppColors.white,
                fontSize: 20,
                height: 1.05,
                fontWeight: FontWeight.w900,
              ),
            ),
            Text(
              LocaleKeys.advertisementBoard_houseAdSubtitle.tr(),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: AppText.caption.copyWith(
                color: AppColors.white.withValues(alpha: 0.9),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _ContactButton(onTap: _launchContact),
                const _HouseAdLogo(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _launchContact() async {
    await launchUrl(Uri(scheme: 'mailto', path: _contactEmail));
  }
}

final class _ContactButton extends StatelessWidget {
  const _ContactButton({required this.onTap});

  final Future<void> Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(AppRadius.pill),
      child: InkWell(
        borderRadius: BorderRadius.circular(AppRadius.pill),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.sm,
            vertical: AppSpacing.xs,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.campaign_outlined,
                size: 18,
                color: AppColors.coral,
              ),
              const SizedBox(width: AppSpacing.xs),
              Text(
                LocaleKeys.advertisementBoard_contactUs.tr(),
                style: AppText.label.copyWith(color: AppColors.coral),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

final class _HouseAdLogo extends StatelessWidget {
  const _HouseAdLogo();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      padding: const EdgeInsets.all(AppSpacing.xxs),
      decoration: BoxDecoration(
        color: AppColors.gold300,
        borderRadius: BorderRadius.circular(AppRadius.sm),
      ),
      child: Assets.icons.icAppTransparent.image(fit: BoxFit.contain),
    );
  }
}
