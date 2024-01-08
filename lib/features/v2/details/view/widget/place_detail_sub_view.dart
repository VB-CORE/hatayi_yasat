part of '../place_detail_view.dart';

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
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: GeneralContentTitle(
            value: placeName,
            fontWeight: FontWeight.bold,
            maxLine: 3,
          ),
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
    return UnconstrainedBox(
      constrainedAxis: Axis.horizontal,
      child: SafeArea(
        child: Padding(
          padding: const PagePadding.horizontalSymmetric() +
              const PagePadding.vertical6Symmetric(),
          child: GeneralButtonV2.async(
            action: action,
            label: LocaleKeys.placeDetailView_find_the_place.tr(),
          ),
        ),
      ),
    );
  }
}

@immutable
final class _TownIcon extends ConsumerWidget with AppProviderStateMixin {
  const _TownIcon({
    required this.townCode,
  });

  final int townCode;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final town = productProvider(ref).fetchTownFromCode(townCode);

    if (town.isEmpty) {
      return const EmptyBox();
    }
    return IconWithText(
      icon: AppIcons.city,
      title: town,
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
    return Hero(
      tag: image,
      child: SizedBox(
        width: context.sized.width,
        height: context.sized.dynamicHeight(0.3),
        child: CustomNetworkImage(
          imageUrl: image,
          fit: BoxFit.cover,
        ),
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
