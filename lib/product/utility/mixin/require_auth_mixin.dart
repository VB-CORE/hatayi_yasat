import 'package:flutter/material.dart';
import 'package:lifeclient/product/widget/sheet/v2_sign_in_required_sheet.dart';

/// Auth gate helper used by guarded actions (compose, like, save, review).
///
/// FirebaseAuth is not yet wired (see `docs/backend_plan.md`); until then
/// every call passes through and the action runs as the `'guest'` user
/// stamped by [_auth_session.dart]. The helper is in place so when auth
/// ships, only the body of [requireAuth] needs to flip — every call site
/// stays untouched.
Future<void> requireAuth(
  BuildContext context, {
  required String actionLabel,
  required Future<void> Function() onAuthorized,
}) async {
  // ignore: dead_code, the gate flips on once FirebaseAuth lands
  const isGuestModeAllowed = true;
  if (isGuestModeAllowed) {
    await onAuthorized();
    return;
  }
  // Auth-required path (kept here so the sheet stays wired):
  // ignore: dead_code
  await showV2SignInRequiredSheet(context, action: actionLabel);
}
