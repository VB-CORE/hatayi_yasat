part of '../group_details_view.dart';

final class _AdminList extends ConsumerWidget {
  const _AdminList({required this.groupId});

  final String groupId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FirestoreQueryBuilder<GroupMemberModel?>(
      query: ref.read(groupMembersViewModelProvider(groupId).notifier).admins,
      builder: (context, snapshot, _) {
        final admins = snapshot.docs
            .map((document) => document.data())
            .whereType<GroupMemberModel>()
            .toList(growable: false);

        return Column(
          children: [
            for (final (index, admin) in admins.indexed) ...[
              if (index > 0) const EmptyBox.middleHeight(),
              GroupAdminTile(model: admin),
            ],
          ],
        );
      },
    );
  }
}
