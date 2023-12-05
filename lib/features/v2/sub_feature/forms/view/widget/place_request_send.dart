part of '../place_request_form.dart';

final class _PlaceRequestSend extends StatelessWidget {
  const _PlaceRequestSend(this.onTapped);
  final AsyncCallback onTapped;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const PagePadding.all(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GeneralButtonV2.async(
              action: onTapped,
              label: LocaleKeys.button_sendRequest.tr(),
            ),
          ],
        ),
      ),
    );
  }
}
