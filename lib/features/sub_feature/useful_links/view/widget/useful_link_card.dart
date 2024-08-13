part of '../useful_links_view.dart';

@immutable
final class UsefulLinkCard extends StatelessWidget {
  const UsefulLinkCard({
    required this.model,
    super.key,
  });

  final UsefulLinksModel model;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.sized.dynamicHeight(0.3),
      child: InkWell(
        onTap: () => model.link.ext.launchWebsite,
        child: Stack(
          children: [
            Positioned.fill(
              child: _Image(model: model),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: _TransparentBox(model: model),
            ),
          ],
        ),
      ),
    );
  }
}

final class _Image extends StatelessWidget {
  const _Image({
    required this.model,
  });

  final UsefulLinksModel model;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: ValueKey(model.documentId),
      child: ClipRRect(
        borderRadius: CustomRadius.large,
        child: CustomNetworkImage(
          imageUrl: model.image,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _TransparentBox extends StatelessWidget {
  const _TransparentBox({required this.model});

  final UsefulLinksModel model;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.black45,
      shape: const RoundedRectangleBorder(
        borderRadius: CustomRadius.large,
      ),
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const PagePadding.horizontalLowSymmetric() +
            const PagePadding.verticalLowSymmetric(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GeneralContentTitle(
              value: model.title ?? '',
              maxLine: AppConstants.kTwo,
              color: context.general.colorScheme.secondary,
              fontWeight: FontWeight.bold,
            ),
            Padding(
              padding: const PagePadding.onlyTopLow(),
              child: GeneralContentSubTitle(
                value: model.content ?? '',
                maxLine: AppConstants.kTwo,
                color: context.general.colorScheme.secondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
