import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:shimmer/shimmer.dart';
import 'package:vbaseproject/product/utility/padding/page_padding.dart';
import 'package:vbaseproject/product/utility/size/index.dart';

class PlaceShimmerList extends StatelessWidget {
  const PlaceShimmerList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 10,
      padding: const PagePadding.horizontalSymmetric(),
      separatorBuilder: (context, index) {
        return const SizedBox(height: WidgetSizes.spacingL);
      },
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300] ?? Colors.grey,
          highlightColor: Colors.grey[100] ?? Colors.grey,
          child: Center(
            child: Column(
              children: [
                Container(
                  height: context.sized.dynamicHeight(.2),
                  width: context.sized.width,
                  color: context.general.colorScheme.primary,
                ),
                const Padding(
                  padding: PagePadding.onlyTop(),
                  child: Row(
                    children: [
                      _EmptyContainerTitle(),
                      Spacer(),
                      _EmptyContainerTitle(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _EmptyContainerTitle extends StatelessWidget {
  const _EmptyContainerTitle();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 10,
      width: 50,
      color: Colors.black,
    );
  }
}
