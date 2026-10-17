import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/theme/app_context_colors.dart';
import 'package:lifeclient/core/theme/app_radius.dart';
import 'package:lifeclient/core/theme/app_spacing.dart';
import 'package:lifeclient/core/theme/app_text.dart';
import 'package:lifeclient/features/auth/view_model/auth_state.dart';
import 'package:lifeclient/features/auth/view_model/auth_view_model.dart';
import 'package:lifeclient/features/sub_feature/notifications/provider/notification_badge_view_model.dart';
import 'package:lifeclient/product/generated/assets.gen.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/navigation/app_router.dart';
import 'package:lifeclient/product/navigation/router_notifier.dart';
import 'package:lifeclient/product/utility/constants/app_constants.dart';
import 'package:lifeclient/product/utility/constants/app_icons.dart';
import 'package:lifeclient/product/utility/decorations/custom_radius.dart';
import 'package:lifeclient/product/utility/link_actions.dart';
import 'package:lifeclient/product/widget/circle_avatar/custom_user_avatar.dart';
import 'package:lifeclient/sub_feature/main_tab/model/main_tab.dart';
import 'package:lifeclient/sub_feature/main_tab/model/speed_dial_child_model.dart';
import 'package:lifeclient/sub_feature/main_tab/model/tab_model.dart';
import 'package:lifeclient/sub_feature/main_tab/view_model/main_tab_view_model.dart';

part 'widget/web_sidebar_header.dart';
part 'widget/web_sidebar_item.dart';
part 'widget/web_sidebar_profile.dart';
part 'widget/web_sidebar_section.dart';

/// Desktop web navigation that replaces the bottom bar and the FABs.
///
/// It is built by `WebShell` above the router, so there is no `GoRouter` or
/// [Overlay] in its context: navigation goes through [goRouterProvider].
final class WebSidebar extends ConsumerWidget {
  const WebSidebar({required this.location, super.key});

  static const double width = 264;

  /// Path of the current route, used to mark the active item.
  final String location;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.read(goRouterProvider);
    final currentTab = ref.watch(
      mainTabViewModelProvider.select((state) => state.currentTab),
    );
    final unreadCount = ref.watch(
      notificationBadgeViewModelProvider.select((state) => state.unreadCount),
    );
    final hasApplication = ref.watch(
      authViewModelProvider.select((state) => state.hasApplication),
    );

    final notificationsLocation = const NotificationsRoute().location;
    final qrLocation = const UserQrRoute().location;
    final developersLocation = const DevelopersRoute().location;
    final isDevelopersRoute = location.startsWith(developersLocation);
    final isSidebarRoute =
        location == notificationsLocation ||
        location == qrLocation ||
        isDevelopersRoute;
    final applications = SpeedDialChildModelList(
      context: context,
      hasApplication: hasApplication,
    ).speedDialChildItems;

    return SizedBox(
      width: width,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: CustomRadius.extraLarge,
          boxShadow: [
            BoxShadow(
              color: context.general.colorScheme.shadow.withValues(alpha: .35),
              blurRadius: WidgetSizes.spacingXxl2,
              offset: const Offset(0, WidgetSizes.spacingS),
            ),
          ],
        ),
        child: Material(
          color: context.general.appTheme.scaffoldBackgroundColor,
          borderRadius: CustomRadius.extraLarge,
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              const _WebSidebarHeader(),
              const Divider(height: 1),
              Expanded(
                child: ListView(
                  padding: const PagePadding.generalAllLow(),
                  children: [
                    _WebSidebarSection(
                      title: LocaleKeys.webSidebar_menu.tr(),
                      children: [
                        for (final (index, item)
                            in TabModels.create().tabItems.indexed)
                          _WebSidebarItem(
                            icon: item.icon,
                            title: item.title.tr(),
                            isSelected:
                                !isSidebarRoute && currentTab.index == index,
                            onTap: () => router.go(
                              MainTabRoute(tab: MainTab.values[index]).location,
                            ),
                          ),
                        _WebSidebarItem(
                          icon: const HugeIcon(
                            icon: HugeIcons.strokeRoundedNotification01,
                          ),
                          title: LocaleKeys.home_notifications.tr(),
                          badgeCount: unreadCount,
                          isSelected: location == notificationsLocation,
                          onTap: () => router.go(notificationsLocation),
                        ),
                        _WebSidebarItem(
                          icon: const HugeIcon(
                            icon: HugeIcons.strokeRoundedQrCode,
                          ),
                          title: LocaleKeys.userQr_title.tr(),
                          isSelected: location == qrLocation,
                          onTap: () => router.go(qrLocation),
                        ),
                      ],
                    ),
                    _WebSidebarSection(
                      title: LocaleKeys.webSidebar_applications.tr(),
                      children: [
                        for (final application in applications)
                          _WebSidebarItem(
                            icon: const HugeIcon(
                              icon: HugeIcons.strokeRoundedFileAdd,
                            ),
                            title: application.title,
                            isSelected: location == application.location,
                            onTap: () => router.go(application.location),
                          ),
                      ],
                    ),
                    _WebSidebarSection(
                      title: LocaleKeys.webSidebar_more.tr(),
                      children: [
                        _WebSidebarItem(
                          icon: const HugeIcon(
                            icon: HugeIcons.strokeRoundedUserGroup,
                          ),
                          title: LocaleKeys.webSidebar_team.tr(),
                          isSelected: isDevelopersRoute,
                          onTap: () => router.go(developersLocation),
                        ),
                        _WebSidebarItem(
                          icon: const HugeIcon(
                            icon: HugeIcons.strokeRoundedLinkSquare02,
                          ),
                          title: LocaleKeys.webSidebar_visitWebsite.tr(),
                          onTap: () => LinkActions.openUrl(
                            context,
                            AppConstants.homeWebsiteUrl,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Divider(height: 1),
              _WebSidebarProfile(
                onProfileTap: () => router.go(
                  const MainTabRoute(tab: MainTab.profile).location,
                ),
                onLoginTap: () => router.go(const LoginRoute().location),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
