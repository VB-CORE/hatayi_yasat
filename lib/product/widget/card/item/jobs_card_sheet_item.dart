part of '../jobs_card.dart';

final class _JobsSheetView extends StatelessWidget {
  const _JobsSheetView({required this.item});
  final AdvertiseModel item;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const PagePadding.all(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GeneralBigTitle(item.title ?? ''),
          GeneralBodyTitle(item.role ?? ''),
          const Divider(),
          Expanded(
            child: Scrollbar(
              child: SingleChildScrollView(
                child: GeneralBodyTitle((item.description ?? '') * 100),
              ),
            ),
          ),
          Padding(
            padding: const PagePadding.onlyTopLow(),
            child: Row(
              children: [
                Expanded(
                  child: _CallButton(item: item),
                ),
                const EmptyBox.largeWidth(),
                Expanded(
                  child: _ShareButton(item: item),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

final class _CallButton extends StatelessWidget {
  const _CallButton({
    required this.item,
  });

  final AdvertiseModel item;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        final phoneNumber = item.phoneNumber ?? '';
        if (phoneNumber.isEmpty) return;
        phoneNumber.ext.launchPhone;
      },
      child: Row(
        children: [
          const Icon(AppIcons.phone),
          Padding(
            padding: const PagePadding.onlyLeftVeryLow(),
            child: GeneralSubTitle(
              value: LocaleKeys.button_call.tr(),
            ),
          ),
        ],
      ),
    );
  }
}

final class _ShareButton extends StatelessWidget {
  const _ShareButton({
    required this.item,
  });

  final AdvertiseModel item;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        item.toString().ext.share();
      },
      child: Row(
        children: [
          const Icon(AppIcons.share),
          Padding(
            padding: const PagePadding.onlyLeftVeryLow(),
            child: Expanded(
              child: GeneralSubTitle(
                value: LocaleKeys.button_share.tr(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
