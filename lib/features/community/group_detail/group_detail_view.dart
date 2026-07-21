import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifeclient/features/community/group_detail/details/view/group_details_view.dart';
import 'package:lifeclient/features/community/group_detail/discussions/view/group_discussions_view.dart';
import 'package:lifeclient/features/community/group_detail/wall/view/group_wall_view.dart';
import 'package:lifeclient/features/community/group_detail/widget/group_detail_sliver_header.dart';
import 'package:lifeclient/features/community/model/group_model.dart';
import 'package:lifeclient/product/utility/constants/app_constants.dart';

final class GroupDetailView extends ConsumerWidget {
  const GroupDetailView({required this.model, super.key});

  final GroupModel model;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: DefaultTabController(
        length: AppConstants.kThree,
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            GroupDetailSliverHeader(model: model),
          ],
          body: TabBarView(
            children: [
              GroupWallView(model: model),
              GroupDiscussionsView(model: model),
              GroupDetailsView(model: model),
            ],
          ),
        ),
      ),
    );
  }
}
