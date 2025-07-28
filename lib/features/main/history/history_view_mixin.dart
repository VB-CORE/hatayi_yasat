import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:lifeclient/core/dependency/project_dependency_mixin.dart';
import 'package:lifeclient/features/main/history/history_view.dart';
import 'package:lifeclient/features/main/history/widget/history_info_dialog.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';

mixin HistoryViewMixin on ConsumerState<HistoryView>, ProjectDependencyMixin {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkFirstVisit();
    });
  }

  Future<void> _checkFirstVisit() async {
    // if (SharedCache.instance.isFirstHistoryPageVisit) {
    //   await _showInfoDialog();
    //   await SharedCache.instance.setFirstHistoryPageVisit();
    // }
    await _showInfoDialog();
  }

  Future<void> _showInfoDialog() async {
    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (context) => const HistoryInfoDialog(),
    );
  }

  Future<void> openGoogleForm() async {
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
