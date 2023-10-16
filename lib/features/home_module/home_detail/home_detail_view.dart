import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:screenshot/screenshot.dart';
import 'package:vbaseproject/features/home_module/home_detail/mixin/home_detail_mixin.dart';
import 'package:vbaseproject/product/init/language/locale_keys.g.dart';
import 'package:vbaseproject/product/package/custom_network_image.dart';
import 'package:vbaseproject/product/utility/mixin/redirection_mixin.dart';
import 'package:vbaseproject/product/utility/state/product_provider.dart';
import 'package:vbaseproject/product/widget/dialog/phone_zoom_dialog.dart';
import 'package:vbaseproject/product/widget/size/index.dart';
import 'package:vbaseproject/product/widget/sliver/home_appbar_sliver.dart';

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
                  return HomeAppBarSliver.fromStore(
                    model: widget.model,
                    isPinned: value,
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
