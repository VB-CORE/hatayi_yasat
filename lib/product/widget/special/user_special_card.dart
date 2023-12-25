import 'package:flutter/material.dart';
import 'package:vbaseproject/product/widget/listtile/author_listtile_widget.dart';

@immutable
final class SpecialUser {
  const SpecialUser({
    required this.name,
    required this.photoUrl,
  });
  final String name;
  final String photoUrl;

  /// Todo: Add your special user to database
  static const SpecialUser creator = SpecialUser(
    name: '@grafikherif',
    photoUrl:
        'https://pbs.twimg.com/profile_images/1643695427840098306/ugEFQ49l_400x400.jpg',
  );
}

@immutable
final class UserSpecialCard extends StatelessWidget {
  const UserSpecialCard({required this.user, super.key});
  final SpecialUser user;
  @override
  Widget build(BuildContext context) {
    return AuthorListTileWidget(
      image: user.photoUrl,
      text: user.name,
      describtion: '',
      onDeleteTapped: () {},
    );
  }
}
