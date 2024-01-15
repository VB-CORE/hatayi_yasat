part of '../scholarship_request_form.dart';

@immutable
final class _ScholarshipRequestSend extends StatelessWidget {
  const _ScholarshipRequestSend({
    required this.onTapped,
    required this.onKVKKChanged,
  });

  final AsyncCallback onTapped;
  final ValueSetter<bool> onKVKKChanged;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const PagePadding.horizontalSymmetric() +
            const PagePadding.onlyBottom(),
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
