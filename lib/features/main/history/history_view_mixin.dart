import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:lifeclient/core/dependency/project_dependency_mixin.dart';
import 'package:lifeclient/features/main/history/history_view.dart';
import 'package:lifeclient/features/main/history/widget/history_info_dialog.dart';
import 'package:lifeclient/product/feature/cache/shared_operation/shared_cache.dart';
import 'package:lifeclient/product/model/constant/project_general_constant.dart';
import 'package:url_launcher/url_launcher_string.dart';

mixin HistoryViewMixin on ConsumerState<HistoryView>, ProjectDependencyMixin {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkFirstVisit();
    });
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
      builder: (context) => const HistoryInfoDialog(),
    );
  }

  Future<void> openGoogleForm() async {
    const googleFormUrl = ProjectGeneralConstant.googleFormMemoryUrl;
    await googleFormUrl.ext.launchWebsiteCustom(
      mode: LaunchMode.externalApplication,
    );
  }
}
