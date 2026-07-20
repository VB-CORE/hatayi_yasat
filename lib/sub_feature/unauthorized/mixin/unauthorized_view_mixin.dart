import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/navigation/app_router.dart';
import 'package:lifeclient/product/utility/mixin/app_provider_mixin.dart';
import 'package:lifeclient/sub_feature/unauthorized/unauthorized_view.dart';

mixin UnauthorizedViewMixin
    on ConsumerState<UnauthorizedView>, AppProviderMixin<UnauthorizedView> {
  void backToGroups() {
    if (context.canPop()) {
      context.pop();
      return;
    }
    const MainTabRoute().go(context);
  }

  // TODO(community): Yetki talep akışı tanımlanınca gerçek işlevle değişecek.
  void requestAccess() {
    appProvider.showSnackbarMessage(
      LocaleKeys.unauthorized_requestAccessComingSoon.tr(),
    );
  }
}
