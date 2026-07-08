part of '../home_view.dart';

/// It will help to navigate filter screen and get result from filter screen
mixin _FilterMixin {
  Future<void> pushToFilter({
    required BuildContext context,
    String? category,
  }) async {
    FilterRoute($extra: category).go(context);
  }
}

final class _HomeCategoryCards extends ConsumerWidget {
  const _HomeCategoryCards();
  static const _maxCategoryItemLength = 6;
  static const _otherCategoryValue = 1000;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.watch(homeViewModelProvider);
    final selected = vm.categoryValues;
    final categories =
        vm.categories.where((e) => e.value != _otherCategoryValue).toList()
          ..sort((a, b) => a.displayName.length.compareTo(b.displayName.length));
    final visible = categories.take(_maxCategoryItemLength).toList();
    final total = CategoryCountMock.total(visible.map((e) => e.value));

    return SingleChildScrollView(
      key: const Key('homeCategoriesList'),
      scrollDirection: Axis.horizontal,
      child: Row(
        spacing: AppSpacing.xs,
        children: [
          _CategoryCard(
            key: const Key('categoryCard_all'),
            name: LocaleKeys.home_allCategory.tr(),
            count: total,
            icon: CategoryVisual.allIcon,
            accent: AppColors.coral,
            isActive: selected.isEmpty,
            onTap: () => ref
                .read(homeViewModelProvider.notifier)
                .selectSingleCategory(null),
          ),
          for (final category in visible)
            _CategoryCard(
              key: Key('categoryCard_${category.value}'),
              name: category.displayName,
              count: CategoryCountMock.forValue(category.value),
              icon: CategoryVisual.iconFor(category),
              accent: CategoryVisual.accentFor(category),
              isActive: selected.contains(category.value),
              onTap: () => ref
                  .read(homeViewModelProvider.notifier)
                  .selectSingleCategory(category.value),
            ),
        ],
      ),
    ).ext.sliver;
  }
}

final class _CategoryCard extends StatelessWidget {
  const _CategoryCard({
    required this.name,
    required this.count,
    required this.icon,
    required this.accent,
    required this.isActive,
    required this.onTap,
    super.key,
  });

  final String name;
  final int count;
  final IconData icon;
  final Color accent;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final foreground = isActive ? AppColors.white : AppColors.ink700;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: isActive ? AppColors.coral : AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.pill),
        border: Border.all(
          color: isActive ? AppColors.coral : AppColors.ink100,
          width: isActive ? 1.5 : 1,
        ),
        boxShadow: isActive ? AppShadows.card : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(AppRadius.pill),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.xs,
              vertical: 6,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _CategoryIconBadge(
                  icon: icon,
                  isActive: isActive,
                  accent: accent,
                ),
                const SizedBox(width: AppSpacing.xs),
                Text(
                  name,
                  style: AppText.body.copyWith(
                    color: foreground,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(width: AppSpacing.xxs),
                Text(
                  '$count',
                  style: AppText.caption.copyWith(
                    color: isActive ? AppColors.white : AppColors.ink400,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

final class _CategoryIconBadge extends StatelessWidget {
  const _CategoryIconBadge({
    required this.icon,
    required this.isActive,
    required this.accent,
  });

  final IconData icon;
  final bool isActive;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 22,
      height: 22,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isActive
            ? AppColors.white.withValues(alpha: 0.22)
            : AppColors.ink25,
        shape: BoxShape.circle,
      ),
      child: Icon(
        icon,
        size: 13,
        color: isActive ? AppColors.white : accent,
      ),
    );
  }
}
