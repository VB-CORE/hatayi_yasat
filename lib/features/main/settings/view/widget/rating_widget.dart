part of '../settings_view.dart';

@immutable
final class _RatingWidget extends StatelessWidget {
  const _RatingWidget();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const PagePadding.onlyTop(),
      child: Card(
        color: context.general.colorScheme.onPrimaryFixed,
        elevation: kZero,
        shape: const RoundedRectangleBorder(
          borderRadius: CustomRadius.large,
        ),
        child: ListTile(
          title: GeneralBodyTitle(
            LocaleKeys.settings_appReviewTitle.tr(context: context),
            color: context.general.colorScheme.primary.withOpacity(.5),
          ),
          trailing: Icon(
            Icons.stars,
            color: context.general.colorScheme.primary.withOpacity(.5),
          ),
          onTap: () => AppReview.instance.openStore(),
        ),
      ),
    );
  }
}
