part of '../groups_view.dart';

final class _GroupsListBuilder extends StatelessWidget {
  const _GroupsListBuilder({required this.state, required this.onRetry});

  final GroupsState state;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return switch (state) {
      GroupsState(isFetching: true) => const SizedBox.shrink(),
      GroupsState(isError: true) => SingleChildScrollView(
        child: GeneralNotFoundWidget(
          title: LocaleKeys.message_somethingWentWrong.tr(),
          onRefresh: onRetry,
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
