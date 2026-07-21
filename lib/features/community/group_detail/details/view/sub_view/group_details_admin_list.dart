part of '../group_details_view.dart';

final class _AdminList extends StatelessWidget {
  const _AdminList({required this.admins});

  final List<GroupMemberModel> admins;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (final (index, admin) in admins.indexed) ...[
          if (index > 0) const EmptyBox.middleHeight(),
          GroupAdminTile(model: admin),
        ],
      ],
    );
  }
}
