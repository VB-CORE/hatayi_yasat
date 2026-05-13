import 'package:flutter/material.dart';
import 'package:lifeclient/product/model/social/sample_social_data.dart';
import 'package:lifeclient/product/utility/decorations/colors_custom.dart';

/// Solid-colour avatar with initials. Mirrors V2 design `V2Avatar`.
class V2Avatar extends StatelessWidget {
  const V2Avatar({required this.user, super.key, this.size = 36});

  final V2User user;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: user.avatarColor,
        shape: BoxShape.circle,
        boxShadow: const [
          BoxShadow(color: ColorsCustom.white, spreadRadius: 2),
        ],
      ),
      child: Text(
        user.initials,
        style: TextStyle(
          color: ColorsCustom.white,
          fontWeight: FontWeight.w700,
          fontSize: size * 0.38,
          letterSpacing: 0.2,
        ),
      ),
    );
  }
}
