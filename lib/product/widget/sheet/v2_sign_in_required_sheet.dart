import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lifeclient/product/init/application_theme.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/utility/decorations/colors_custom.dart';
import 'package:lifeclient/product/widget/brand/eyebrow.dart';

/// V2 sign-in gate. Shown when a guarded action (compose, like, save,
/// review) is invoked without a signed-in user. While FirebaseAuth is
/// not yet wired, the primary CTA is disabled and labelled "Yakında".
Future<void> showV2SignInRequiredSheet(
  BuildContext context, {
  String? action,
}) {
  return showModalBottomSheet<void>(
    context: context,
    backgroundColor: ColorsCustom.navy,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (_) => _Body(action: action ?? ''),
  );
}

class _Body extends StatelessWidget {
  const _Body({required this.action});

  final String action;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Padding(
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
                  color: ColorsCustom.white.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(99),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Eyebrow(
              LocaleKeys.dialogs_signInRequiredEyebrow.tr(),
              color: ColorsCustom.coral300,
            ),
            const SizedBox(height: 8),
            Text(
              LocaleKeys.dialogs_signInRequiredTitle.tr(
                namedArgs: {'action': action},
              ),
              style: V2Typography.display(
                fontSize: 28,
                color: ColorsCustom.white,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              LocaleKeys.dialogs_signInRequiredBody.tr(),
              style: TextStyle(
                fontSize: 14,
                color: ColorsCustom.white.withValues(alpha: 0.7),
                height: 1.5,
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    // FirebaseAuth not yet wired — see docs/backend_plan.md
                    onPressed: null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorsCustom.coral,
                      foregroundColor: ColorsCustom.white,
                      disabledBackgroundColor: ColorsCustom.coral.withValues(
                        alpha: 0.3,
                      ),
                      disabledForegroundColor: ColorsCustom.white.withValues(
                        alpha: 0.6,
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      '${LocaleKeys.dialogs_signInRequiredAction.tr()} · ${LocaleKeys.auth_comingSoon.tr()}',
                      style: const TextStyle(fontWeight: FontWeight.w800),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: ColorsCustom.white,
                      side: BorderSide(
                        color: ColorsCustom.white.withValues(alpha: 0.3),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      LocaleKeys.dialogs_signInRequiredCancel.tr(),
                      style: const TextStyle(fontWeight: FontWeight.w700),
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
