part of '../useful_links_view.dart';

final class _LinkCard extends StatelessWidget {
  const _LinkCard({required this.link});

  final UsefulLinksModel link;

  static const double _imageHeight = WidgetSizes.spacingXxl12;
  static const double _placeholderTileSize = WidgetSizes.spacingXs;
  static const double _placeholderTileOpacity = 0.22;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const PagePadding.onlyBottomLow(),
      child: Container(
        decoration: BoxDecoration(
          color: context.appColors.surface,
          borderRadius: BorderRadius.circular(AppRadius.lg),
          border: Border.all(color: context.appColors.ink100),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _LinkImage(image: link.image),
            Padding(
              padding: const PagePadding.generalAllLow(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: AppSpacing.xxs,
                children: [
                  GeneralBodyTitle(
                    link.title ?? '',
                    fontWeight: FontWeight.w800,
                    textAlign: TextAlign.start,
                  ),
                  if (link.content != null)
                    GeneralContentSubTitle(value: link.content!),
                  if (link.link != null) _UrlLine(url: link.link!),
                  _LinkActionsRow(link: link),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

final class _LinkImage extends StatelessWidget {
  const _LinkImage({required this.image});

  final String? image;

  @override
  Widget build(BuildContext context) {
    final url = image;

    return SizedBox(
      height: _LinkCard._imageHeight,
      width: double.infinity,
      child: url == null || url.isEmpty
          ? ColoredBox(
              color: context.appColors.navy,
              child: const MosaicBackground(
                showGradient: false,
                tileSize: _LinkCard._placeholderTileSize,
                tileOpacity: _LinkCard._placeholderTileOpacity,
              ),
            )
          : CustomNetworkImage(imageUrl: url, fit: BoxFit.cover),
    );
  }
}

final class _UrlLine extends StatelessWidget {
  const _UrlLine({required this.url});

  final String url;

  @override
  Widget build(BuildContext context) {
    return Text(
      url,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        color: context.appColors.ink500,
        fontFeatures: const [FontFeature.tabularFigures()],
      ),
    );
  }
}

final class _LinkActionsRow extends StatelessWidget {
  const _LinkActionsRow({required this.link});

  final UsefulLinksModel link;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const PagePadding.onlyTopLow(),
      child: Row(
        spacing: AppSpacing.sm,
        children: [
          Expanded(
            child: GeneralButtonV2.active(
              action: () => LinkActions.openUrl(context, link.link),
              label: LocaleKeys.usefulLink_openSite.tr(),
              icon: AppIcons.link,
              backgroundColor: context.appColors.navy,
            ),
          ),
          Expanded(
            child: OutlineActionButton(
              labelKey: LocaleKeys.general_action_copy,
              icon: AppIcons.copy,
              onPressed: () => LinkActions.copy(context, link.link),
            ),
          ),
        ],
      ),
    );
  }
}
