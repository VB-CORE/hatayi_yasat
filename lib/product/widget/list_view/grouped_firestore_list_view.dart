import 'dart:math' as math;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/product/widget/list_view/grouped_list_view.dart';

typedef GroupedFirestoreItemBuilder<T> =
    Widget Function(BuildContext context, T item);

enum _ViewState { loading, error, empty, data }

final class CustomGroupedFirestoreListView<T, K> extends StatelessWidget {
  const CustomGroupedFirestoreListView({
    required this.query,
    required this.groupBy,
    required this.groupHeaderBuilder,
    required this.itemBuilder,
    required this.onEmpty,
    this.groupCompare,
    this.onLoading,
    this.onError,
    this.filter,
    this.pageSize = 10,
    this.maxItem,
    this.loadMoreThreshold = 2,
    this.padding = EdgeInsets.zero,
    this.separator = const SizedBox.shrink(),
    this.footer = _defaultFooter,
    super.key,
  }) : assert(pageSize > 0, 'pageSize must be greater than 0'),
       assert(maxItem == null || maxItem > 0, 'maxItem must be greater than 0'),
       assert(loadMoreThreshold >= 0, 'loadMoreThreshold cannot be negative');

  final Query<T?> query;

  final K Function(T item) groupBy;
  final Widget Function(K key) groupHeaderBuilder;
  final int Function(K a, K b)? groupCompare;
  final GroupedFirestoreItemBuilder<T> itemBuilder;

  final Widget onEmpty;
  final Widget? onLoading;
  final Widget? onError;

  final bool Function(T item)? filter;
  final int pageSize;
  final int? maxItem;
  final int loadMoreThreshold;
  final EdgeInsetsGeometry padding;
  final Widget separator;
  final Widget footer;

  static const _defaultFooter = Padding(
    padding: PagePadding.verticalLowSymmetric(),
    child: Center(child: CircularProgressIndicator.adaptive()),
  );

  int get _effectivePageSize {
    final maximum = maxItem;
    if (maximum == null) return pageSize;
    return math.min(pageSize, maximum);
  }

  @override
  Widget build(BuildContext context) {
    return FirestoreQueryBuilder<T?>(
      query: query,
      pageSize: _effectivePageSize,
      builder: (context, snapshot, _) => _buildContent(snapshot),
    );
  }

  Widget _buildContent(FirestoreQueryBuilderSnapshot<T?> snapshot) {
    final items = _visibleItems(snapshot);

    return switch (_resolveState(snapshot, items)) {
      _ViewState.loading =>
        onLoading ?? const Center(child: CircularProgressIndicator.adaptive()),
      _ViewState.error =>
        onError ??
            ErrorWidget(
              snapshot.error ?? StateError('An unknown error occurred'),
            ),
      _ViewState.empty => _buildEmpty(snapshot, items),
      _ViewState.data => _buildList(snapshot, items),
    };
  }

  _ViewState _resolveState(
    FirestoreQueryBuilderSnapshot<T?> snapshot,
    List<T> items,
  ) {
    if (snapshot.isFetching && snapshot.docs.isEmpty) return _ViewState.loading;
    if (snapshot.hasError) return _ViewState.error;
    if (items.isEmpty) return _ViewState.empty;
    return _ViewState.data;
  }

  Widget _buildList(FirestoreQueryBuilderSnapshot<T?> snapshot, List<T> items) {
    final canLoadMore = _canLoadMore(snapshot, items);

    return GroupedListView<T, K>(
      items: items,
      groupBy: groupBy,
      groupHeaderBuilder: groupHeaderBuilder,
      groupCompare: groupCompare,
      itemBuilder: itemBuilder,
      padding: padding,
      separator: separator,
      canLoadMore: canLoadMore,
      loadMoreThreshold: loadMoreThreshold,
      onReachEnd: snapshot.fetchMore,
      footer: snapshot.isFetchingMore ? footer : null,
    );
  }

  Widget _buildEmpty(
    FirestoreQueryBuilderSnapshot<T?> snapshot,
    List<T> items,
  ) {
    if (_canLoadMore(snapshot, items)) {
      snapshot.fetchMore();
      return onLoading ??
          const Center(child: CircularProgressIndicator.adaptive());
    }

    return onEmpty;
  }

  bool _canLoadMore(
    FirestoreQueryBuilderSnapshot<T?> snapshot,
    List<T> items,
  ) {
    if (!snapshot.hasMore || snapshot.isFetchingMore) return false;
    final limit = maxItem;
    return limit == null || items.length < limit;
  }

  List<T> _visibleItems(FirestoreQueryBuilderSnapshot<T?> snapshot) {
    final items = snapshot.docs
        .map((document) => document.data())
        .whereType<T>()
        .where((item) => filter?.call(item) ?? true);

    final limit = maxItem;
    if (limit == null) return items.toList(growable: false);
    return items.take(limit).toList(growable: false);
  }
}
