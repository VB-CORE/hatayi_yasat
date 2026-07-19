import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/model/auth/app_user.dart';

enum AdminPermission {
  createIssue,
  createGroup
  ;

  String get titleKey => switch (this) {
    AdminPermission.createIssue => LocaleKeys.admin_canCreateIssueTitle,
    AdminPermission.createGroup => LocaleKeys.admin_canCreateGroupTitle,
  };

  String get subtitleKey => switch (this) {
    AdminPermission.createIssue => LocaleKeys.admin_canCreateIssueSubtitle,
    AdminPermission.createGroup => LocaleKeys.admin_canCreateGroupSubtitle,
  };

  bool isEnabledFor(AppUser user) => switch (this) {
    AdminPermission.createIssue => user.canCreateIssue,
    AdminPermission.createGroup => user.canCreateGroup,
  };

  AppUser toggle(AppUser user) => switch (this) {
    AdminPermission.createIssue => user.copyWith(
      canCreateIssue: !user.canCreateIssue,
    ),
    AdminPermission.createGroup => user.copyWith(
      canCreateGroup: !user.canCreateGroup,
    ),
  };
}
