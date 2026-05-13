import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart' show ContextExtension;
import 'package:lifeclient/product/init/application_theme.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/utility/decorations/custom_radius.dart';
import 'package:lifeclient/product/utility/decorations/empty_box.dart';
import 'package:lifeclient/product/widget/brand/eyebrow.dart';

/// V2 delete-account confirmation. The destructive action is gated by a
/// keyword ("sil" in Turkish, "delete" in English) the user must type
/// verbatim before the confirm button enables. Returns `true` if the
/// user confirmed.
Future<bool> showV2DeleteAccountDialog(BuildContext context) async {
  final result = await showDialog<bool>(
    context: context,
    builder: (_) => const _Body(),
  );
  return result ?? false;
}

class _Body extends StatefulWidget {
  const _Body();

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  final _controller = TextEditingController();
  bool _canDelete = false;

  late final String _keyword = LocaleKeys.dialogs_deleteConfirmKeyword
      .tr()
      .toLowerCase();

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    final next = _controller.text.trim().toLowerCase() == _keyword;
    if (next != _canDelete) {
      setState(() => _canDelete = next);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.general.colorScheme;
    final textTheme = context.general.textTheme;
    return Dialog(
      backgroundColor: colorScheme.secondary,
      shape: const RoundedRectangleBorder(borderRadius: CustomRadius.large),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: colorScheme.error.withValues(alpha: 0.12),
                borderRadius: CustomRadius.medium,
              ),
              child: Icon(
                Icons.warning_amber_rounded,
                color: colorScheme.error,
                size: 26,
              ),
            ),
            const EmptyBox.middleHeight(),
            Eyebrow(
              LocaleKeys.dialogs_deleteEyebrow.tr(),
              color: colorScheme.error,
            ),
            const EmptyBox.smallHeight(),
            Text(
              LocaleKeys.dialogs_deleteTitle.tr(),
              style: V2Typography.display(
                fontSize: 26,
                color: colorScheme.onSurface,
              ),
            ),
            const EmptyBox.smallHeight(),
            Text(
              LocaleKeys.dialogs_deleteBody.tr(),
              style: textTheme.bodyMedium?.copyWith(
                color: colorScheme.onPrimaryFixedVariant,
                height: 1.5,
              ),
            ),
            const EmptyBox.middleHeight(),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: colorScheme.onPrimaryFixed,
                borderRadius: CustomRadius.medium,
              ),
              child: Text(
                LocaleKeys.dialogs_deleteKvkkNote.tr(),
                style: textTheme.labelMedium?.copyWith(
                  color: colorScheme.onSecondaryFixed,
                  height: 1.5,
                ),
              ),
            ),
            const EmptyBox.middleHeight(),
            Text(
              LocaleKeys.dialogs_deleteConfirmPrompt.tr(),
              style: textTheme.labelMedium?.copyWith(
                color: colorScheme.onPrimaryFixedVariant,
                fontWeight: FontWeight.w700,
              ),
            ),
            const EmptyBox.smallHeight(),
            TextField(
              controller: _controller,
              autofocus: true,
              decoration: InputDecoration(
                hintText: '"${_keyword.toUpperCase()}"',
                filled: true,
                fillColor: colorScheme.onPrimaryFixed,
                border: const OutlineInputBorder(
                  borderRadius: CustomRadius.medium,
                  borderSide: BorderSide.none,
                ),
              ),
              style: textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurface,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.5,
              ),
            ),
            const EmptyBox.middleHeight(),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: colorScheme.onSurface,
                      side: BorderSide(color: colorScheme.onPrimaryContainer),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: const RoundedRectangleBorder(
                        borderRadius: CustomRadius.medium,
                      ),
                    ),
                    child: Text(LocaleKeys.dialogs_deleteCancel.tr()),
                  ),
                ),
                const EmptyBox.smallWidth(),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _canDelete
                        ? () => Navigator.of(context).pop(true)
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorScheme.error,
                      foregroundColor: colorScheme.onPrimary,
                      disabledBackgroundColor: colorScheme.error.withValues(
                        alpha: 0.3,
                      ),
                      disabledForegroundColor: colorScheme.onPrimary.withValues(
                        alpha: 0.6,
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: const RoundedRectangleBorder(
                        borderRadius: CustomRadius.medium,
                      ),
                    ),
                    child: Text(
                      LocaleKeys.dialogs_deleteConfirm.tr(),
                      style: const TextStyle(fontWeight: FontWeight.w800),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
