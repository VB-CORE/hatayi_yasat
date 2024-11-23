part of '../settings_view.dart';

@immutable
final class _AppAboutWidget extends StatelessWidget {
  const _AppAboutWidget();

  @override
  Widget build(BuildContext context) {
    return Card(
      color: context.general.colorScheme.onPrimaryFixed,
      elevation: kZero,
      shape: const RoundedRectangleBorder(
        borderRadius: CustomRadius.large,
      ),
      child: ListTile(
        shape: const RoundedRectangleBorder(
          borderRadius: CustomRadius.large,
        ),
        title: GeneralBodyTitle(
          LocaleKeys.settings_aboutTitle.tr(context: context),
          fontWeight: FontWeight.bold,
          color: context.general.colorScheme.primary.withOpacity(.5),
        ),
        onTap: () {
          showModalBottomSheet<void>(
            context: context,
            enableDrag: false,
            isScrollControlled: true,
            builder: (context) {
              return const AppAboutView();
            },
          );
        },
      ),
    );
  }
}
