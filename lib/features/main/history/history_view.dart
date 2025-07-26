import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/features/main/history/provider/history_view_model.dart';
import 'package:lifeclient/product/feature/cache/shared_operation/shared_cache.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/package/image/custom_network_image.dart';
import 'package:lifeclient/product/utility/constants/app_icon_sizes.dart';
import 'package:lifeclient/product/utility/constants/app_icons.dart';
import 'package:lifeclient/product/utility/decorations/colors_custom.dart';
import 'package:lifeclient/product/utility/decorations/custom_radius.dart';
import 'package:lifeclient/product/widget/general/index.dart';

part 'widget/history_grid_builder.dart';
part 'widget/history_info_dialog.dart';
part 'widget/photo_detail_sheet.dart';

final class HistoryView extends ConsumerStatefulWidget {
  const HistoryView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HistoryViewState();
}

class _HistoryViewState extends ConsumerState<HistoryView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkFirstVisit();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GeneralScaffold(
      body: const _HistoryGridBuilder(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(
          bottom: AppIconSizes.xLarge * 2.5,
        ),
        child: FloatingActionButton(
          // backgroundColor: ColorsCustom.brandeisBlue,
          onPressed: _openGoogleForm,
          child: const Icon(Icons.add_a_photo_outlined),
        ),
      ),
    );
  }

  Future<void> _checkFirstVisit() async {
    if (SharedCache.instance.isFirstHistoryPageVisit) {
      await _showInfoDialog();
      await SharedCache.instance.setFirstHistoryPageVisit();
    }
  }

  Future<void> _showInfoDialog() async {
    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (context) => const _HistoryInfoDialog(),
    );
  }

  Future<void> _openGoogleForm() async {
    const googleFormUrl =
        'https://forms.google.com/your-form-url'; // TODO: Gerçek form URL'si eklenecek

    try {
      final launched = await googleFormUrl.ext.launchWebsite;
      if (!launched && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(LocaleKeys.button_error.tr()),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(LocaleKeys.button_error.tr()),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}
