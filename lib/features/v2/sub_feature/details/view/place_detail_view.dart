import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:vbaseproject/features/v2/sub_feature/forms/view/model/place_request_model.dart';
import 'package:vbaseproject/product/package/custom_network_image.dart';
import 'package:vbaseproject/product/utility/constants/index.dart';
import 'package:vbaseproject/product/utility/padding/page_padding.dart';
import 'package:vbaseproject/product/widget/container/circle_image_with_text_container.dart';
import 'package:vbaseproject/product/widget/general/index.dart';
import 'package:vbaseproject/product/widget/size/index.dart';

final class PlaceDetailView extends ConsumerStatefulWidget {
  const PlaceDetailView({required this.model, super.key});
  // TODO: Replace with response model
  final PlaceRequestModel model;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PlaceDetailViewState();
}

class _PlaceDetailViewState extends ConsumerState<PlaceDetailView> {
  // TODOÇ Replace with response model
  final PlaceRequestModel _model = PlaceRequestModel.dummyData;
  final String _randomImage = 'https://picsum.photos/seed/picsum/200/300';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const PagePadding.horizontalSymmetric(),
            child: Column(
              children: [
                _ImageWithButtonAndNameStack(
                  randomImage: _randomImage,
                  model: _model,
                ),
                context.sized.emptySizedHeightBoxNormal,
                GeneralBodyTitle(_model.placeName),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

final class _ImageWithButtonAndNameStack extends StatelessWidget {
  const _ImageWithButtonAndNameStack({
    required this.randomImage,
    required this.model,
  });

  final String randomImage;
  final PlaceRequestModel model;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        _ImageSizedBox(randomImage: randomImage),
        _BackButtonContainer(
          onPressed: () {},
        ),
        _CircleImageWithNamePositioned(
          randomImage: randomImage,
          model: model,
        ),
      ],
    );
  }
}

final class _ImageSizedBox extends StatelessWidget {
  const _ImageSizedBox({
    required String randomImage,
  }) : _randomImage = randomImage;

  final String _randomImage;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.sized.width,
      height: context.sized.dynamicHeight(0.3),
      child: ClipRRect(
        borderRadius: context.border.lowBorderRadius,
        child: CustomNetworkImage(
          imageUrl: _randomImage,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

final class _BackButtonContainer extends StatelessWidget {
  const _BackButtonContainer({
    required this.onPressed,
  });
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const PagePadding.allLow(),
      width: WidgetSizes.spacingXxl9,
      height: WidgetSizes.spacingXxl9,
      child: FloatingActionButton(
        onPressed: onPressed,
        backgroundColor: context.general.colorScheme.primary,
        child: Icon(
          AppIcons.leftSelect,
          size: WidgetSizes.spacingXxl2,
          color: context.general.colorScheme.secondary,
        ),
      ),
    );
  }
}

class _CircleImageWithNamePositioned extends StatelessWidget {
  const _CircleImageWithNamePositioned({
    required String randomImage,
    required PlaceRequestModel model,
  })  : _randomImage = randomImage,
        _model = model;

  final String _randomImage;
  final PlaceRequestModel _model;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: -WidgetSizes.spacingXl,
      left: WidgetSizes.spacingXxl2,
      child: CircleImageWithTextContainer(
        imageUrl: _randomImage,
        name: _model.placeOwnerName,
      ),
    );
  }
}
