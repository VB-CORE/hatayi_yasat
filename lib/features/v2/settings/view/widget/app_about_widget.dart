part of '../settings_view.dart';

@immutable
final class _AppAboutWidget extends StatelessWidget {
  const _AppAboutWidget();

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      elevation: 0,
      shape: context.border.roundedRectangleAllBorderNormal
          .copyWith(side: CustomBorderSides.medium),
      child: ListTile(
        title: GeneralBodyTitle(
          LocaleKeys.settings_aboutTitle.tr(),
          fontWeight: FontWeight.bold,
        ),
        trailing: const Icon(AppIcons.rightSelect),
        onTap: () {
          showModalBottomSheet<void>(
            context: context,
            enableDrag: false,
            builder: (context) {
              return const AppAboutView();
            },
          );
          // navigate to AppAboutView
        },
      ),
    );
  }
}
