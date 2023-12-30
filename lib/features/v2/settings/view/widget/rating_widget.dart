part of '../settings_view.dart';

@immutable
final class _RatingWidget extends StatelessWidget {
  const _RatingWidget();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: context.border.roundedRectangleAllBorderNormal
          .copyWith(side: CustomBorderSides.medium),
      child: ListTile(
        title: GeneralBodyTitle(
          LocaleKeys.settings_appReviewTitle.tr(),
          fontWeight: FontWeight.bold,
          maxLines: 1,
        ),
        trailing: const AppRatingWidget(),
        onTap: () => AppReview.instance.openStore(),
      ),
    );
  }
}
