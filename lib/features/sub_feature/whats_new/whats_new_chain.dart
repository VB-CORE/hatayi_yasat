import 'package:flutter/material.dart';
import 'package:lifeclient/features/sub_feature/whats_new/whats_new_sheet.dart';
import 'package:lifeclient/product/feature/cache/shared_operation/shared_cache.dart';
import 'package:lifeclient/product/utility/constants/app_constants.dart';

abstract interface class WhatsNewChain {
  WhatsNewChain(this.context, this.nextChain);

  final BuildContext context;
  final WhatsNewChain? nextChain;
  Future<void> show({
    required int currentAppVersion,
    required int savedAppVersion,
  });

  Future<void> saveCurrentVersion(int version) async {
    await SharedCache.instance.saveCurrentVersion(version);
  }
}

final class FirstTimeWhatsNewChain extends WhatsNewChain {
  FirstTimeWhatsNewChain(super.context, super.nextChain);

  @override
  Future<void> show({
    required int currentAppVersion,
    required int savedAppVersion,
  }) async {
    if (currentAppVersion == kErrorNumber) return;

    /// save first time current version number to cache
    if (savedAppVersion == kErrorNumber) {
      await saveCurrentVersion(currentAppVersion);
    }

    await nextChain?.show(
      currentAppVersion: currentAppVersion,
      savedAppVersion: savedAppVersion,
    );
    return;
  }
}

final class ControlVersionWhatsNewChain extends WhatsNewChain {
  ControlVersionWhatsNewChain(super.context, super.nextChain);

  @override
  Future<void> show({
    required int currentAppVersion,
    required int savedAppVersion,
  }) async {
    if (savedAppVersion == currentAppVersion) return;

    await nextChain?.show(
      currentAppVersion: currentAppVersion,
      savedAppVersion: savedAppVersion,
    );
  }
}

final class EndWhatsNewChain extends WhatsNewChain {
  EndWhatsNewChain(BuildContext context) : super(context, null);

  @override
  Future<void> show({
    required int currentAppVersion,
    required int savedAppVersion,
  }) async {
    await showModalBottomSheet<void>(
      context: context,
      builder: (context) => const WhatsNewSheet(),
    );
  }
}
