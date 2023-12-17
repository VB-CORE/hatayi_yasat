import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:vbaseproject/features/v2/sub_feature/details/mixin/place_detail_view_mixin.dart';
import 'package:vbaseproject/features/v2/sub_feature/forms/view/model/place_request_model.dart';
import 'package:vbaseproject/product/init/language/locale_keys.g.dart';
import 'package:vbaseproject/product/package/custom_network_image.dart';
import 'package:vbaseproject/product/utility/constants/index.dart';
import 'package:vbaseproject/product/utility/padding/page_padding.dart';
import 'package:vbaseproject/product/widget/button/back_button_widget.dart';
import 'package:vbaseproject/product/widget/container/circle_image_with_text_container.dart';
import 'package:vbaseproject/product/widget/general/index.dart';
import 'package:vbaseproject/product/widget/icon/index.dart';
import 'package:vbaseproject/product/widget/size/index.dart';
import 'package:vbaseproject/product/widget/text/title_description_text.dart';

part '../sub_view/place_detail_sub_view.dart';

final class PlaceDetailView extends ConsumerStatefulWidget {
  const PlaceDetailView({required this.model, super.key});
  final PlaceRequestModel model;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PlaceDetailViewState();
}

class _PlaceDetailViewState extends ConsumerState<PlaceDetailView>
    with PlaceDetailViewMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _ImageWithButtonAndNameStack(
                randomImage: randomImage,
                placeOwnerName: model.placeOwnerName,
                backButtonAction: goBackAction,
              ),
              Padding(
                padding: const PagePadding.defaultPadding(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    context.sized.emptySizedHeightBoxNormal,
                    Padding(
                      padding: EdgeInsets.zero,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _NameTitleAndCallButton(
                            placeName: model.placeName,
                            callAction: callAction,
                          ),
                          IconWithText(
                            icon: AppIcons.city,
                            title: model.placeDistrict.displayName,
                          ),
                          context.sized.emptySizedHeightBoxNormal,
                          TitleDescription(
                            title: LocaleKeys.placeDetailView_description.tr(),
                            description: model.placeDescription,
                          ),
                          context.sized.emptySizedHeightBoxNormal,
                          TitleDescription(
                            title: LocaleKeys.placeDetailView_address.tr(),
                            description: model.placeAddress,
                          ),
                          context.sized.emptySizedHeightBoxLow,
                          context.sized.emptySizedHeightBoxLow,
                          _FindThePlaceButton(action: findThePlaceAction),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
