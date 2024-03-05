part of '../../general_select_sheet.dart';

final class _SelectSheetSubCard extends StatelessWidget {
  const _SelectSheetSubCard({
    required this.item,
    required this.onSelected,
    required this.isSelectedInitial,
  });

  final SelectSheetModel item;
  final ValueChanged<SelectSheetModel?> onSelected;
  final bool isSelectedInitial;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      leading: isSelectedInitial ? const Icon(AppIcons.check) : null,
      onTap: () {
        onSelected.call(item);
      },
      title: Text(item.title),
      trailing: const Icon(
        AppIcons.rightSelect,
      ),
    );
  }
}

class _FilterSheetHeader extends StatelessWidget {
  const _FilterSheetHeader();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Spacer(),
        TextButton(
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
          ),
          onPressed: () {
            context.route.pop();
          },
          child: const Icon(AppIcons.close),
        ),
      ],
    );
  }
}
