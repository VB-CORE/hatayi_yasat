import 'package:flutter/foundation.dart';

@immutable
final class SpecialUser {
  const SpecialUser({
    required this.name,
    required this.photoUrl,
    required this.webUrl,
  });
  final String name;
  final String photoUrl;
  final String webUrl;

  static const SpecialUser creator = SpecialUser(
    name: '@grafikherif',
    photoUrl:
        'https://pbs.twimg.com/profile_images/1643695427840098306/ugEFQ49l_400x400.jpg',
    webUrl: 'https://twitter.com/grafikherif',
  );
}
