import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:lifeclient/core/theme/app_radius.dart';
import 'package:lifeclient/features/community/rate/view/widget/rate_card.dart';
import 'package:lifeclient/features/community/rate/view/widget/rate_comment_options_sheet.dart';

final class RateSheetFactory {
  const RateSheetFactory._();

  static RoundedRectangleBorder get _topRoundedShape =>
      RoundedRectangleBorder(borderRadius: AppRadius.sheet);

  static Future<RateCommentOptionAction?> showCommentOptions(
    BuildContext context,
  ) {
    return showModalBottomSheet<RateCommentOptionAction>(
      context: context,
      shape: _topRoundedShape,
      builder: (context) => const RateCommentOptionsSheet(),
    );
  }

  static Future<void> showRateCard(
    BuildContext context, {
    required String placeId,
    String? initialComment,
  }) {
    return showModalBottomSheet<void>(
      context: context,
      useSafeArea: true,
      isScrollControlled: true,
      shape: _topRoundedShape,
      builder: (sheetContext) => Padding(
        padding: EdgeInsets.only(
          bottom: sheetContext.general.keyboardPadding,
        ),
        child: RateCard(
          placeId: placeId,
          initialComment: initialComment,
          onSubmitted: () => Navigator.of(sheetContext).pop(),
        ),
      ),
    );
  }
}
