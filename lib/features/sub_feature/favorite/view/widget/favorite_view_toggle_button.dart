part of '../favorite_view.dart';

final class _FavoriteViewToggleButton extends ConsumerWidget {
  const _FavoriteViewToggleButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isGridView = ref.watch(
      favoriteViewModelProvider.select((state) => state.isGridView),
    );
    final notifier = ref.read(favoriteViewModelProvider.notifier);

    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.appColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.sm),
        border: Border.all(color: context.general.colorScheme.outline),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _FavoriteViewSegment(
            icon: AppIcons.list,
            isSelected: !isGridView,
            onTap: () => notifier.setGridView(isGridView: false),
          ),
          _FavoriteViewSegment(
            icon: AppIcons.gridView,
            isSelected: isGridView,
            onTap: () => notifier.setGridView(isGridView: true),
          ),
        ],
      ),
    );
  }
}

final class _FavoriteViewSegment extends StatelessWidget {
  const _FavoriteViewSegment({
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(AppRadius.sm),
        onTap: onTap,
        child: SizedBox(
          width: AppIconSizes.largeX,
          height: AppIconSizes.largeX,
          child: Padding(
            padding: EdgeInsets.all(
              isSelected ? AppConstants.kThree.toDouble() : 0,
            ),
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: isSelected
                    ? context.general.colorScheme.primary
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(AppRadius.sm),
              ),
              child: Center(
                child: Icon(
                  icon,
                  size: IconSize.smallX.value,
                  color: isSelected
                      ? context.general.colorScheme.onPrimary
                      : context.general.colorScheme.primary,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
