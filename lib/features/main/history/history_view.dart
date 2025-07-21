import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/features/main/history/provider/history_view_model.dart';
import 'package:lifeclient/product/feature/cache/shared_operation/shared_cache.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/model/memory_model.dart';
import 'package:lifeclient/product/package/image/custom_network_image.dart';
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
      appBar: AppBar(
        title: const Text(
          'Hatıralar', // LocaleKeys.main_memories.tr(),
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: const _HistoryGridBuilder(),
      floatingActionButton: FloatingActionButton(
        onPressed: _openGoogleForm,
        child: const Icon(Icons.add_a_photo_outlined),
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
