part of '../../details/view/place_detail_view.dart';

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
        GeneralContentTitle(
          value: placeName,
          fontWeight: FontWeight.bold,
        ),
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
      action: action,
      label: LocaleKeys.placeDetailView_call.tr(),
      buttonPadding: const PagePadding.vertical6Symmetric(),
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
    required this.image,
    required this.placeOwnerName,
    required this.backButtonAction,
  });

  final String image;
  final String placeOwnerName;
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
        _CircleImageWithNamePositioned(
          image: image,
          placeOwnerName: placeOwnerName,
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
      backgroundColor: context.general.colorScheme.primary,
    );
  }
}

@immutable
class _CircleImageWithNamePositioned extends StatelessWidget {
  const _CircleImageWithNamePositioned({
    required this.image,
    required this.placeOwnerName,
  });

  final String image;
  final String placeOwnerName;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: -WidgetSizes.spacingM,
      left: WidgetSizes.spacingM,
      child: CircleImageWithTextContainer(
        imageUrl: image,
        name: placeOwnerName,
      ),
    );
  }
}
