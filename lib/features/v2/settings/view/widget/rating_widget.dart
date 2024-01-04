part of '../settings_view.dart';

@immutable
final class _RatingWidget extends StatelessWidget {
  const _RatingWidget();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const PagePadding.onlyTop(),
      child: Card(
        elevation: 0,
        shape: context.border.roundedRectangleAllBorderNormal
            .copyWith(side: CustomBorderSides.medium),
        child: ListTile(
          title: GeneralBodyTitle(
            LocaleKeys.settings_appReviewTitle.tr(context: context),
            fontWeight: FontWeight.bold,
          ),
          trailing: const AppRatingWidget(),
          onTap: () => AppReview.instance.openStore(),
        ),
      ),
    );
  }
}
