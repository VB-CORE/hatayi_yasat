import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/features/auth/view/mixin/login_view_mixin.dart';
import 'package:lifeclient/features/auth/view_model/auth_state.dart';
import 'package:lifeclient/features/auth/view_model/auth_view_model.dart';
import 'package:lifeclient/product/generated/assets.gen.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/utility/constants/app_constants.dart';
import 'package:lifeclient/product/utility/decorations/colors_custom.dart';
import 'package:lifeclient/product/utility/decorations/custom_radius.dart';
import 'package:lifeclient/product/utility/decorations/empty_box.dart';
import 'package:lifeclient/product/utility/mixin/app_provider_mixin.dart';
import 'package:lifeclient/product/widget/button/apple_sign_in_button.dart';
import 'package:lifeclient/product/widget/button/google_sign_in_button.dart';
import 'package:lifeclient/product/widget/general/index.dart';

part 'sub_view/login_app_header.dart';
part 'sub_view/login_google_sign_in_button.dart';
part 'sub_view/login_guest_button.dart';
part 'sub_view/login_hero_text.dart';
part 'sub_view/login_legal_text.dart';

final class LoginView extends ConsumerStatefulWidget {
  const LoginView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginViewState();
}

final class _LoginViewState extends ConsumerState<LoginView>
    with AppProviderMixin<LoginView>, LoginViewMixin {
  @override
  Widget build(BuildContext context) {
    return GeneralScaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const EmptyBox.largeXHeight(),
            const _LoginAppHeader(),
            const Spacer(),
            const _LoginHeroText(),
            const EmptyBox(height: WidgetSizes.spacingXxl3),
            _GoogleSignInButtonConsumer(onTap: onGoogleSignIn),
            const EmptyBox.middleHeight(),
            // TODO(auth): Apple Sign-In şu an bağlı değil, öncelik Google Sign-In.
            AppleSignInButton(onTap: () {}),
            const EmptyBox.middleHeight(),
            _LoginGuestButton(onTap: onGuestTap),
            const EmptyBox.middleHeight(),
            const _LoginLegalText(),
            const EmptyBox.largeHeight(),
          ],
        ),
      ),
    );
  }
}
