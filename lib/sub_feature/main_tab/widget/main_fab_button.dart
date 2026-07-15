part of '../main_tab_view.dart';

final class _SpeedDialFabWidget extends ConsumerWidget {
  const _SpeedDialFabWidget();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = SpeedDialChildModelList(context: context).speedDialChildItems;
    final isAuthenticated = ref.watch(authViewModelProvider) is Authenticated;
    return CustomSpeedDial(
      children: items
          .map(
            (e) => CustomSpeedDialRouteChild(
              context: context,
              location: e.location,
              label: e.title,
              onTap: e.requiresAuth
                  ? () => unawaited(
                      _onMerchantApplicationTapped(
                        context,
                        ref,
                        isAuthenticated: isAuthenticated,
                      ),
                    )
                  : null,
            ),
          )
          .toList(),
    );
  }

  Future<void> _onMerchantApplicationTapped(
    BuildContext context,
    WidgetRef ref, {
    required bool isAuthenticated,
  }) async {
    if (!isAuthenticated) return _showLoginRequiredDialog(context);
    final hasApplication = await ref
        .read(merchantApplicationServiceProvider)
        .hasActiveApplication();
    if (!context.mounted) return;
    if (hasApplication) {
      const MerchantApplicationStatusRoute().push<void>(context);
      return;
    }
    const MerchantApplicationViewRoute().push<void>(context);
  }

  Future<void> _showLoginRequiredDialog(BuildContext context) async {
    final goLogin = await GeneralTextDialog.show<bool>(
      context,
      LocaleKeys.merchantApplication_loginRequiredTitle.tr(),
      LocaleKeys.merchantApplication_loginRequiredContent.tr(),
      [
        GeneralDialogButton(
          title: LocaleKeys.button_cancel,
          onPressed: () => Navigator.pop(context, false),
        ),
        GeneralDialogButton(
          title: LocaleKeys.button_login,
          onPressed: () => Navigator.pop(context, true),
        ),
      ],
      backgroundColor: AppColors.bg,
    );
    if ((goLogin ?? false) && context.mounted) {
      const LoginRoute().go(context);
    }
  }
}
