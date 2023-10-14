import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:screenshot/screenshot.dart';
import 'package:vbaseproject/features/home_module/home_detail/mixin/home_detail_mixin.dart';
import 'package:vbaseproject/features/home_module/home_detail/models/favorite_place_model.dart';
import 'package:vbaseproject/product/feature/cache/shared_cache.dart';
import 'package:vbaseproject/product/init/language/locale_keys.g.dart';
import 'package:vbaseproject/product/utility/mixin/redirection_mixin.dart';
import 'package:vbaseproject/product/utility/package/custom_network_image.dart';
import 'package:vbaseproject/product/utility/padding/page_padding.dart';
import 'package:vbaseproject/product/utility/size/index.dart';
import 'package:vbaseproject/product/utility/state/product_provider.dart';
import 'package:vbaseproject/product/widget/dialog/phone_zoom_dialog.dart';

class HomeDetailView extends StatefulWidget {
  const HomeDetailView({required this.model, super.key});
  final StoreModel model;

  @override
  State<HomeDetailView> createState() => _HomeDetailViewState();
}

class _HomeDetailViewState extends State<HomeDetailView> with HomeDetailMixin {
  @override
  Widget build(BuildContext context) {
    return Screenshot(
      controller: imageCompressAndWaterMark.screenshotController,
      child: Scaffold(
        floatingActionButton: _ShareButton(
          notifier: screenshotNotifier,
          onPressed: captureAndShare,
        ),
        body: NotificationListener(
          onNotification: listenNotification,
          child: CustomScrollView(
            slivers: [
              ValueListenableBuilder<bool>(
                valueListenable: isPinnedNotifier,
                builder: (context, value, child) {
                  return _SliverAppBar(
                    isPinned: value,
                    model: model,
                  );
                },
              ),
              _SliverDetail(model: model),
            ],
          ),
        ),
      ),
    );
  }
}

class _ShareButton extends StatelessWidget {
  const _ShareButton({required this.notifier, required this.onPressed});
  final ValueListenable<bool> notifier;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: notifier,
      builder: (_, isLoading, __) => FloatingActionButton(
        onPressed: onPressed,
        child: isLoading
            ? const CircularProgressIndicator.adaptive()
            : const Icon(Icons.share_outlined),
      ),
    );
  }
}

class _SliverDetail extends StatelessWidget {
  const _SliverDetail({
    required this.model,
  });

  final StoreModel model;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate([
        ListTile(
          title: const Text(LocaleKeys.placeDetailView_owner).tr(),
          subtitle: Text(model.owner),
        ),
        if (model.description.ext.isNotNullOrNoEmpty)
          ListTile(
            titleTextStyle: context.general.textTheme.titleMedium,
            title: const Text(LocaleKeys.placeDetailView_description).tr(),
            subtitle: Text(model.description ?? ''),
          ),
        ListTile(
          title: const Text(LocaleKeys.placeDetailView_address).tr(),
          subtitle: Text(model.address ?? '-'),
          trailing: const Icon(Icons.location_on_outlined),
          onTap: () async {
            final address = model.address;
            if (address.ext.isNullOrEmpty) return;
            await RedirectionMixin.navigateToMapsWithTitle(
              context: context,
              placeAddress: address!,
            );
          },
        ),
        ListTile(
          trailing: const Icon(Icons.call_outlined),
          title: const Text(LocaleKeys.placeDetailView_phoneNumber).tr(),
          subtitle: Text(model.phone),
          onTap: () {
            RedirectionMixin.openToPhone(
              context: context,
              phoneNumber: model.phone,
            );
          },
        ),
        _DistrictListTile(model: model),
        ListTile(
          title: const Text(LocaleKeys.placeDetailView_photos).tr(),
          subtitle: SizedBox(
            height: context.sized.dynamicHeight(.2),
            child: ListView.separated(
              separatorBuilder: (context, index) {
                return const SizedBox(width: WidgetSizes.spacingS);
              },
              padding: EdgeInsets.zero,
              scrollDirection: Axis.horizontal,
              itemCount: model.images.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    PhoneZoomDialog(imageUrl: model.images[index])
                        .show(context);
                  },
                  child: CustomNetworkImage(
                    imageUrl: model.images[index],
                  ),
                );
              },
            ),
          ),
        ),
      ]),
    );
  }
}

class _DistrictListTile extends ConsumerWidget {
  const _DistrictListTile({
    required this.model,
  });

  final StoreModel model;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final town = ref
        .watch(ProductProvider.provider.notifier)
        .fetchTownFromCode(model.townCode);
    return ListTile(
      title: const Text(LocaleKeys.placeDetailView_district).tr(),
      subtitle: Text(town),
    );
  }
}

class _SliverAppBar extends StatefulWidget {
  const _SliverAppBar({
    required this.isPinned,
    required this.model,
  });

  final bool isPinned;
  final StoreModel model;

  @override
  State<_SliverAppBar> createState() => _SliverAppBarState();
}

class _SliverAppBarState extends State<_SliverAppBar> {
  //Default value is false for now. It'll depend on the cached value after development
  late final ValueNotifier<bool> favoriteNotifier;

  @override
  void initState() {
    super.initState();
    favoriteNotifier = ValueNotifier<bool>(
      SharedCache.instance.isFavoritePlace(widget.model.name),
    );
  }

  Future<void> _toggleFavorite() async {
    favoriteNotifier.value = !favoriteNotifier.value;

    //remove or add place to favorites with condition
    final isSuccess = await (favoriteNotifier.value
        ? _addFavoritePlace()
        : _removeFavoritePlace());

    //if any error happen when caching operation then change value again
    if (!isSuccess) {
      favoriteNotifier.value = !favoriteNotifier.value;
    }
  }

  Future<bool> _addFavoritePlace() async {
    return SharedCache.instance
        .setFavoritePlace(FavoritePlaceModel(name: widget.model.name));
  }

  Future<bool> _removeFavoritePlace() async {
    return SharedCache.instance
        .removeFromFavorites(FavoritePlaceModel(name: widget.model.name));
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: WidgetSizes.spacingXxlL13,
      pinned: true,
      actions: [
        ValueListenableBuilder<bool>(
          valueListenable: favoriteNotifier,
          builder: (context, value, child) {
            return IconButton(
              onPressed: _toggleFavorite,
              icon: Icon(
                value ? Icons.favorite : Icons.favorite_border_outlined,
                color: context.general.colorScheme.primary,
              ),
            );
          },
        ),
      ],
      leading: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor:
              context.general.colorScheme.background.withOpacity(0.5),
          shape: const CircleBorder(),
          padding: EdgeInsets.zero,
        ),
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: Icon(
          Icons.arrow_back,
          color: context.general.colorScheme.background,
        ),
      ),
      actionsIconTheme: IconThemeData(
        color: context.general.colorScheme.onSurface,
      ),
      flexibleSpace: FlexibleSpaceBar(
        title: Container(
          color: widget.isPinned ? null : Colors.black.withOpacity(0.5),
          width: widget.isPinned ? null : context.sized.width,
          child: Padding(
            padding: const PagePadding.onlyLeft(),
            child: Text(
              widget.model.name,
              style: context.general.textTheme.titleLarge?.copyWith(
                color: widget.isPinned
                    ? context.general.colorScheme.onSurface
                    : context.general.colorScheme.onSecondary,
              ),
            ),
          ),
        ),
        titlePadding: widget.isPinned ? null : EdgeInsets.zero,
        centerTitle: false,
        background: Hero(
          tag: ValueKey(widget.model.documentId),
          child: CustomNetworkImage(
            imageUrl: widget.model.images.firstOrNull,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

class BlurredBackdropImage extends StatelessWidget {
  const BlurredBackdropImage({
    required this.path,
    super.key,
  });

  final String path;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
            path,
          ),
          fit: BoxFit.cover,
        ),
      ),
      height: MediaQuery.of(context).size.height / 1.5,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0),
          ),
        ),
      ),
    );
  }
}
