import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/theme/app_colors.dart';
import 'package:lifeclient/core/theme/app_radius.dart';
import 'package:lifeclient/core/theme/app_shadows.dart';
import 'package:lifeclient/core/theme/app_spacing.dart';
import 'package:lifeclient/core/theme/app_text.dart';
import 'package:lifeclient/features/main/profile/view/mixin/profile_view_mixin.dart';
import 'package:lifeclient/features/main/profile/view/widget/header/profile_authenticated_header.dart';
import 'package:lifeclient/features/main/profile/view/widget/header/profile_guest_header.dart';
import 'package:lifeclient/features/main/profile/view/widget/profile_store_banner.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/navigation/app_router.dart';
import 'package:lifeclient/product/package/app_review/app_review.dart';
import 'package:lifeclient/product/utility/constants/app_icon_sizes.dart';
import 'package:lifeclient/product/utility/constants/app_icons.dart';
import 'package:lifeclient/product/utility/mixin/app_provider_mixin.dart';
import 'package:lifeclient/product/widget/bounceable/bounceable.dart';
import 'package:lifeclient/product/widget/checkbox/kvkk_checkbox.dart';
import 'package:lifeclient/product/widget/mosaic_page/view/mosaic_collapsing_page.dart';

part 'widget/profile_menu_card.dart';

final class ProfileView extends ConsumerStatefulWidget {
  const ProfileView({super.key});

  @override
  ConsumerState<ProfileView> createState() => _ProfileViewState();
}

final class _ProfileViewState extends ConsumerState<ProfileView>
    with AppProviderMixin<ProfileView>, ProfileViewMixin {
  @override
  Widget build(BuildContext context) {
    return MosaicCollapsingPage(
      headerStyle: const MosaicCollapsingHeaderStyle(
        heightFactor: .16,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.navy600, AppColors.navy400],
        ),
      ),
      header: isAuthenticated
          ? const ProfileAuthenticatedHeader()
          : const ProfileGuestHeader(),
      content: Padding(
        padding: const PagePadding.vertical12Symmetric(),
        child: Column(
          spacing: AppSpacing.sm,
          children: [
            const ProfileStoreBanner(),
            ProfileMenuCard(
              favoriteCount: favoriteCount,
              isAuthenticated: isAuthenticated,
              onAboutPressed: onAboutPressed,
              onSignOut: onSignOut,
            ),
          ],
        ),
      ),
    );
  }
}
