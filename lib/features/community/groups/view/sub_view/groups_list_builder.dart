part of '../groups_view.dart';

final class _GroupsListBuilder extends ConsumerWidget {
  const _GroupsListBuilder();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(groupsViewModelProvider);
    return switch (state) {
      GroupsState(isFetching: true) => const SizedBox.shrink(),
      GroupsState(isError: true) => SingleChildScrollView(
        child: GeneralNotFoundWidget(
          title: LocaleKeys.message_somethingWentWrong.tr(),
          onRefresh: () {
            unawaited(
              ref.read(groupsViewModelProvider.notifier).fetchGroups(),
            );
          },
        ),
      ),
      GroupsState(groups: []) => SingleChildScrollView(
        child: GeneralNotFoundWidget(
          title: LocaleKeys.community_groups_empty.tr(),
        ),
      ),
      GroupsState(:final groups) => ListView.builder(
        itemCount: groups.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const PagePadding.vertical6Symmetric(),
            child: GroupCard(
              model: groups[index],
              onTap: () =>
                  GroupDetailRoute($extra: groups[index]).push<void>(context),
            ),
          );
        },
      ),
    };
  }
}
