part of '../merchant_showcase_sub_view.dart';

final class _MerchantShowcaseModuleTile extends StatelessWidget {
  const _MerchantShowcaseModuleTile({
    required this.index,
    required this.module,
    required this.isSaving,
    required this.onEdit,
    required this.onDelete,
    required this.onToggleActive,
    super.key,
  });

  final int index;
  final MerchantShowcaseModuleModel module;
  final bool isSaving;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onToggleActive;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const PagePadding.verticalLowSymmetric(),
      child: Container(
        padding: const PagePadding.allLow(),
        decoration: BoxDecoration(
          color: context.appColors.surface,
          borderRadius: BorderRadius.circular(AppRadius.md),
          border: Border.all(
            color: module.isPublished
                ? context.appColors.ink200
                : context.appColors.ink100,
          ),
        ),
        child: Row(
          spacing: AppSpacing.xs,
          children: [
            ReorderableDragStartListener(
              index: index,
              child: Icon(
                AppIcons.dragHandle,
                size: AppIconSizes.medium,
                color: context.appColors.ink300,
              ),
            ),
            Container(
              padding: const PagePadding.allLow(),
              decoration: BoxDecoration(
                color: module.type.backgroundColor,
                borderRadius: BorderRadius.circular(AppRadius.sm),
              ),
              child: Icon(
                module.type.icon,
                size: AppIconSizes.medium,
                color: module.type.color,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    module.title,
                    maxLines: AppConstants.kOne,
                    overflow: TextOverflow.ellipsis,
                    style: AppText.bodyLg,
                  ),
                  Text(
                    module.isPublished
                        ? module.type.label.tr()
                        : LocaleKeys.merchantPanel_showcase_passive.tr(),
                    style: AppText.caption,
                  ),
                ],
              ),
            ),
            Switch.adaptive(
              value: module.isActive,
              onChanged: isSaving ? null : (_) => onToggleActive(),
            ),
            IconButton(
              onPressed: isSaving ? null : onEdit,
              icon: const Icon(AppIcons.edit, size: AppIconSizes.medium),
            ),
            IconButton(
              onPressed: isSaving ? null : onDelete,
              color: context.appColors.coral,
              icon: const Icon(AppIcons.delete, size: AppIconSizes.medium),
            ),
          ],
        ),
      ),
    );
  }
}
