import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:lifeclient/features/sub_feature/whats_new/whats_new_chain.dart';
import 'package:lifeclient/product/feature/cache/shared_cache.dart';

final class WhatsNewSheetManager {
  WhatsNewSheetManager({required this.context});

  final BuildContext context;

  late final FirstTimeWhatsNewChain _firstTimeWhatsNewChain =
      FirstTimeWhatsNewChain(context, _controlVersionWhatsNewChain);

  late final ControlVersionWhatsNewChain _controlVersionWhatsNewChain =
      ControlVersionWhatsNewChain(context, _endOfChainWhatsNewChain);

  late final EndWhatsNewChain _endOfChainWhatsNewChain =
      EndWhatsNewChain(context);

  Future<void> show() async {
    final getSavedVersion = SharedCache.instance.version;
    final getApplicationVersionNumber =
        double.parse(''.ext.version.split('.').join());

    await _firstTimeWhatsNewChain.show(
      currentAppVersion: getApplicationVersionNumber.toInt(),
      savedAppVersion: getSavedVersion,
    );

    // if (applicationVersionValue.isEmpty) return;
    // final getApplicationVersionNumber =
    //     double.parse(''.ext.version.split('.').join());

    // //// it's not needs to show change log when application first install
    // if (getSavedVersion == kErrorNumber) {
    //   await _saveCurrentVersion(getApplicationVersionNumber.toInt());
    //   return;
    // }

    // if (getApplicationVersionNumber == kErrorNumber) return;
    // if (getSavedVersion >= getApplicationVersionNumber) return;
    // await _saveCurrentVersion(getApplicationVersionNumber.toInt());
    // await showModalBottomSheet<void>(
    //   context: context,
    //   builder: (context) => const WhatsNewSheet(),
    // );
  }

  // Future<void> _saveCurrentVersion(int version) async {
  //   await SharedCache.instance.saveCurrentVersion(version);
  // }
}
