import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/theme/app_context_colors.dart';
import 'package:lifeclient/features/community/group_detail/details/view/mixin/group_details_view_mixin.dart';
import 'package:lifeclient/features/community/group_detail/details/view/widget/group_admin_tile.dart';
import 'package:lifeclient/features/community/group_detail/details/view/widget/group_info_row.dart';
import 'package:lifeclient/features/community/group_detail/members/provider/group_members_view_model.dart';
import 'package:lifeclient/features/community/group_detail/provider/group_detail_view_model.dart';
import 'package:lifeclient/features/community/model/group_member_model.dart';
import 'package:lifeclient/features/community/model/group_model.dart';
import 'package:lifeclient/features/community/widget/group_type_presentation.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/utility/constants/app_icons.dart';
import 'package:lifeclient/product/utility/decorations/custom_radius.dart';
import 'package:lifeclient/product/utility/decorations/empty_box.dart';
import 'package:lifeclient/product/utility/extension/date_time_extension.dart';
import 'package:lifeclient/product/utility/mixin/app_provider_mixin.dart';
import 'package:lifeclient/product/widget/general/index.dart';

part 'widget/group_details_action_buttons.dart';
part 'widget/group_details_admin_list.dart';
part 'widget/group_details_info_rows.dart';
part 'widget/group_details_section.dart';

final class GroupDetailsView extends ConsumerStatefulWidget {
  const GroupDetailsView({required this.model, super.key});

  final GroupModel model;

  @override
  ConsumerState<GroupDetailsView> createState() => _GroupDetailsViewState();
}

final class _GroupDetailsViewState extends ConsumerState<GroupDetailsView>
    with AppProviderMixin<GroupDetailsView>, GroupDetailsViewMixin {
  @override
  Widget build(BuildContext context) {
    final model = widget.model;
    return ListView(
      padding: const PagePadding.horizontal16Symmetric(),
      children: [
        const EmptyBox.middleHeight(),
        _SectionLabel(
          value: LocaleKeys.community_groupDetail_details_aboutTitle.tr(),
        ),
        const EmptyBox.smallHeight(),
        _SectionCard(child: GeneralContentSubTitle(value: model.description)),
        const EmptyBox.middleHeight(),
        _SectionLabel(
          value: LocaleKeys.community_groupDetail_details_infoTitle.tr(),
        ),
        const EmptyBox.smallHeight(),
        _SectionCard(child: _InfoRows(model: model)),
        const EmptyBox.middleHeight(),
        _SectionLabel(
          value: LocaleKeys.community_groupDetail_details_adminsTitle.tr(),
        ),
        const EmptyBox.smallHeight(),
        _SectionCard(child: _AdminList(groupId: model.id)),
        const EmptyBox.largeHeight(),
        _MembershipButton(
          groupId: model.id,
          onLeave: leaveGroup,
          onDelete: deleteGroup,
        ),
        const EmptyBox.largeHeight(),
      ],
    );
  }
}
