part of '../groups_view.dart';

final class _PermissionBanner extends ConsumerWidget {
  const _PermissionBanner();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final canCreateGroup = ref.watch(
      authViewModelProvider.select(
        (state) => state.user?.canCreateGroup ?? false,
      ),
    );
    if (canCreateGroup) return const SizedBox.shrink();

    return Column(
      children: [
        GeneralInfoBanner(
          message: LocaleKeys.community_groups_noPermissionInfo.tr(),
        ),
        const EmptyBox.middleHeight(),
      ],
    );
  }
}
