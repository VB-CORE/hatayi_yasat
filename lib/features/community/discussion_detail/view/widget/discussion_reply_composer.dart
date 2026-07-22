import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/features/community/widget/community_send_button.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/utility/decorations/custom_radius.dart';

@immutable
final class DiscussionReplyComposer extends StatelessWidget {
  const DiscussionReplyComposer({
    required this.controller,
    required this.onSubmit,
    super.key,
  });

  final TextEditingController controller;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.general.colorScheme.outlineVariant,
        borderRadius: CustomRadius.xxLarge,
      ),
      child: Padding(
        padding: const PagePadding.horizontalLowVerticalVeryLowSymmetric(),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: controller,
                minLines: 1,
                maxLines: 4,
                textInputAction: TextInputAction.newline,
                decoration: InputDecoration(
                  hintText: LocaleKeys
                      .community_groupDetail_discussions_replyComposerHint
                      .tr(),
                  isCollapsed: true,
                  filled: false,
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
              ),
            ),
            ValueListenableBuilder<TextEditingValue>(
              valueListenable: controller,
              builder: (context, value, _) {
                final canSubmit = value.text.trim().isNotEmpty;
                return CommunitySendButton(
                  onTap: canSubmit ? onSubmit : null,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
