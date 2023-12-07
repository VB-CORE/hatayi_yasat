import 'package:flutter/material.dart';
import 'package:vbaseproject/product/utility/decorations/custom_circle_radius.dart';
import 'package:vbaseproject/product/utility/padding/page_padding.dart';

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

final class UserSpecialCard extends StatelessWidget {
  const UserSpecialCard({required this.user, super.key});
  final SpecialUser user;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: CustomCircleRadius.small,
          backgroundImage: NetworkImage(
            user.photoUrl,
          ),
        ),
        Expanded(
          child: Padding(
            padding: const PagePadding.onlyLeftLow(),
            child: Text(user.name),
          ),
        ),
      ],
    );
  }
}
