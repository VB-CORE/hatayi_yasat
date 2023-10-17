import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kartal/kartal.dart';
import 'package:vbaseproject/features/settings_module/developers/developers_view.dart';
import 'package:vbaseproject/features/settings_module/settings/subview/index.dart';
import 'package:vbaseproject/features/settings_module/settings/subview/notification_permission_checkbox.dart';
import 'package:vbaseproject/product/init/language/locale_keys.g.dart';
import 'package:vbaseproject/product/utility/constants/string_constants.dart';
import 'package:vbaseproject/product/utility/mixin/index.dart';
import 'package:vbaseproject/product/utility/padding/page_padding.dart';
import 'package:vbaseproject/product/widget/circle_avatar/social_media_circle_avatar.dart';

class SettingsView extends ConsumerStatefulWidget {
  const SettingsView({super.key});

  @override
  ConsumerState<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends ConsumerState<SettingsView>
    with AppProviderMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.settings_title.tr()),
      ),
      body: SafeArea(
        child: Column(
          children: [
            ListTile(
              title: Text(LocaleKeys.settings_languageTitle.tr()),
              trailing: const LanguageChangeWidget(),
            ),
            const ListTile(
              title: _ThemeTitle(),
              trailing: ThemeSwitchWidget(),
            ),
            ListTile(
              title: Text(LocaleKeys.settings_versionNumberTitle.tr()),
              trailing: const _VersionText(),
            ),
            const NotificationPermissionView(),
            const Divider(),
            ListTile(
              title: Text(LocaleKeys.developers_title.tr()),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => context.route.navigateToPage(const DevelopersView()),
            ),
            const Spacer(),
            const Padding(
              padding: PagePadding.onlyBottomMedium(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SocialMediaCircleAvatar(
                    iconData: FontAwesomeIcons.instagram,
                    webUrl: StringConstants.instagramUrl,
                  ),
                  SocialMediaCircleAvatar(
                    iconData: FontAwesomeIcons.twitter,
                    webUrl: StringConstants.twitterUrl,
                  ),
                  SocialMediaCircleAvatar(
                    iconData: FontAwesomeIcons.youtube,
                    webUrl: StringConstants.youtubeUrl,
                  ),
                  SocialMediaCircleAvatar(
                    iconData: FontAwesomeIcons.laptop,
                    webUrl: StringConstants.websiteUrl,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ThemeTitle extends ConsumerWidget
    with AppProviderStateMixin<_ThemeTitle> {
  const _ThemeTitle();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkTheme = appStateWatch(ref).theme == ThemeMode.dark;
    return Text(
      LocaleKeys.settings_themeTitle.tr(
        args: [
          if (isDarkTheme)
            LocaleKeys.settings_themes_dark.tr()
          else
            LocaleKeys.settings_themes_light.tr(),
        ],
      ),
    );
  }
}

class _VersionText extends StatelessWidget {
  const _VersionText();

  @override
  Widget build(BuildContext context) {
    return Text(
      ''.ext.version,
      style: context.general.textTheme.titleSmall?.copyWith(
        color: context.general.colorScheme.onSurface,
      ),
    );
  }
}
