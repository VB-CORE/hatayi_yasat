import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lifeclient/product/init/application_theme.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/utility/decorations/colors_custom.dart';
import 'package:lifeclient/product/widget/brand/eyebrow.dart';

/// V2 logout confirmation. Returns `true` if the user confirmed.
Future<bool> showV2LogoutDialog(BuildContext context) async {
  final result = await showModalBottomSheet<bool>(
    context: context,
    backgroundColor: ColorsCustom.navy,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (_) => const _Body(),
  );
  return result ?? false;
}

class _Body extends StatelessWidget {
  const _Body();

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
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: ColorsCustom.white.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Icon(
                Icons.logout_rounded,
                color: ColorsCustom.coral300,
                size: 26,
              ),
            ),
            const SizedBox(height: 16),
            Eyebrow(
              LocaleKeys.profileV2_logout.tr(),
              color: ColorsCustom.coral300,
            ),
            const SizedBox(height: 6),
            Text(
              LocaleKeys.dialogs_logoutTitle.tr(),
              style: V2Typography.display(
                fontSize: 28,
                color: ColorsCustom.white,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              LocaleKeys.dialogs_logoutBody.tr(),
              style: TextStyle(
                fontSize: 14,
                color: ColorsCustom.white.withValues(alpha: 0.7),
                height: 1.5,
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: ColorsCustom.white.withValues(alpha: 0.06),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                LocaleKeys.profileV2_logoutSafeNotice.tr(),
                style: TextStyle(
                  fontSize: 12.5,
                  color: ColorsCustom.white.withValues(alpha: 0.85),
                  height: 1.5,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorsCustom.coral,
                      foregroundColor: ColorsCustom.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      LocaleKeys.dialogs_logoutConfirm.tr(),
                      style: const TextStyle(fontWeight: FontWeight.w800),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(false),
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
                      LocaleKeys.dialogs_logoutCancel.tr(),
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
