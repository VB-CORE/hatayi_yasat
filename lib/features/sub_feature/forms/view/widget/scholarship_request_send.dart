part of '../scholarship_request_form.dart';

@immutable
final class _ScholarshipRequestSend extends StatelessWidget {
  const _ScholarshipRequestSend({
    required this.onTapped,
    required this.onKVKKChanged,
    required this.canApply,
  });

  final AsyncCallback onTapped;
  final ValueSetter<bool> onKVKKChanged;
  final bool canApply;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const PagePadding.horizontalSymmetric() +
            const PagePadding.onlyBottom(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            KvkkCheckBox(onChanged: onKVKKChanged)
                .ext
                .toDisabled(disable: !canApply),
            GeneralButtonV2.async(
              action: onTapped,
              label: canApply
                  ? LocaleKeys.button_save.tr()
                  : LocaleKeys.requestScholarship_disableButtonTitle.tr(),
            ),
          ],
        ),
      ),
    );
  }
}
