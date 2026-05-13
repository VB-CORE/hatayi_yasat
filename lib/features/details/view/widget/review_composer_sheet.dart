import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart' show ContextExtension;
import 'package:lifeclient/product/init/application_theme.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/repository/reviews/review_input.dart';
import 'package:lifeclient/product/repository/reviews/reviews_repository_provider.dart';
import 'package:lifeclient/product/utility/decorations/custom_radius.dart';
import 'package:lifeclient/product/utility/decorations/empty_box.dart';
import 'package:lifeclient/product/widget/brand/eyebrow.dart';

/// Show the V2 review composer for a place. Resolves to `true` when the
/// user submits a review, `false` (or `null`) on cancel.
Future<bool?> showV2ReviewComposerSheet(
  BuildContext context, {
  required String placeId,
}) {
  return showModalBottomSheet<bool>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => _Body(placeId: placeId),
  );
}

class _Body extends ConsumerStatefulWidget {
  const _Body({required this.placeId});

  final String placeId;

  @override
  ConsumerState<_Body> createState() => _BodyState();
}

class _BodyState extends ConsumerState<_Body> {
  final _textCtrl = TextEditingController();
  int _rating = 5;
  bool _anonymous = false;
  bool _submitting = false;

  @override
  void dispose() {
    _textCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.general.colorScheme;
    final textTheme = context.general.textTheme;
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: colorScheme.secondary,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(24),
          ),
        ),
        padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: colorScheme.onPrimaryContainer,
                  borderRadius: const BorderRadius.all(Radius.circular(99)),
                ),
              ),
            ),
            const EmptyBox.middleHeight(),
            Eyebrow(LocaleKeys.placeDetailV2_writeReview.tr()),
            const EmptyBox.smallHeight(),
            Text(
              LocaleKeys.reviewComposer_title.tr(),
              style: V2Typography.display(
                fontSize: 26,
                color: colorScheme.onSurface,
              ),
            ),
            const EmptyBox.middleHeight(),
            Text(
              LocaleKeys.reviewComposer_ratingLabel.tr(),
              style: textTheme.labelMedium?.copyWith(
                color: colorScheme.onPrimaryFixedVariant,
                fontWeight: FontWeight.w700,
              ),
            ),
            const EmptyBox.smallHeight(),
            Row(
              children: [
                for (var i = 1; i <= 5; i++)
                  IconButton(
                    onPressed: () => setState(() => _rating = i),
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    constraints: const BoxConstraints(),
                    icon: Icon(
                      i <= _rating
                          ? Icons.star_rounded
                          : Icons.star_border_rounded,
                      color: i <= _rating
                          ? colorScheme.tertiary
                          : colorScheme.onSecondaryFixed,
                      size: 32,
                    ),
                  ),
              ],
            ),
            const EmptyBox.middleHeight(),
            TextField(
              controller: _textCtrl,
              maxLines: 4,
              maxLength: 400,
              decoration: InputDecoration(
                hintText: LocaleKeys.reviewComposer_textPlaceholder.tr(),
                filled: true,
                fillColor: colorScheme.onPrimaryFixed,
                border: const OutlineInputBorder(
                  borderRadius: CustomRadius.medium,
                  borderSide: BorderSide.none,
                ),
              ),
              style: textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurface,
              ),
            ),
            const EmptyBox.smallHeight(),
            Row(
              children: [
                Switch(
                  value: _anonymous,
                  onChanged: (v) => setState(() => _anonymous = v),
                  activeThumbColor: colorScheme.primary,
                ),
                const EmptyBox.smallWidth(),
                Expanded(
                  child: Text(
                    LocaleKeys.reviewComposer_anonymousLabel.tr(),
                    style: textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurface,
                    ),
                  ),
                ),
              ],
            ),
            const EmptyBox.middleHeight(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _submitting || _textCtrl.text.trim().isEmpty
                    ? null
                    : _submit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: colorScheme.error,
                  foregroundColor: colorScheme.onPrimary,
                  disabledBackgroundColor: colorScheme.onPrimaryContainer,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: const RoundedRectangleBorder(
                    borderRadius: CustomRadius.medium,
                  ),
                ),
                child: _submitting
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : Text(
                        LocaleKeys.reviewComposer_submit.tr(),
                        style: const TextStyle(fontWeight: FontWeight.w800),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _submit() async {
    setState(() => _submitting = true);
    final colorScheme = context.general.colorScheme;
    try {
      await ref
          .read(reviewsRepositoryProvider)
          .submit(
            CreateReviewInput(
              placeId: widget.placeId,
              rating: _rating,
              text: _textCtrl.text.trim(),
              anonymous: _anonymous,
            ),
          );
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: colorScheme.primaryContainer,
          content: Text(LocaleKeys.reviewComposer_submitOk.tr()),
        ),
      );
      Navigator.of(context).pop(true);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: colorScheme.error,
          content: Text(e.toString()),
        ),
      );
      setState(() => _submitting = false);
    }
  }
}
