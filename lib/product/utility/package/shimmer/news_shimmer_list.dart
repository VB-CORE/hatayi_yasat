import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:shimmer/shimmer.dart';
import 'package:vbaseproject/product/utility/size/widget_size.dart';

class NewsShimmerList extends StatelessWidget {
  const NewsShimmerList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 6,
      padding: EdgeInsets.zero,
      separatorBuilder: (context, index) {
        return const SizedBox(height: WidgetSizes.spacingXSSs);
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
                  height: context.sized.dynamicHeight(.45),
                  width: context.sized.width,
                  color: context.general.colorScheme.primary,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
