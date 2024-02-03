part of '../event_detail_view.dart';

@immutable
final class _ImageWithBackButtonStack extends StatelessWidget {
  const _ImageWithBackButtonStack({
    required this.image,
    required this.backButtonAction,
  });

  final String image;
  final AsyncCallback backButtonAction;

  @override
  Widget build(BuildContext context) {
    return CustomImageWithViewDialog(image: image);
  }
}

@immutable
final class _CircleAvatarWithText extends StatelessWidget {
  const _CircleAvatarWithText({required this.publisherName});
  final String publisherName;

  @override
  Widget build(BuildContext context) {
    if (publisherName.isEmpty) return const SizedBox.shrink();
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: context.general.colorScheme.primary,
          child: GeneralContentSubTitle(
            value: publisherName[AppConstants.kZero],
            color: context.general.colorScheme.secondary,
            fontWeight: FontWeight.bold,
          ),
        ),
        context.sized.emptySizedWidthBoxNormal,
        Expanded(
          child: GeneralContentSubTitle(
            value: LocaleKeys.campaignDetailsView_publishedBy.tr(
              args: [publisherName],
            ),
            maxLine: AppConstants.kTwo,
          ),
        ),
      ],
    );
  }
}

@immutable
final class _DateAndAddressRow extends StatelessWidget {
  const _DateAndAddressRow({
    required this.projectModel,
  });

  final CampaignModel projectModel;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const PagePadding.onlyRightLow(),
          child: Icon(
            AppIcons.calendarFilled,
            color: context.general.colorScheme.primary,
            size: WidgetSizes.spacingXxl3,
          ),
        ),
        GeneralContentSmallTitle(
          value: LocaleKeys.campaignDetailsView_startDate.tr(
            args: ['\n${projectModel.expireDate?.getMonthName}'],
          ),
          maxLine: AppConstants.kTwo,
        ),
        const Spacer(),
        GeneralContentSmallTitle(
          value: LocaleKeys.campaignDetailsView_time.tr(
            args: ['\n${projectModel.expireDate?.getTime}'],
          ),
          maxLine: AppConstants.kTwo,
        ),
        const Spacer(),
      ],
    );
  }
}

@immutable
final class _TitleDescription extends StatelessWidget {
  factory _TitleDescription.topic({required String topic}) {
    return _TitleDescription._(
      title: LocaleKeys.projectRequest_topic.tr(),
      description: topic,
    );
  }

  factory _TitleDescription.description({required String description}) {
    return _TitleDescription._(
      title: LocaleKeys.projectRequest_description.tr(),
      description: description,
    );
  }

  const _TitleDescription._({
    required this.title,
    required this.description,
  });

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const PagePadding.vertical8Symmetric(),
      child: TitleDescription(
        title: title,
        description: description,
      ),
    );
  }
}
