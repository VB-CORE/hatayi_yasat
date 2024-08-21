import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/utility/decorations/empty_box.dart';
import 'package:lifeclient/product/utility/mixin/redirection_mixin.dart';

final class SpecialAgencyDetailSheet extends StatelessWidget {
  const SpecialAgencyDetailSheet({required this.model, super.key});
  final SpecialAgencyModel model;

  /// Show the special agency detail sheet as a modal bottom sheet
  static Future<void> show(
    BuildContext context,
    SpecialAgencyModel specialAgencyModel,
  ) async {
    await showModalBottomSheet<void>(
      context: context,
      builder: (context) => SpecialAgencyDetailSheet(model: specialAgencyModel),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const PagePadding.generalAllNormal(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            model.name ?? '',
            style: context.general.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const EmptyBox.smallHeight(),
          const Divider(
            height: WidgetSizes.spacingXxs,
            thickness: WidgetSizes.spacingXSSs,
          ),
          _ListTileWidget(
            iconData: Icons.phone_outlined,
            mainTitle: LocaleKeys.specialAgency_agencyNumber,
            subTitle: model.phone ?? '',
            onTapEvent: () {
              final phone = model.phone;
              if (phone.ext.isNullOrEmpty) return;
              RedirectionMixin.openToPhone(
                context: context,
                phoneNumber: phone ?? '',
              );
            },
          ),
          _ListTileWidget(
            iconData: Icons.location_on_outlined,
            mainTitle: LocaleKeys.specialAgency_agencyAddress,
            subTitle: model.address ?? '',
            onTapEvent: () async {
              final latLongString =
                  '${model.latLong.latitude},${model.latLong.longitude}';
              await RedirectionMixin.navigateToMapsWithTitle(
                context: context,
                placeAddress: latLongString,
              );
            },
          ),
          const EmptyBox.largeHeight(),
        ],
      ),
    );
  }
}

@immutable
final class _ListTileWidget extends StatelessWidget {
  const _ListTileWidget({
    required this.iconData,
    required this.mainTitle,
    required this.subTitle,
    required this.onTapEvent,
  });

  final String mainTitle;
  final String subTitle;
  final IconData iconData;
  final VoidCallback onTapEvent;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      trailing: Icon(iconData),
      title: Text(mainTitle).tr(),
      subtitle: Text(subTitle),
      onTap: onTapEvent.call,
    );
  }
}
