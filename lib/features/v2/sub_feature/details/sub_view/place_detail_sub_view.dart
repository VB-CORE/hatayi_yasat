part of '../view/place_detail_view.dart';

@immutable
final class _NameTitleAndCallButton extends StatelessWidget {
  const _NameTitleAndCallButton({
    required this.placeName,
    required this.callAction,
  });

  final String placeName;
  final AsyncCallback callAction;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _TitleText.withText(placeName),
        _CallButton(action: callAction),
      ],
    );
  }
}

@immutable
final class _CallButton extends StatelessWidget {
  const _CallButton({required this.action});
  final AsyncCallback action;

  @override
  Widget build(BuildContext context) {
    return GeneralButtonV2.async(
      action: () async {},
      label: LocaleKeys.placeDetailView_call.tr(),
      buttonPadding: const PagePadding.vertical6Symmetric(),
    );
  }
}

@immutable
final class _TitleText extends StatelessWidget {
  factory _TitleText.placeDescriptionTitle() {
    return _TitleText._(text: LocaleKeys.placeDetailView_description.tr());
  }

  factory _TitleText.placeAddressTitle() {
    return _TitleText._(text: LocaleKeys.placeDetailView_address.tr());
  }

  factory _TitleText.withText(String text) {
    return _TitleText._(text: text);
  }

  const _TitleText._({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return GeneralContentTitle(
      value: text,
      fontWeight: FontWeight.bold,
    );
  }
}

@immutable
final class _FindThePlaceButton extends StatelessWidget {
  const _FindThePlaceButton({
    required this.action,
  });

  final AsyncCallback action;

  @override
  Widget build(BuildContext context) {
    return GeneralButtonV2.async(
      action: action,
      label: LocaleKeys.placeDetailView_find_the_place.tr(),
    );
  }
}

@immutable
final class _DescriptionText extends StatelessWidget {
  const _DescriptionText({
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return GeneralContentSubTitle(
      value: text,
      maxLine: 5,
      fontWeight: FontWeight.w500,
    );
  }
}

@immutable
final class _ImageWithButtonAndNameStack extends StatelessWidget {
  const _ImageWithButtonAndNameStack({
    required this.randomImage,
    required this.placeOwnerName,
    required this.backButtonAction,
  });

  final String randomImage;
  final String placeOwnerName;
  final AsyncCallback backButtonAction;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        _ImageSizedBox(randomImage: randomImage),
        _BackButtonContainer(
          onPressed: () {},
        ),
        _CircleImageWithNamePositioned(
          randomImage: randomImage,
          placeOwnerName: placeOwnerName,
        ),
      ],
    );
  }
}

@immutable
final class _ImageSizedBox extends StatelessWidget {
  const _ImageSizedBox({
    required String randomImage,
  }) : _randomImage = randomImage;

  final String _randomImage;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.sized.width,
      height: context.sized.dynamicHeight(0.3),
      child: CustomNetworkImage(
        imageUrl: _randomImage,
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
    return Container(
      padding: const PagePadding.allLow(),
      width: WidgetSizes.spacingXxl9,
      height: WidgetSizes.spacingXxl9,
      child: FloatingActionButton(
        onPressed: onPressed,
        backgroundColor: context.general.colorScheme.primary,
        child: Icon(
          AppIcons.leftSelect,
          size: WidgetSizes.spacingXxl2,
          color: context.general.colorScheme.secondary,
        ),
      ),
    );
  }
}

@immutable
class _CircleImageWithNamePositioned extends StatelessWidget {
  const _CircleImageWithNamePositioned({
    required this.randomImage,
    required this.placeOwnerName,
  });

  final String randomImage;
  final String placeOwnerName;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: -WidgetSizes.spacingM,
      left: WidgetSizes.spacingM,
      child: CircleImageWithTextContainer(
        imageUrl: randomImage,
        name: placeOwnerName,
      ),
    );
  }
}
