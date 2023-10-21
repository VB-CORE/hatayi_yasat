// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:shimmer/shimmer.dart';
import 'package:vbaseproject/product/utility/constants/app_constants.dart';
import 'package:vbaseproject/product/utility/padding/page_padding.dart';

class PlaceShimmerGrid extends StatelessWidget {
  const PlaceShimmerGrid({required this.gridDelegate, super.key});

  final SliverGridDelegateWithFixedCrossAxisCount gridDelegate;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: gridDelegate,
      itemCount: 10,
      padding: const PagePadding.horizontalSymmetric(),
      shrinkWrap: true,
      itemBuilder: (_, __) => Padding(
        padding: EdgeInsets.all(AppConstants.kFour.toDouble()),
        child: Shimmer.fromColors(
          baseColor: context.general.colorScheme.onBackground.withOpacity(.1),
          highlightColor: context.general.colorScheme.background,
          child: Center(
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    height: context.sized.dynamicHeight(.25),
                    width: context.sized.width,
                    color: context.general.colorScheme.onPrimary,
                  ),
                ),
                const Padding(
                  padding: PagePadding.onlyTop(),
                  child: _EmptyContainerTitle(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _EmptyContainerTitle extends StatelessWidget {
  const _EmptyContainerTitle();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 10,
      width: context.sized.width,
      color: context.general.colorScheme.onPrimary,
    );
  }
}
