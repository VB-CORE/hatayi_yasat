part of '../merchant_showcase_sub_view.dart';

final class _MerchantShowcaseEditor extends StatelessWidget {
  const _MerchantShowcaseEditor({
    required this.modules,
    required this.isSaving,
    required this.onReorder,
    required this.onEdit,
    required this.onDelete,
    required this.onToggleActive,
  });

  final List<MerchantShowcaseModuleModel> modules;
  final bool isSaving;
  final void Function(int oldIndex, int newIndex) onReorder;
  final ValueChanged<MerchantShowcaseModuleModel> onEdit;
  final ValueChanged<MerchantShowcaseModuleModel> onDelete;
  final ValueChanged<MerchantShowcaseModuleModel> onToggleActive;

  @override
  Widget build(BuildContext context) {
    if (modules.isEmpty) {
      return GeneralNotFoundWidget(
        title: LocaleKeys.merchantPanel_showcase_empty.tr(),
      );
    }

    return ReorderableListView.builder(
      padding: const PagePadding.generalAllLow(),
      itemCount: modules.length,
      onReorderItem: onReorder,
      buildDefaultDragHandles: false,
      itemBuilder: (context, index) {
        final module = modules[index];
        return _MerchantShowcaseModuleTile(
          key: ValueKey(module.id),
          index: index,
          module: module,
          isSaving: isSaving,
          onEdit: () => onEdit(module),
          onDelete: () => onDelete(module),
          onToggleActive: () => onToggleActive(module),
        );
      },
    );
  }
}

final class _MerchantShowcasePreview extends StatelessWidget {
  const _MerchantShowcasePreview({required this.modules});

  final List<MerchantShowcaseModuleModel> modules;

  @override
  Widget build(BuildContext context) {
    if (modules.isEmpty) {
      return GeneralNotFoundWidget(
        title: LocaleKeys.merchantPanel_showcase_previewEmpty.tr(),
      );
    }

    return ListView.builder(
      padding: const PagePadding.generalAllLow(),
      itemCount: modules.length,
      itemBuilder: (context, index) =>
          MerchantShowcaseCard(module: modules[index]),
    );
  }
}
