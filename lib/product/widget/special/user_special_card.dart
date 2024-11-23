import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:lifeclient/product/widget/list_tile/author_listtile_widget.dart';
import 'package:lifeclient/product/widget/special/special_user.dart';
import 'package:lifeclient/product/widget/tap_area/tap_area.dart';

@immutable
final class UserSpecialCard extends StatelessWidget {
  const UserSpecialCard({this.user = SpecialUser.creator, super.key});
  final SpecialUser user;
  @override
  Widget build(BuildContext context) {
    return TapArea(
      onTap: user.webUrl.ext.launchWebsiteCustom,
      child: AuthorListTileWidget(
        image: user.photoUrl,
        text: user.name,
        description: '',
      ),
    );
  }
}
