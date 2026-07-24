part of '../groups_view.dart';

final class _GroupsListBuilder extends StatelessWidget {
  const _GroupsListBuilder({
    required this.state,
    required this.onRetry,
    required this.onGroupTap,
  });

  final GroupsState state;
  final VoidCallback onRetry;
  final ValueChanged<GroupModel> onGroupTap;

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
          final model = groups[index];
          return Padding(
            padding: const PagePadding.vertical6Symmetric(),
            child: GroupCard(
              model: model,
              onTap: () => onGroupTap(model),
            ),
          );
        },
      ),
    };
  }
}
