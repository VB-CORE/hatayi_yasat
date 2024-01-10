part of '../project_request_form.dart';

final class _ProjectRequestSend extends StatelessWidget {
  const _ProjectRequestSend(this.onTapped);
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
              label: LocaleKeys.button_save.tr(),
            ),
          ],
        ),
      ),
    );
  }
}
