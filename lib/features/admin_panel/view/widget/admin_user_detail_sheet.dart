import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/theme/app_radius.dart';
import 'package:lifeclient/features/admin_panel/model/admin_permission.dart';
import 'package:lifeclient/features/admin_panel/provider/admin_users_view_model.dart';
import 'package:lifeclient/features/admin_panel/view/widget/admin_verified_badge.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/model/auth/app_user.dart';
import 'package:lifeclient/product/model/auth/user_role.dart';
import 'package:lifeclient/product/utility/decorations/empty_box.dart';
import 'package:lifeclient/product/utility/extension/string_extension.dart';
import 'package:lifeclient/product/widget/general/index.dart';
import 'package:lifeclient/product/widget/general/semantics/general_semantic.dart';
import 'package:lifeclient/product/widget/general/semantics/general_semantic_keys.dart';

final class AdminUserDetailSheet extends ConsumerWidget {
  const AdminUserDetailSheet({required this.uid, super.key});

  final String uid;

  static Future<void> show(BuildContext context, {required String uid}) {
    return showModalBottomSheet<void>(
      context: context,
      useSafeArea: true,
      shape: RoundedRectangleBorder(borderRadius: AppRadius.sheet),
      builder: (context) => AdminUserDetailSheet(uid: uid),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(
      adminUsersViewModelProvider.select(
        (state) => state.users.firstWhereOrNull((item) => item.uid == uid),
      ),
    );
    final isProcessing = ref.watch(
      adminUsersViewModelProvider.select(
        (state) => state.processingUids.contains(uid),
      ),
    );
    if (user == null) return const EmptyBox();
    return GeneralSemantic(
      semanticKey: GeneralSemanticKeys.adminUserDetailSheet,
      child: SingleChildScrollView(
        padding: const PagePadding.all(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _AdminUserHeader(user: user),
            const EmptyBox.middleHeight(),
            GeneralContentSubTitle(
              value: LocaleKeys.admin_permissionsTitle.tr(),
              fontWeight: FontWeight.w700,
            ),
            const EmptyBox.smallHeight(),
            ...AdminPermission.values.map(
              (permission) => SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(permission.titleKey.tr()),
                subtitle: Text(permission.subtitleKey.tr()),
                value: permission.isEnabledFor(user),
                onChanged: isProcessing
                    ? null
                    : (_) => ref
                          .read(adminUsersViewModelProvider.notifier)
                          .togglePermission(uid: uid, permission: permission),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

@immutable
final class _AdminUserHeader extends StatelessWidget {
  const _AdminUserHeader({required this.user});

  final AppUser user;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.general.colorScheme;
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: colorScheme.secondaryContainer,
          child: GeneralContentSmallTitle(
            value: user.displayName.initials(take: 1),
            color: colorScheme.onSecondaryContainer,
            fontWeight: FontWeight.w700,
          ),
        ),
        const EmptyBox.middleWidth(),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GeneralContentTitle(value: user.displayName, maxLine: 1),
              GeneralContentSubTitle(
                value: user.email,
                maxLine: 1,
                color: colorScheme.onSurfaceVariant,
              ),
            ],
          ),
        ),
        if (user.role == UserRole.merchant) ...[
          const EmptyBox.smallWidth(),
          const AdminVerifiedBadge(),
        ],
      ],
    );
  }
}
