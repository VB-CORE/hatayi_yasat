part of '../place_request_form.dart';

final class _PlaceRequestSend extends StatelessWidget {
  const _PlaceRequestSend({
    required this.onTapped,
    required this.onKVKKChanged,
  });

  final AsyncCallback onTapped;
  final ValueSetter<bool> onKVKKChanged;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const PagePadding.all(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            KvkkCheckBox(onChanged: onKVKKChanged),
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
