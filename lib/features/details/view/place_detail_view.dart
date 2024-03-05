import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/features/details/mixin/place_detail_view_mixin.dart';
import 'package:lifeclient/features/details/view_model/place_detail_view_model.dart';
import 'package:lifeclient/product/common/color_common.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/utility/constants/index.dart';
import 'package:lifeclient/product/utility/decorations/empty_box.dart';
import 'package:lifeclient/product/utility/mixin/app_provider_mixin.dart';
import 'package:lifeclient/product/widget/button/favorite_button/favorite_place_button.dart';
import 'package:lifeclient/product/widget/container/circle_image_with_text_container.dart';
import 'package:lifeclient/product/widget/general/general_not_found_widget.dart';
import 'package:lifeclient/product/widget/general/index.dart';
import 'package:lifeclient/product/widget/icon/index.dart';
import 'package:lifeclient/product/widget/image/custom_image_with_view_dialog.dart';
import 'package:lifeclient/product/widget/text/title_description_text.dart';

part 'widget/place_detail_sub_view.dart';

final class PlaceDetailView extends ConsumerStatefulWidget {
  const PlaceDetailView({required this.model, required this.id, super.key});
  final StoreModel model;
  final String id;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PlaceDetailViewState();
}

class _PlaceDetailViewState extends ConsumerState<PlaceDetailView>
    with AppProviderMixin<PlaceDetailView>, PlaceDetailViewMixin {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(placeDetailViewModelProvider);

    if (state.isError) {
      return Scaffold(
        appBar: AppBar(),
        body: GeneralNotFoundWidget(
          title: LocaleKeys.notification_placeNotFoundErrorMessage.tr(),
        ),
      );
    }

    if (model.documentId.isEmpty) {
      return Scaffold(
        appBar: AppBar(),
        body: const PlaceShimmerList(),
      );
    }
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: context.general.colorScheme.primary,
        ),
        leading: const CloseButton(),
        actions: [
          _ShareAddressButton(model: model),
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
            model: model,
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
                      // _VisitCountRow(model: model),
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

final class _ShareAddressButton extends StatelessWidget {
  const _ShareAddressButton({
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
