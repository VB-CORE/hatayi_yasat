import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:vbaseproject/features/v2/details/mixin/place_detail_view_mixin.dart';
import 'package:vbaseproject/product/init/language/locale_keys.g.dart';
import 'package:vbaseproject/product/package/image/custom_network_image.dart';
import 'package:vbaseproject/product/utility/constants/index.dart';
import 'package:vbaseproject/product/utility/decorations/empty_box.dart';
import 'package:vbaseproject/product/utility/mixin/app_provider_mixin.dart';
import 'package:vbaseproject/product/utility/padding/page_padding.dart';
import 'package:vbaseproject/product/widget/button/back_button_widget.dart';
import 'package:vbaseproject/product/widget/button/favorite_button/favorite_place_button.dart';
import 'package:vbaseproject/product/widget/container/circle_image_with_text_container.dart';
import 'package:vbaseproject/product/widget/general/index.dart';
import 'package:vbaseproject/product/widget/icon/index.dart';
import 'package:vbaseproject/product/widget/size/index.dart';
import 'package:vbaseproject/product/widget/text/title_description_text.dart';

part 'widget/place_detail_sub_view.dart';

final class PlaceDetailView extends ConsumerStatefulWidget {
  const PlaceDetailView({required this.model, super.key});
  final StoreModel model;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PlaceDetailViewState();
}

class _PlaceDetailViewState extends ConsumerState<PlaceDetailView>
    with PlaceDetailViewMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: context.general.colorScheme.primary,
        ),
        leading: const CloseButton(),
        actions: [
          _ShareAdressButton(model: model),
          Padding(
            padding: const PagePadding.onlyRightLow(),
            child: FavoritePlaceButton(store: model),
          ),
        ],
      ),
      bottomNavigationBar: _FindThePlaceButton(action: findThePlaceAction),
      body: ListView(
        children: [
          _ImageWithButtonAndNameStack(
            image: model.images.first,
            placeOwnerName: model.owner,
            backButtonAction: goBackAction,
          ),
          Padding(
            padding: const PagePadding.defaultPadding(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const EmptyBox.largeHeight(),
                Padding(
                  padding: EdgeInsets.zero,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _NameTitleAndCallButton(
                        placeName: model.name,
                        callAction: callAction,
                      ),
                      _TownIcon(townCode: model.townCode),
                      Padding(
                        padding: const PagePadding.verticalSymmetric(),
                        child: TitleDescription(
                          title: LocaleKeys.placeDetailView_description.tr(),
                          description: model.description ?? '-',
                        ),
                      ),
                      TitleDescription(
                        title: LocaleKeys.placeDetailView_address.tr(),
                        description: model.address ?? '-',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

final class _ShareAdressButton extends StatelessWidget {
  const _ShareAdressButton({
    required this.model,
  });

  final StoreModel model;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        '${model.name} ${model.address}'.ext.share();
      },
      child: Icon(
        AppIcons.share,
        color: context.general.colorScheme.primary,
      ),
    );
  }
}
