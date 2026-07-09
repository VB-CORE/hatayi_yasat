import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/theme/app_spacing.dart';
import 'package:lifeclient/features/community/rate/view/rate_comment_list.dart';
import 'package:lifeclient/features/details/mixin/place_detail_view_mixin.dart';
import 'package:lifeclient/features/details/view_model/place_detail_view_model.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/utility/constants/index.dart';
import 'package:lifeclient/product/utility/decorations/custom_radius.dart';
import 'package:lifeclient/product/utility/decorations/empty_box.dart';
import 'package:lifeclient/product/utility/extension/store_model_etension.dart';
import 'package:lifeclient/product/utility/mixin/app_provider_mixin.dart';
import 'package:lifeclient/product/widget/button/favorite_button/favorite_place_button.dart';
import 'package:lifeclient/product/widget/button/icon_title_button.dart';
import 'package:lifeclient/product/widget/general/general_not_found_widget.dart';
import 'package:lifeclient/product/widget/general/index.dart';
import 'package:lifeclient/product/widget/general/semantics/general_semantic.dart';
import 'package:lifeclient/product/widget/general/semantics/general_semantic_keys.dart';
import 'package:lifeclient/product/widget/icon/index.dart';
import 'package:lifeclient/product/widget/image/custom_image_with_view_dialog.dart';
import 'package:lifeclient/product/widget/text/title_description_text.dart';

part 'widget/place_detail_sub_view.dart';

final class PlaceDetailView extends ConsumerStatefulWidget {
  const PlaceDetailView({
    required this.model,
    required this.id,
    super.key,
  });

  final StoreModel model;
  final String id;

  @override
  ConsumerState<PlaceDetailView> createState() => _PlaceDetailViewState();
}

final class _PlaceDetailViewState extends ConsumerState<PlaceDetailView>
    with AppProviderMixin<PlaceDetailView>, PlaceDetailViewMixin {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(placeDetailViewModelProvider);

    if (state.isError) return const _PlaceDetailErrorView();

    if (model.documentId.isEmpty) return const _PlaceDetailLoadingView();

    return Scaffold(
      appBar: _PlaceDetailAppBar(model: model),
      bottomNavigationBar: _FindThePlaceButton(
        onCallTapped: callAction,
        onFindPlaceTapped: findThePlaceAction,
      ),
      body: _PlaceDetailBody(model: model),
    );
  }
}

final class _PlaceDetailErrorView extends StatelessWidget {
  const _PlaceDetailErrorView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: GeneralNotFoundWidget(
        title: LocaleKeys.notification_placeNotFoundErrorMessage.tr(),
      ),
    );
  }
}

final class _PlaceDetailLoadingView extends StatelessWidget {
  const _PlaceDetailLoadingView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const PlaceShimmerList(),
    );
  }
}

final class _PlaceDetailAppBar extends AppBar {
  _PlaceDetailAppBar({
    required StoreModel model,
  }) : super(
         centerTitle: true,
         title: Text(model.name),
         actions: [_ShareAddressButton(model: model)],
       );
}

final class _PlaceDetailBody extends StatelessWidget {
  const _PlaceDetailBody({required this.model});

  final StoreModel model;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        _PlaceDetailHeader(model: model),
        _PlaceDetailContent(model: model),
      ],
    );
  }
}

final class _PlaceDetailHeader extends StatelessWidget {
  const _PlaceDetailHeader({required this.model});

  final StoreModel model;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.sized.dynamicHeight(.4),
      child: _ImageWithButtonAndNameStack(model: model),
    );
  }
}

final class _PlaceDetailContent extends ConsumerWidget {
  const _PlaceDetailContent({required this.model});

  final StoreModel model;
  static bool isComment = true;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const PagePadding.defaultPadding(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const EmptyBox.largeHeight(),
          _PlaceTitleAndOwner(model: model),
          Padding(
            padding: const PagePadding.onlyTopLow(),
            child: _TownIcon(townCode: model.townCode),
          ),
          _OpenCloseTime(model: model),
          Padding(
            padding: const PagePadding.onlyTop(),
            child: TitleDescription(
              title: LocaleKeys.placeDetailView_description.tr(),
              description: model.description ?? '-',
            ),
          ),
          const Padding(
            padding: PagePadding.verticalLowSymmetric(),
            child: Divider(
              height: WidgetSizes.spacingXxs / 2,
              thickness: .3,
            ),
          ),
          TitleDescription(
            title: LocaleKeys.placeDetailView_address.tr(),
            description: model.address ?? '-',
          ),
          const Padding(
            padding: PagePadding.verticalLowSymmetric(),
            child: Divider(
              height: WidgetSizes.spacingXxs / 2,
              thickness: .3,
            ),
          ),
          RateCommentList(
            isCommentEnabled: isComment,
            placeId: model.documentId,
          ),
        ],
      ),
    );
  }
}

final class _PlaceTitleAndOwner extends StatelessWidget {
  const _PlaceTitleAndOwner({required this.model});

  final StoreModel model;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 7,
          child: GeneralContentTitle(
            value: model.updatedName,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          width: WidgetSizes.spacingXxlL13 / 2,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(AppIcons.personPin),
              Expanded(child: _OwnerTitle(model: model)),
            ],
          ),
        ),
      ],
    );
  }
}

final class _OwnerTitle extends StatelessWidget {
  const _OwnerTitle({required this.model});

  final StoreModel model;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: model.owner,
      child: Card(
        margin: EdgeInsets.zero,
        elevation: 0,
        child: Padding(
          padding: const .symmetric(horizontal: AppSpacing.xs),
          child: GeneralContentSubTitle(
            value: model.owner,
            maxLine: 3,
            textOverflow: TextOverflow.visible,
          ),
        ),
      ),
    );
  }
}

final class _ShareAddressButton extends StatelessWidget {
  const _ShareAddressButton({required this.model});

  final StoreModel model;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: _shareAddress,
      icon: const Icon(AppIcons.share),
    );
  }

  void _shareAddress() {
    '${model.updatedName} ${model.address ?? ''}'.ext.share();
  }
}
