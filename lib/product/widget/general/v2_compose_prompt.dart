import 'package:flutter/material.dart';
import 'package:lifeclient/product/widget/circle_avatar/v2_avatar.dart';
import 'package:lifeclient/product/model/social/sample_social_data.dart';
import 'package:lifeclient/product/utility/decorations/colors_custom.dart';

/// Inline compose prompt that sits at the top of the feed.
class V2ComposePrompt extends StatelessWidget {
  const V2ComposePrompt({
    required this.user,
    super.key,
    this.placeholder = "Bugün Hatay'da neler oluyor?",
    this.onTap,
  });

  final V2User user;
  final String placeholder;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
        decoration: const BoxDecoration(
          color: ColorsCustom.white,
          border: Border(bottom: BorderSide(color: ColorsCustom.ink50)),
        ),
        child: Row(
          children: [
            V2Avatar(user: user),
            const SizedBox(width: 12),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: ColorsCustom.bgCool,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  placeholder,
                  style: const TextStyle(
                    fontSize: 13.5,
                    color: ColorsCustom.ink400,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: ColorsCustom.navy50,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.photo_camera_rounded,
                size: 18,
                color: ColorsCustom.navy,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
