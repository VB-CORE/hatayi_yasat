part of '../history_view.dart';

@immutable
final class _HistoryInfoDialog extends StatelessWidget {
  const _HistoryInfoDialog();

  @override
  Widget build(BuildContext context) {
    return const AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: CustomRadius.large,
      ),
      title: _DialogTitle(),
      content: _DialogContent(),
      actions: [
        _DialogAction(),
      ],
    );
  }
}

/// Dialog title with icon and text
final class _DialogTitle extends StatelessWidget {
  const _DialogTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(
          AppIcons.photoLibrary,
          color: ColorsCustom.brandeisBlue,
          size: AppIconSizes.large,
        ),
        const SizedBox(width: AppIconSizes.smallX),
        Expanded(
          child: Text(
            'Hatıra Ormanı',
            style: context.general.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}

/// Dialog content with image placeholder and description
final class _DialogContent extends StatelessWidget {
  const _DialogContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _ImagePlaceholder(),
        SizedBox(height: AppIconSizes.xMedium),
        _DescriptionText(),
        SizedBox(height: AppIconSizes.smallX),
        _InfoBox(),
      ],
    );
  }
}

/// Dummy image placeholder container
final class _ImagePlaceholder extends StatelessWidget {
  const _ImagePlaceholder({super.key});

  static const double _containerHeight = 150;
  static const double _borderWidth = 2;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: _containerHeight,
      decoration: const BoxDecoration(
        color: ColorsCustom.gray,
        borderRadius: CustomRadius.medium,
        border: Border.fromBorderSide(
          BorderSide(
            color: ColorsCustom.lightGray,
            width: _borderWidth,
          ),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            AppIcons.collections,
            size: AppIconSizes.xLarge,
            color: ColorsCustom.warmGrey,
          ),
          Padding(
            padding: const PagePadding.onlyTopLow(),
            child: Text(
              'Dummy Image',
              style: context.general.textTheme.bodyMedium?.copyWith(
                color: ColorsCustom.darkGray,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Text(
            '(Sonra güncellenecek)',
            style: context.general.textTheme.bodySmall?.copyWith(
              color: ColorsCustom.warmGrey,
            ),
          ),
        ],
      ),
    );
  }
}

/// Main description text
final class _DescriptionText extends StatelessWidget {
  const _DescriptionText({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      LocaleKeys.historyPage_welcomeDescription.tr(),
      style: context.general.textTheme.bodyMedium,
      textAlign: TextAlign.center,
    );
  }
}

/// Info box with add photo information
final class _InfoBox extends StatelessWidget {
  const _InfoBox({super.key});

  static const double _opacity = 0.1;
  static const double _borderOpacity = 0.3;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const PagePadding.generalAllLow(),
      decoration: BoxDecoration(
        color: ColorsCustom.brandeisBlue.withOpacity(_opacity),
        borderRadius: CustomRadius.small,
        border: Border.all(
          color: ColorsCustom.brandeisBlue.withOpacity(_borderOpacity),
        ),
      ),
      child: Row(
        children: [
          const Icon(
            AppIcons.addPhoto,
            color: ColorsCustom.brandeisBlue,
            size: AppIconSizes.medium,
          ),
          const SizedBox(width: AppIconSizes.small),
          Expanded(
            child: Text(
              LocaleKeys.historyPage_addPhotoInfo.tr(),
              style: context.general.textTheme.bodySmall?.copyWith(
                color: ColorsCustom.brandeisBlue,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Dialog action button
final class _DialogAction extends StatelessWidget {
  const _DialogAction({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => Navigator.of(context).pop(),
      child: Text(
        LocaleKeys.button_understood.tr(),
        style: context.general.textTheme.labelLarge?.copyWith(
          color: ColorsCustom.brandeisBlue,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
