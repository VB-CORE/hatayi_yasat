import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:vbaseproject/features/advertise/mixin/advertise_view_mixin.dart';
import 'package:vbaseproject/product/init/language/locale_keys.g.dart';
import 'package:vbaseproject/product/package/shimmer/place_shimmer_grid.dart';
import 'package:vbaseproject/product/utility/padding/page_padding.dart';
import 'package:vbaseproject/product/widget/builder/firestore_grid_view.dart';
import 'package:vbaseproject/product/widget/card/advertise_place_card.dart';
import 'package:vbaseproject/product/widget/lottie/not_found_lottie.dart';
import 'package:vbaseproject/product/widget/size/widget_custom_size.dart';
import 'package:vbaseproject/product/widget/size/widget_size.dart';

class AdvertiseView extends StatefulWidget {
  const AdvertiseView({super.key});

  @override
  State<AdvertiseView> createState() => _AdvertiseViewState();
}

class _AdvertiseViewState extends State<AdvertiseView> with AdvertiseViewMixin {
  final SliverGridDelegateWithFixedCrossAxisCount _gridDelegate =
      SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisSpacing: WidgetSizes.spacingS,
    mainAxisSpacing: WidgetSizes.spacingS,
    crossAxisCount: 2,
    mainAxisExtent: WidgetCustomSize.gridHeight.value,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const PagePadding.horizontalLowSymmetric(),
        child: FirestoreGridView(
          query: advertiseCollectionReference,
          gridDelegate: _gridDelegate,
          emptyBuilder: (_) => NotFoundLottie(
            title: LocaleKeys.notFound_advertise.tr(),
            onRefresh: () {},
          ),
          loadingBuilder: (_) => PlaceShimmerGrid(gridDelegate: _gridDelegate),
          itemBuilder: (context, doc) {
            final model = doc.data();
            if (model == null) return const SizedBox.shrink();
            return AdvertisePlaceCard(item: model);
          },
        ),
      ),
    );
  }
}
