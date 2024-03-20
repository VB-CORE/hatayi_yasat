import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/utility/constants/app_icons.dart';
import 'package:lifeclient/product/utility/decorations/empty_box.dart';
import 'package:lifeclient/product/utility/mixin/redirection_mixin.dart';
import 'package:lifeclient/product/widget/general/index.dart';
import 'package:lifeclient/product/widget/general/title/general_content_sub_title.dart';
import 'package:lifeclient/product/widget/general/title/index.dart';

final class ChainSubSheet extends StatelessWidget {
  const ChainSubSheet({
    required this.storeList,
    required this.chainName,
    super.key,
  });

  static void show({
    required BuildContext context,
    required List<StoreModelSnapshot> storeList,
    required String chainName,
  }) {
    showModalBottomSheet<void>(
      context: context,
      builder: (context) {
        return ChainSubSheet(
          storeList: storeList,
          chainName: chainName,
        );
      },
    );
  }

  final List<StoreModelSnapshot> storeList;
  final String chainName;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const PagePadding.all(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GeneralContentSubTitle(
            value: LocaleKeys.chain_stores_subBranchesTitle.tr(
              args: [chainName, storeList.length.toString()],
            ),
          ),
          const Divider(),
          Expanded(
            child: ListView.builder(
              itemCount: storeList.length,
              itemBuilder: (BuildContext context, int index) {
                return _ChainStoreBranchWidget(
                  store: storeList[index],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

final class _ChainStoreBranchWidget extends StatelessWidget {
  const _ChainStoreBranchWidget({
    required this.store,
  });
  final StoreModelSnapshot store;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: _BranchNameText(branchName: store.name),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const EmptyBox.xSmallHeight(),
          _BranchAddressText(branchAddress: store.address ?? ''),
        ],
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _LocationIconButton(branch: store),
          _PhoneIconButton(branch: store),
        ],
      ),
    );
  }
}

class _PhoneIconButton extends StatelessWidget {
  const _PhoneIconButton({
    required this.branch,
  });

  final StoreModelSnapshot branch;

  Future<void> launchPhoneWithPhoneNumber(
    BuildContext context,
    String phoneNumber,
  ) async {
    await RedirectionMixin.openToPhone(
      context: context,
      phoneNumber: phoneNumber,
    );
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(AppIcons.phone),
      onPressed: () {
        launchPhoneWithPhoneNumber(context, branch.phone);
      },
    );
  }
}

class _LocationIconButton extends StatelessWidget {
  const _LocationIconButton({
    required this.branch,
  });

  final StoreModelSnapshot branch;

  Future<void> launchMapWithLatLong(
    BuildContext context,
    GeoPoint? locationPoint,
  ) async {
    if (locationPoint == null) return;
    final latitude = locationPoint.latitude;
    final longitude = locationPoint.longitude;
    final latLongString = '$latitude,$longitude';
    await RedirectionMixin.navigateToMapsWithTitle(
      context: context,
      placeAddress: latLongString,
    );
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(AppIcons.location),
      onPressed: () {
        launchMapWithLatLong(context, branch.latlong);
      },
    );
  }
}

class _BranchAddressText extends StatelessWidget {
  const _BranchAddressText({
    required this.branchAddress,
  });

  final String branchAddress;

  @override
  Widget build(BuildContext context) {
    return Text(
      branchAddress,
      style: context.general.textTheme.bodySmall,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }
}

class _BranchNameText extends StatelessWidget {
  const _BranchNameText({
    required this.branchName,
  });

  final String branchName;

  @override
  Widget build(BuildContext context) {
    return Text(
      branchName,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }
}
