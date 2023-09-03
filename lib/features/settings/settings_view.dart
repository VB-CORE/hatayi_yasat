import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kartal/kartal.dart';
import 'package:vbaseproject/features/settings/subview/index.dart';
import 'package:vbaseproject/product/init/language/locale_keys.g.dart';
import 'package:vbaseproject/product/utility/constants/string_constants.dart';
import 'package:vbaseproject/product/widget/circle_avatar/social_media_circle_avatar.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
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
              title: Text(LocaleKeys.settings_language_title.tr()),
              trailing: const LanguageChangeWidget(),
            ),
            ListTile(
              title: Text(LocaleKeys.settings_theme_title.tr()),
              trailing: ThemeSwitchWidget(
                onChanged: (bool value) {},
              ),
            ),
            ListTile(
              title: Text(LocaleKeys.settings_version_number_title.tr()),
              trailing: Text(
                '1.0.0',
                style: context.general.textTheme.titleSmall,
              ),
            ),
            const Spacer(),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SocialMediaCircleAvatar(
                  iconData: FontAwesomeIcons.youtube,
                  webUrl: StringConstants.youtubeUrl,
                ),
                SocialMediaCircleAvatar(
                  iconData: FontAwesomeIcons.facebook,
                  webUrl: StringConstants.facebookUrl,
                ),
                SocialMediaCircleAvatar(
                  iconData: FontAwesomeIcons.instagram,
                  webUrl: StringConstants.instagram,
                ),
                SocialMediaCircleAvatar(
                  iconData: FontAwesomeIcons.twitter,
                  webUrl: StringConstants.twitterUrl,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
