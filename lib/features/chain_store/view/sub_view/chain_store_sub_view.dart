part of '../chain_store_view.dart';

final class _ChainStoreListWidget extends ConsumerWidget {
  const _ChainStoreListWidget({
    required this.onLocationTap,
    required this.onCallTap,
  });
  final AsyncValueGetterWithContext<GeoPoint> onLocationTap;
  final AsyncValueGetterWithContext<String> onCallTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final query = ref
        .read(chainStoreProviderProvider.notifier)
        .fetchChainStoreCollectionReference();

    return GeneralFirestoreListView<ChainStoreModel>(
      query: query,
      onRetry: () {},
      emptyBuilder: (context) => GeneralNotFoundWidget(
        title: LocaleKeys.notFound_chainStore.tr(),
      ),
      itemBuilder: (context, model) {
        final branches = model.branches;
        final safeBranches = branches.ext.makeSafe();

        return _SubItemBranch(safeBranches: safeBranches, model: model);
      },
    );
  }
}

class _SubItemBranch extends StatelessWidget {
  const _SubItemBranch({
    required this.safeBranches,
    required this.model,
  });

  final List<StoreModel> safeBranches;
  final ChainStoreModel model;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        ChainSubSheet.show(
          context: context,
          storeList: safeBranches,
          chainName: model.name,
        );
      },
      shape: UnderlineInputBorder(
        borderSide: BorderSide(
          color: context.general.colorScheme.primary.withValues(alpha: 0.4),
        ),
      ),
      leading: SizedBox.square(
        dimension: WidgetSizes.spacingXxl4,
        child: ClipOval(
          child: CustomNetworkImage(
            imageUrl: model.logoImageUrl,
            fit: BoxFit.cover,
          ),
        ),
      ),
      trailing: const Icon(AppIcons.rightArrow),
      title: GeneralBodyTitle(
        model.name,
        fontWeight: FontWeight.bold,
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GeneralContentSmallTitle(
            value: model.description,
          ),
          Padding(
            padding: const PagePadding.onlyTopLow(),
            child: GeneralContentSmallTitle(
              value: LocaleKeys.chain_stores_showAllSubBranches.tr(
                args: [safeBranches.length.toString()],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
