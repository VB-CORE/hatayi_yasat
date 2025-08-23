part of '../place_detail_view.dart';

@immutable
final class _FindThePlaceButton extends StatelessWidget {
  const _FindThePlaceButton({
    required this.onFindPlaceTapped,
    required this.onCallTapped,
  });

  final AsyncCallback onFindPlaceTapped;
  final AsyncCallback onCallTapped;

  @override
  Widget build(BuildContext context) {
    return UnconstrainedBox(
      constrainedAxis: Axis.horizontal,
      child: SafeArea(
        child: Padding(
          padding: const PagePadding.horizontalSymmetric() +
              const PagePadding.vertical6Symmetric(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 6,
                child: IconTitleButton(
                  onPressed: onCallTapped.call,
                  icon: AppIcons.phone,
                  text: LocaleKeys.placeDetailView_call.tr(),
                ),
              ),
              const Spacer(),
              Expanded(
                flex: 6,
                child: IconTitleButton(
                  onPressed: onFindPlaceTapped.call,
                  icon: AppIcons.location,
                  text: LocaleKeys.placeDetailView_find_the_place.tr(),
                ),
              ),
            ],
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
      icon: AppIcons.location,
      title: town,
      textStyle: context.general.textTheme.titleMedium?.copyWith(),
    );
  }
}

@immutable
final class _ImageWithButtonAndNameStack extends StatelessWidget {
  const _ImageWithButtonAndNameStack({
    required this.model,
  });

  final StoreModel model;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: ClipRRect(
            borderRadius: BorderRadius.vertical(
              top: CustomRadius.large.topLeft,
            ),
            child: CustomImageWithViewDialog(
              image: model.images.first,
            ),
          ),
        ),
        Positioned(
          right: 0,
          top: 20,
          child: Padding(
            padding: const PagePadding.onlyRightLow(),
            child: CircleAvatar(
              backgroundColor: context.general.colorScheme.secondary,
              child: FavoritePlaceButton(store: model),
            ),
          ),
        ),
      ],
    );
  }
}

final class _OpenCloseTime extends StatelessWidget {
  const _OpenCloseTime({
    required this.model,
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

    return Padding(
      padding: const PagePadding.onlyTop(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                LocaleKeys.placeDetailView_workingHours.tr(),
                style: context.general.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              const EmptyBox.smallWidth(),
              Text(
                isOpenOrClose
                    ? LocaleKeys.placeDetailView_nowOpen.tr()
                    : LocaleKeys.placeDetailView_nowClose.tr(),
                style: context.general.textTheme.titleSmall?.copyWith(
                  color: isOpenOrClose
                      ? context.general.colorScheme.primaryContainer
                      : context.general.colorScheme.error,
                ),
              ),
            ],
          ),
          Padding(
            padding: const PagePadding.onlyTopLow(),
            child: Row(
              children: [
                Text(
                  LocaleKeys.placeDetailView_openCloseHours.tr(),
                  style: context.general.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w400,
                    color: context.general.colorScheme.primary
                        .withValues(alpha: 0.5),
                  ),
                ),
                const Spacer(),
                Text(times.join(' - ')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
