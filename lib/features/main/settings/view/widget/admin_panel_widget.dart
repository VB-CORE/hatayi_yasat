part of '../settings_view.dart';

@immutable
final class _AdminPanelWidget extends ConsumerWidget {
  const _AdminPanelWidget();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authViewModelProvider);
    final isAdmin =
        authState is Authenticated && authState.user.role == UserRole.admin;
    // TODO(admin): Gerçek admin auth (#344) gelince debug fallback kaldırılacak.
    if (!isAdmin && !kDebugMode) return const EmptyBox();
    return Card(
      elevation: kZero,
      shape: const RoundedRectangleBorder(
        borderRadius: CustomRadius.large,
      ),
      child: ListTile(
        title: Text(
          LocaleKeys.admin_title.tr(),
          style: context.general.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w800,
          ),
        ),
        leading: Icon(
          AppIcons.adminPanel,
          size: WidgetSizes.spacingXxl4,
          color: context.general.colorScheme.onSecondaryFixed,
        ),
        onTap: () => const AdminPanelRoute().push<AdminPanelRoute>(context),
      ),
    );
  }
}
