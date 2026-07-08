import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/theme/app_colors.dart';
import 'package:lifeclient/features/community/create_group/view/create_group_view.dart';
import 'package:lifeclient/features/community/groups/provider/groups_state.dart';
import 'package:lifeclient/features/community/groups/provider/groups_view_model.dart';
import 'package:lifeclient/features/community/groups/view/mixin/groups_view_mixin.dart';
import 'package:lifeclient/features/community/groups/view/widget/group_card.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/utility/constants/app_icons.dart';
import 'package:lifeclient/product/utility/decorations/empty_box.dart';
import 'package:lifeclient/product/utility/mixin/app_provider_mixin.dart';
import 'package:lifeclient/product/widget/general/general_not_found_widget.dart';
import 'package:lifeclient/product/widget/general/index.dart';

part 'sub_view/groups_header.dart';
part 'sub_view/groups_list_builder.dart';

final class GroupsView extends ConsumerStatefulWidget {
  const GroupsView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _GroupsViewState();
}

final class _GroupsViewState extends ConsumerState<GroupsView>
    with AppProviderMixin<GroupsView>, GroupsViewMixin {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(groupsViewModelProvider);
    return GeneralScaffold(
      floatingActionButton: FloatingActionButton(
        // TODO(community): Geçici test navigasyonu — route guard bypass
        // edildi, CreateGroupView'u görmek için düz push kullanılıyor.
        // onPressed: () => const CreateGroupRoute().push<void>(context),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute<void>(
              builder: (context) => const CreateGroupView(),
            ),
          );
        },
        child: const Icon(AppIcons.add),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const EmptyBox.middleHeight(),
            _GroupsHeader(state: state),
            const EmptyBox.middleHeight(),
            if (!canCreateGroup) ...[
              GeneralInfoBanner(
                message: LocaleKeys.community_groups_noPermissionInfo.tr(),
              ),
              const EmptyBox.middleHeight(),
            ],
            const Expanded(child: _GroupsListBuilder()),
          ],
        ),
      ),
    );
  }
}
