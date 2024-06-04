import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/features/chain_store/provider/chain_store_provider.dart';
import 'package:lifeclient/features/chain_store/view/sub_view/chain_sub_sheet.dart';
import 'package:lifeclient/features/chain_store/view_model/chain_store_view_model.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/package/image/custom_network_image.dart';
import 'package:lifeclient/product/utility/constants/app_icons.dart';
import 'package:lifeclient/product/utility/decorations/empty_box.dart';
import 'package:lifeclient/product/widget/app_bar/page_app_bar.dart';
import 'package:lifeclient/product/widget/general/general_expansion_image_tile.dart';
import 'package:lifeclient/product/widget/general/general_not_found_widget.dart';
import 'package:lifeclient/product/widget/general/general_scaffold.dart';
import 'package:lifeclient/product/widget/general/title/general_body_title.dart';
import 'package:lifeclient/product/widget/general/title/general_content_small_title.dart';

part 'sub_view/chain_store_sub_view.dart';

typedef AsyncValueGetterWithContext<T> = Future<void> Function(
  BuildContext context,
  T model,
);

final class ChainStoreView extends ConsumerStatefulWidget {
  const ChainStoreView({super.key});

  @override
  ConsumerState<ChainStoreView> createState() => _ChainStoreViewState();
}

final class _ChainStoreViewState extends ConsumerState<ChainStoreView>
    with ChainStoreViewModel {
  @override
  Widget build(BuildContext context) {
    return GeneralScaffold(
      appBar: PageAppBar(pageTitle: LocaleKeys.chain_stores_title),
      body: Padding(
        padding: const PagePadding.vertical6Symmetric(),
        child: _ChainStoreListWidget(
          onLocationTap: launchMapWithLatLong,
          onCallTap: launchPhoneWithPhoneNumber,
        ),
      ),
    );
  }
}
