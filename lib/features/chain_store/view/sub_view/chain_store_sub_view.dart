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
        return GeneralExpansionImageTile(
          pageTitle: model.name,
          subTitle: model.description,
          imageUrl: model.logoImageUrl,
          children: List.generate(
            safeBranches.length,
            (index) => _ChainStoreBranchWidget(
              branch: safeBranches[index],
              onLocationTap: onLocationTap,
              onCallTap: onCallTap,
            ),
          ),
        );
      },
    );
  }
}

class _ChainStoreBranchWidget extends StatelessWidget {
  const _ChainStoreBranchWidget({
    required this.branch,
    required this.onLocationTap,
    required this.onCallTap,
  });
  final StoreModelSnapshot branch;
  final AsyncValueGetterWithContext<GeoPoint> onLocationTap;
  final AsyncValueGetterWithContext<String> onCallTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: _BranchNameText(branchName: branch.name),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const EmptyBox.xSmallHeight(),
          _BranchAddressText(branchAddress: branch.address),
        ],
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _LocationIconButton(onLocationTap: onLocationTap, branch: branch),
          _PhoneIconButton(onCallTap: onCallTap, branch: branch),
        ],
      ),
    );
  }
}

class _PhoneIconButton extends StatelessWidget {
  const _PhoneIconButton({
    required this.onCallTap,
    required this.branch,
  });

  final AsyncValueGetterWithContext<String> onCallTap;
  final StoreModelSnapshot branch;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(AppIcons.phone),
      onPressed: () => onCallTap(context, branch.phone),
    );
  }
}

class _LocationIconButton extends StatelessWidget {
  const _LocationIconButton({
    required this.onLocationTap,
    required this.branch,
  });

  final AsyncValueGetterWithContext<GeoPoint> onLocationTap;
  final StoreModelSnapshot branch;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(AppIcons.location),
      onPressed: () => onLocationTap(context, branch.latlong),
    );
  }
}

class _BranchAddressText extends StatelessWidget {
  const _BranchAddressText({
    required this.branchAddress,
  });

  final String branchAddress;

  @override
  Widget build(BuildContext context) {
    return Text(
      branchAddress,
      style: context.general.textTheme.bodySmall,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }
}

class _BranchPhoneText extends StatelessWidget {
  const _BranchPhoneText({
    required this.branchPhone,
  });

  final String branchPhone;

  @override
  Widget build(BuildContext context) {
    return Text(
      branchPhone,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}

class _BranchNameText extends StatelessWidget {
  const _BranchNameText({
    required this.branchName,
  });

  final String branchName;

  @override
  Widget build(BuildContext context) {
    return Text(
      branchName,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }
}
