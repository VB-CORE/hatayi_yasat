import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:life_shared/life_shared.dart';
import 'package:vbaseproject/features/settings_module/special_agency/mixin/special_agency_view_mixin.dart';
import 'package:vbaseproject/product/init/language/locale_keys.g.dart';
import 'package:vbaseproject/product/utility/mixin/rediraction_mixin.dart';
import 'package:vbaseproject/product/utility/padding/page_padding.dart';
import 'package:vbaseproject/product/widget/lottie/not_found_lottie.dart';

class SpecialAgencyView extends ConsumerStatefulWidget {
  const SpecialAgencyView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SpecialAgencyViewState();
}

class _SpecialAgencyViewState extends ConsumerState<SpecialAgencyView>
    with SpecialAgencyViewMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(LocaleKeys.specialAgency_title.tr())),
      body: agencyItems.isEmpty ? const NotFoundLottie() : _listViewBuilder(),
    );
  }

  Widget _listViewBuilder() {
    return Padding(
      padding: const PagePadding.generalCardAll(),
      child: ListView.builder(
        itemCount: agencyItems.length,
        itemBuilder: (BuildContext context, int index) {
          final model = agencyItems[index];
          return _SpecialAgencyCard(model: model);
        },
      ),
    );
  }
}

class _SpecialAgencyCard extends StatelessWidget {
  const _SpecialAgencyCard({
    required this.model,
  });

  final SpecialAgencyModel model;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ExpansionTile(
        shape: const Border(),
        title: Text(model.name ?? ''),
        children: [
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
              await RedirectionMixin.navigateToMapsWithGeoPoint(
                context: context,
                latLong: model.latLong,
              );
            },
          ),
        ],
      ),
    );
  }
}

class _ListTileWidget extends StatelessWidget {
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
