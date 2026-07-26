import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/widget/general/general_not_found_widget.dart';

enum FirestoreListState {
  loading,
  error,
  empty,
  data
  ;

  static FirestoreListState resolve<T>({
    required FirestoreQueryBuilderSnapshot<T?> snapshot,
    required List<T> items,
  }) {
    if (items.isNotEmpty) return FirestoreListState.data;
    if (snapshot.isFetching) return FirestoreListState.loading;
    if (snapshot.hasError) return FirestoreListState.error;
    return FirestoreListState.empty;
  }
}

final class FirestoreListLoading extends StatefulWidget {
  const FirestoreListLoading({
    this.height = CustomShimmerHeight.small,
    this.delay = Durations.medium2,
    super.key,
  });

  final double height;
  final Duration delay;

  @override
  State<FirestoreListLoading> createState() => _FirestoreListLoadingState();
}

final class _FirestoreListLoadingState extends State<FirestoreListLoading> {
  Timer? _timer;
  bool _isVisible = false;

  @override
  void initState() {
    super.initState();
    _timer = Timer(widget.delay, () {
      if (mounted) setState(() => _isVisible = true);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isVisible) return const SizedBox.shrink();
    return GeneralShimmer(height: widget.height);
  }
}

final class FirestoreListError extends StatelessWidget {
  const FirestoreListError({this.onRetry, super.key});

  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return GeneralNotFoundWidget(
      title: LocaleKeys.message_somethingWentWrong.tr(),
      onRefresh: onRetry,
    );
  }
}

final class FirestoreListEmpty extends StatelessWidget {
  const FirestoreListEmpty({this.title, super.key});

  final String? title;

  @override
  Widget build(BuildContext context) {
    return GeneralNotFoundWidget(
      title: title ?? LocaleKeys.message_emptyList.tr(),
    );
  }
}

final class FirestoreListFooter extends StatelessWidget {
  const FirestoreListFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: PagePadding.verticalLowSymmetric(),
      child: Center(child: CircularProgressIndicator.adaptive()),
    );
  }
}
