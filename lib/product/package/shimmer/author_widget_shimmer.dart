import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:vbaseproject/product/utility/decorations/custom_circle_radius.dart';
import 'package:vbaseproject/product/utility/padding/page_padding.dart';
import 'package:vbaseproject/product/widget/size/widget_size.dart';

final class AuthorWidgetShimmer extends StatelessWidget {
  const AuthorWidgetShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300] ?? Colors.grey,
          highlightColor: Colors.grey[100] ?? Colors.grey,
          child: const Center(
            child: Padding(
              padding: PagePadding.vertical8Symmetric(),
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                dense: true,
                horizontalTitleGap: WidgetSizes.spacingXs,
                leading: _EmptyCircleAvatar(),
                title: _EmptyContainerTitle(),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _EmptyCircleAvatar extends StatelessWidget {
  const _EmptyCircleAvatar();

  @override
  Widget build(BuildContext context) {
    return const CircleAvatar(radius: CustomCircleRadius.medium);
  }
}

class _EmptyContainerTitle extends StatelessWidget {
  const _EmptyContainerTitle();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32,
      color: Colors.black,
    );
  }
}
