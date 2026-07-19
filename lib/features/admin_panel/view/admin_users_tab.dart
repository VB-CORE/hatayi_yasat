import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/theme/app_spacing.dart';
import 'package:lifeclient/features/admin_panel/model/admin_permission.dart';
import 'package:lifeclient/features/admin_panel/provider/admin_users_view_model.dart';
import 'package:lifeclient/features/admin_panel/view/mixin/admin_users_view_mixin.dart';
import 'package:lifeclient/features/admin_panel/view/widget/admin_list_shimmer.dart';
import 'package:lifeclient/features/admin_panel/view/widget/admin_verified_badge.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/model/auth/app_user.dart';
import 'package:lifeclient/product/model/auth/user_role.dart';
import 'package:lifeclient/product/utility/constants/app_constants.dart';
import 'package:lifeclient/product/utility/constants/app_icons.dart';
import 'package:lifeclient/product/utility/decorations/empty_box.dart';
import 'package:lifeclient/product/utility/extension/string_extension.dart';
import 'package:lifeclient/product/utility/mixin/app_provider_mixin.dart';
import 'package:lifeclient/product/widget/general/general_not_found_widget.dart';
import 'package:lifeclient/product/widget/general/index.dart';
import 'package:lifeclient/product/widget/general/semantics/general_semantic.dart';
import 'package:lifeclient/product/widget/general/semantics/general_semantic_keys.dart';

part 'widget/admin_user_card.dart';

final class AdminUsersTab extends ConsumerStatefulWidget {
  const AdminUsersTab({super.key});

  @override
  ConsumerState<AdminUsersTab> createState() => _AdminUsersTabState();
}

final class _AdminUsersTabState extends ConsumerState<AdminUsersTab>
    with AppProviderMixin<AdminUsersTab>, AdminUsersViewMixin {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(adminUsersViewModelProvider);
    if (state.isError) {
      return GeneralNotFoundWidget(
        title: LocaleKeys.admin_usersLoadFailed.tr(),
        onRefresh: onRetry,
      );
    }
    if (state.isFetching) return const AdminListShimmer();
    if (state.users.isEmpty) {
      return GeneralNotFoundWidget(
        title: LocaleKeys.admin_usersEmpty.tr(),
        onRefresh: onRetry,
      );
    }
    return GeneralSemantic(
      semanticKey: GeneralSemanticKeys.adminUsersTab,
      child: NotificationListener<ScrollNotification>(
        onNotification: onScrollNotification,
        child: ListView.separated(
          padding: const PagePadding.vertical12Symmetric(),
          itemCount:
              state.users.length +
              (state.isFetchingMore ? AppConstants.kOne : AppConstants.kZero),
          separatorBuilder: (context, index) => Divider(
            indent: AppSpacing.md,
            height: AppConstants.kOne.toDouble(),
          ),
          itemBuilder: (context, index) {
            if (index == state.users.length) {
              return const Padding(
                padding: PagePadding.vertical12Symmetric(),
                child: Center(child: CircularProgressIndicator.adaptive()),
              );
            }
            final user = state.users[index];
            return _AdminUserCard(
              key: ValueKey(user.uid),
              user: user,
              onTap: () => onUserTap(user.uid),
            );
          },
        ),
      ),
    );
  }
}
