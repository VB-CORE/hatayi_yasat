part of '../home_view.dart';

final class _HomeSortGridView extends StatelessWidget {
  const _HomeSortGridView();

  @override
  Widget build(BuildContext context) {
    return const Row(
      key: Key('homeSortGridView'),
      spacing: AppSpacing.xs,
      children: [_ViewDesignButton(), _SortPlaceButton()],
    );
  }
}

final class _BoxedButton extends StatelessWidget {
  const _BoxedButton({required this.onTap, required this.child});

  final VoidCallback onTap;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 38,
      height: 38,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.sm),
        border: Border.all(color: AppColors.ink100),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Center(child: child),
        ),
      ),
    );
  }
}

final class _ViewDesignButton extends ConsumerWidget {
  const _ViewDesignButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isGridView = ref.watch(homeViewModelProvider).isGridView;
    return _BoxedButton(
      onTap: () async {
        ref.read(homeViewModelProvider.notifier).changeHomeViewCardType();
      },
      child: Icon(
        isGridView ? Icons.view_list_rounded : Icons.grid_view_rounded,
        size: 20,
        color: AppColors.navy,
      ),
    );
  }
}

final class _SortPlaceButton extends ConsumerWidget {
  const _SortPlaceButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return _BoxedButton(
      onTap: () async {
        final currentType = ref.read(homeViewModelProvider).sortingType;
        final result = await PlaceSortSheet.show(context, current: currentType);
        if (result == null) return;
        await ref
            .read(homeViewModelProvider.notifier)
            .changeSortingType(result);
        if (!context.mounted) return;
        ScaffoldMessenger.of(context)
          ..clearSnackBars()
          ..showSnackBar(
            SnackBar(
              content: Text(LocaleKeys.sorting_applied.tr()),
              behavior: SnackBarBehavior.floating,
              duration: Durations.extralong4,
            ),
          );
      },
      child: Text(
        'A↑Z',
        style: AppText.label.copyWith(color: AppColors.navy),
      ),
    );
  }
}
