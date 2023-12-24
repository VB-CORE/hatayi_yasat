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
    return Stack(
      clipBehavior: Clip.none,
      children: [
        _ImageSizedBox(image: image),
        _BackButtonContainer(
          onPressed: backButtonAction,
        ),
      ],
    );
  }
}

@immutable
final class _ImageSizedBox extends StatelessWidget {
  const _ImageSizedBox({
    required this.image,
  });

  final String image;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.sized.width,
      height: context.sized.dynamicHeight(0.3),
      child: CustomNetworkImage(
        imageUrl: image,
        fit: BoxFit.cover,
      ),
    );
  }
}

@immutable
final class _BackButtonContainer extends StatelessWidget {
  const _BackButtonContainer({
    required this.onPressed,
  });
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return BackButtonWidget(
      onPressed: onPressed,
      backgroundColor: Colors.transparent,
    );
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
    super.key,
  });

  final CampaignModel projectModel;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          AppIcons.calendarFilled,
          color: context.general.colorScheme.primary,
          size: WidgetSizes.spacingXxl3,
        ),
        context.sized.emptySizedWidthBoxNormal,
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
    return TitleDescription(
      title: title,
      description: description,
    );
  }
}

@immutable
final class _JoinNowButton extends StatelessWidget {
  const _JoinNowButton({required this.onPressed});
  final AsyncCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return GeneralButtonV2.async(
      action: onPressed,
      label: LocaleKeys.campaignDetailsView_join_now.tr(),
    );
  }
}
