import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:shimmer/shimmer.dart';
import 'package:vbaseproject/product/utility/constants/app_constants.dart';
import 'package:vbaseproject/product/utility/padding/page_padding.dart';

class PlaceShimmerGrid extends StatelessWidget {
  const PlaceShimmerGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: _gridDelegate,
      itemCount: 10,
      padding: const PagePadding.horizontalSymmetric(),
      shrinkWrap: true,
      itemBuilder: (_, __) => Padding(
        padding: EdgeInsets.all(AppConstants.kFour.toDouble()),
        child: Shimmer.fromColors(
          baseColor: Colors.grey[300] ?? Colors.grey,
          highlightColor: Colors.grey[100] ?? Colors.grey,
          child: Center(
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    height: context.sized.dynamicHeight(.25),
                    width: context.sized.width,
                    color: context.general.colorScheme.primary,
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

  SliverGridDelegateWithFixedCrossAxisCount get _gridDelegate {
    return const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: AppConstants.kTwo,
      childAspectRatio: AppConstants.kThree / AppConstants.kFour,
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
      color: Colors.black,
    );
  }
}
