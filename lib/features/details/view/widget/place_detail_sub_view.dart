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
    required this.model,
  });

  final String image;
  final String placeOwnerName;
  final AsyncCallback backButtonAction;
  final StoreModel model;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.bottomCenter,
      children: [
        CustomImageWithViewDialog(image: image),
        Positioned.fill(
          bottom: -WidgetSizes.spacingM,
          left: WidgetSizes.spacingM,
          right: WidgetSizes.spacingM,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _CircleImageWithNamePositioned(
                image: image,
                placeOwnerName: placeOwnerName,
              ),
              const Spacer(),
              _OpenCloseTime(model: model),
            ],
          ),
        ),
      ],
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
    return CircleImageWithTextContainer(
      imageUrl: image,
      name: placeOwnerName,
    );
  }
}

final class _OpenCloseTime extends StatelessWidget {
  const _OpenCloseTime({
    required this.model,
    super.key,
  });

  final StoreModel model;

  @override
  Widget build(BuildContext context) {
    final isOpenOrClose = StoreModelHelper(model: model).isStoreOpen;

    if (isOpenOrClose == null) {
      return const SizedBox.shrink();
    }

    final times = [model.openTime, model.closeTime];
    if (times.any((element) => element.ext.isNullOrEmpty)) {
      return const SizedBox.shrink();
    }

    return Chip(
      backgroundColor: context.general.colorScheme.secondary,
      elevation: WidgetSizes.spacingXxs,
      shadowColor: context.general.colorScheme.secondary,
      shape: const StadiumBorder(
        side: BorderSide(
          color: Colors.transparent,
        ),
      ),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      padding: const PagePadding.allVeryLow(),
      avatar: CircleAvatar(
        radius: WidgetSizes.spacingXs,
        backgroundColor: isOpenOrClose
            ? context.general.colorScheme.onTertiaryContainer
            : context.general.colorScheme.error,
      ),
      label: Text(times.join(' - ')),
    );
  }
}
