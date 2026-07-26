import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/features/auth/view_model/auth_state.dart';
import 'package:lifeclient/features/auth/view_model/auth_view_model.dart';
import 'package:lifeclient/features/community/create_group/view/widget/category_chip.dart';
import 'package:lifeclient/features/community/groups/provider/groups_view_model.dart';
import 'package:lifeclient/features/community/groups/view/mixin/groups_view_mixin.dart';
import 'package:lifeclient/features/community/groups/view/widget/group_card.dart';
import 'package:lifeclient/features/community/model/group_model.dart';
import 'package:lifeclient/features/community/provider/group_categories_view_model.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/utility/decorations/empty_box.dart';
import 'package:lifeclient/product/utility/mixin/app_provider_mixin.dart';
import 'package:lifeclient/product/widget/general/index.dart';
import 'package:lifeclient/product/widget/list_view/index.dart';

part 'widget/groups_category_filter.dart';
part 'widget/groups_list.dart';
part 'widget/groups_permission_banner.dart';

final class GroupsView extends ConsumerStatefulWidget {
  const GroupsView({super.key});

  @override
  ConsumerState<GroupsView> createState() => _GroupsViewState();
}

final class _GroupsViewState extends ConsumerState<GroupsView>
    with AppProviderMixin<GroupsView>, GroupsViewMixin {
  @override
  Widget build(BuildContext context) {
    return GeneralScaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const EmptyBox.middleHeight(),
            const _PermissionBanner(),
            const _CategoryFilter(),
            const EmptyBox.middleHeight(),
            Expanded(
              child: _GroupsList(
                onGroupTap: (model) => unawaited(onGroupTap(model)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
