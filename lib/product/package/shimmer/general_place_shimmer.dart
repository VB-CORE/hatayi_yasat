import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:shimmer/shimmer.dart';
import 'package:vbaseproject/product/utility/padding/page_padding.dart';
import 'package:vbaseproject/product/widget/size/widget_size.dart';

final class GeneralPlaceShimmer extends StatelessWidget {
  const GeneralPlaceShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 10,
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
                  height: context.sized.dynamicHeight(.24),
                  width: context.sized.width,
                  color: context.general.colorScheme.primary,
                ),
                const Padding(
                  padding: PagePadding.vertical8Symmetric(),
                  child: Row(
                    children: [
                      _EmptyContainerTitle(),
                      Spacer(),
                      _EmptyContainerBookmark(),
                    ],
                  ),
                ),
                const _EmptyContainerDescription(),
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
      height: 20,
      width: context.sized.dynamicWidth(.8),
      color: Colors.black,
    );
  }
}

class _EmptyContainerDescription extends StatelessWidget {
  const _EmptyContainerDescription();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: context.sized.width,
      color: Colors.black,
    );
  }
}

class _EmptyContainerBookmark extends StatelessWidget {
  const _EmptyContainerBookmark();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      width: 16,
      color: Colors.black,
    );
  }
}
