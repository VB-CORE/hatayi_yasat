part of '../project_request_form.dart';

final class _ProjectRequestSend extends StatelessWidget {
  const _ProjectRequestSend({
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
              label: LocaleKeys.button_save.tr(),
            ),
          ],
        ),
      ),
    );
  }
}
