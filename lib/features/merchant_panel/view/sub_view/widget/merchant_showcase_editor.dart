part of '../merchant_showcase_sub_view.dart';

final class _MerchantShowcaseEditor extends StatelessWidget {
  const _MerchantShowcaseEditor({
    required this.storeId,
    required this.modules,
    required this.onReorderItem,
    required this.onEdit,
    required this.onDelete,
    required this.onToggleActive,
  });

  final String storeId;
  final List<MerchantShowcaseModuleModel> modules;
  final ReorderCallback onReorderItem;
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
      onReorderItem: onReorderItem,
      buildDefaultDragHandles: false,
      itemBuilder: (context, index) {
        final module = modules[index];
        return _MerchantShowcaseModuleTile(
          key: ValueKey(module.id),
          storeId: storeId,
          index: index,
          module: module,
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
