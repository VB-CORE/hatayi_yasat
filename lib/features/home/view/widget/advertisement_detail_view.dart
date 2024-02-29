part of '../home_view.dart';

final class _AdvertisementDetailView extends StatelessWidget
    with _AdvertisementDetailViewHelperMixin {
  const _AdvertisementDetailView(this.item);

  @override
  final AdBoardModel item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const PagePadding.all(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Visibility(
            visible: _getOwner.isNotEmpty,
            child: Text(
              _getOwner,
              style: _getTitleStyle(context),
            ),
          ),
          Visibility(
            visible: _getDescription.isNotEmpty,
            child: Text(_getDescription),
          ),
          Padding(
            padding: _buildPaddingByTextControl(),
            child: OpenUrlGeneralButton(url: _getUrl),
          ),
          Padding(
            padding: const PagePadding.onlyTop(),
            child: ShareAdvertisementGeneralButton(
              description: _getDescription,
              owner: _getOwner,
              url: _getUrl,
            ),
          ),
        ],
      ),
    );
  }
}

mixin _AdvertisementDetailViewHelperMixin on StatelessWidget {
  AdBoardModel get item;

  bool get _isAnyTextAvailable {
    return (item.description ?? item.owner).ext.isNotNullOrNoEmpty;
  }

  EdgeInsets _buildPaddingByTextControl() {
    return _isAnyTextAvailable
        ? const PagePadding.onlyTopNormalMedium()
        : EdgeInsets.zero;
  }

  String get _getOwner => item.owner ?? '';

  String get _getUrl => item.link ?? '';

  String get _getDescription => item.description ?? '';

  TextStyle? _getTitleStyle(BuildContext context) {
    return context.general.textTheme.bodyLarge?.copyWith(
      fontWeight: FontWeight.bold,
    );
  }
}
