part of '../groups_view.dart';

final class _GroupsList extends ConsumerWidget {
  const _GroupsList({required this.onGroupTap});

  final ValueChanged<GroupModel> onGroupTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoryValue = ref.watch(
      groupsViewModelProvider.select((state) => state.selectedCategoryValue),
    );

    return CustomFirestoreListView<GroupModel>(
      query: ref
          .read(groupsViewModelProvider.notifier)
          .groupsQuery(categoryValue: categoryValue),
      padding: const PagePadding.horizontal16Symmetric(),
      separator: const EmptyBox.smallHeight(),
      onEmpty: FirestoreListEmpty(
        title: LocaleKeys.community_groups_empty.tr(),
      ),
      itemBuilder: (context, model) =>
          GroupCard(model: model, onTap: () => onGroupTap(model)),
    );
  }
}
