import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/theme/app_context_colors.dart';
import 'package:lifeclient/features/auth/view_model/auth_state.dart';
import 'package:lifeclient/features/auth/view_model/auth_view_model.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/utility/decorations/empty_box.dart';
import 'package:lifeclient/product/widget/general/index.dart';

/// Shown instead of the app while the account is banned. The account is
/// already disabled server side; this exists so the user is told why rather
/// than being dropped at the login screen without explanation.
@immutable
final class BannedView extends ConsumerWidget {
  const BannedView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = context.general.colorScheme;
    final state = ref.watch(authViewModelProvider);
    final reason = state is AuthBanned ? state.reason : null;

    return Scaffold(
      backgroundColor: context.appColors.navy700,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const PagePadding.all(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.gavel_outlined,
                  size: 64,
                  color: colorScheme.error,
                ),
                const EmptyBox.largeHeight(),
                Text(
                  LocaleKeys.banned_title.tr(),
                  textAlign: TextAlign.center,
                  style: context.general.textTheme.headlineMedium?.copyWith(
                    color: colorScheme.onTertiary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const EmptyBox.middleHeight(),
                GeneralContentSubTitle(
                  value: LocaleKeys.banned_description.tr(),
                  textAlign: TextAlign.center,
                  color: colorScheme.onTertiary.withValues(alpha: 0.7),
                ),
                if (reason != null && reason.isNotEmpty) ...[
                  const EmptyBox.middleHeight(),
                  _ReasonBox(reason: reason),
                ],
                const EmptyBox.largeXHeight(),
                TextButton(
                  onPressed: ref.read(authViewModelProvider.notifier).signOut,
                  child: Text(
                    LocaleKeys.banned_signOut.tr(),
                    style: TextStyle(color: colorScheme.onTertiary),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

final class _ReasonBox extends StatelessWidget {
  const _ReasonBox({required this.reason});

  final String reason;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.general.colorScheme;
    return Container(
      width: double.infinity,
      padding: const PagePadding.all(),
      decoration: BoxDecoration(
        color: colorScheme.error.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(WidgetSizes.spacingM),
      ),
      child: Text(
        reason,
        textAlign: TextAlign.center,
        style: context.general.textTheme.bodyMedium?.copyWith(
          color: colorScheme.onTertiary,
        ),
      ),
    );
  }
}
