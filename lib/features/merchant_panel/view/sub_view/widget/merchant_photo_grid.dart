part of '../merchant_store_edit_sub_view.dart';

const int _photosPerRow = 3;

final class _MerchantPhotoGrid extends StatelessWidget {
  const _MerchantPhotoGrid({
    required this.photos,
    required this.onAdd,
    required this.onReplace,
    required this.onRemove,
  });

  final List<MerchantPhoto> photos;
  final VoidCallback onAdd;
  final ValueChanged<int> onReplace;
  final ValueChanged<int> onRemove;

  @override
  Widget build(BuildContext context) {
    final itemCount =
        photos.length +
        (photos.length < MerchantStoreEditViewModel.maxPhotoCount ? 1 : 0);

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: itemCount,
      padding: EdgeInsets.zero,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: _photosPerRow,
        crossAxisSpacing: AppSpacing.xs,
        mainAxisSpacing: AppSpacing.xs,
      ),
      itemBuilder: (context, index) {
        if (index >= photos.length) return _AddPhotoTile(onTap: onAdd);
        return _PhotoTile(
          photo: photos[index],
          isCover: index == 0,
          onTap: () => onReplace(index),
          onRemove: () => onRemove(index),
        );
      },
    );
  }
}

final class _PhotoTile extends StatelessWidget {
  const _PhotoTile({
    required this.photo,
    required this.isCover,
    required this.onTap,
    required this.onRemove,
  });

  final MerchantPhoto photo;
  final bool isCover;
  final VoidCallback onTap;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(AppRadius.md);
    return Stack(
      fit: StackFit.expand,
      children: [
        ClipRRect(
          borderRadius: borderRadius,
          child: switch (photo) {
            MerchantPhotoUrl(:final url) => CustomNetworkImage(
              imageUrl: url,
              fit: BoxFit.cover,
            ),
            MerchantPhotoFile(:final file) => Image.file(
              file,
              fit: BoxFit.cover,
            ),
          },
        ),
        if (isCover)
          Positioned(
            left: AppSpacing.xxs,
            top: AppSpacing.xxs,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.xs,
                vertical: AppSpacing.xxs,
              ),
              decoration: BoxDecoration(
                color: context.appColors.coral,
                borderRadius: BorderRadius.circular(AppRadius.pill),
              ),
              child: Text(
                LocaleKeys.merchantPanel_store_photoCover.tr(),
                style: AppText.micro.copyWith(
                  color: context.appColors.surface,
                ),
              ),
            ),
          ),
        Material(
          type: MaterialType.transparency,
          child: InkWell(onTap: onTap, borderRadius: borderRadius),
        ),
        Positioned(
          right: 0,
          top: 0,
          child: IconButton(
            onPressed: onRemove,
            tooltip: LocaleKeys.button_delete.tr(),
            style: IconButton.styleFrom(
              backgroundColor: context.appColors.navy700.withValues(
                alpha: .6,
              ),
              foregroundColor: context.appColors.surface,
            ),
            icon: const Icon(AppIcons.close, size: AppIconSizes.xMedium),
          ),
        ),
      ],
    );
  }
}

final class _AddPhotoTile extends StatelessWidget {
  const _AddPhotoTile({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.appColors.ink25,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.md),
        side: BorderSide(color: context.appColors.ink200),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              AppIcons.addPhoto,
              size: AppIconSizes.large,
              color: context.appColors.ink400,
            ),
            Text(
              LocaleKeys.merchantPanel_store_photoAdd.tr(),
              style: AppText.caption,
            ),
          ],
        ),
      ),
    );
  }
}
