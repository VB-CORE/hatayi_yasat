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
      builder: (context, snapshot, _) => _GroupedFirestoreContent<T, K>(
        snapshot: snapshot,
        groupBy: groupBy,
        groupHeaderBuilder: groupHeaderBuilder,
        groupCompare: groupCompare,
        itemBuilder: itemBuilder,
        onEmpty: onEmpty,
        onLoading: onLoading,
        onError: onError,
        filter: filter,
        maxItem: maxItem,
        loadMoreThreshold: loadMoreThreshold,
        padding: padding,
        separator: separator,
        footer: footer,
      ),
    );
  }
}

final class _GroupedFirestoreContent<T, K> extends StatelessWidget {
  const _GroupedFirestoreContent({
    required this.snapshot,
    required this.groupBy,
    required this.groupHeaderBuilder,
    required this.itemBuilder,
    required this.onEmpty,
    required this.loadMoreThreshold,
    required this.padding,
    required this.separator,
    required this.footer,
    this.groupCompare,
    this.onLoading,
    this.onError,
    this.filter,
    this.maxItem,
  });

  final FirestoreQueryBuilderSnapshot<T?> snapshot;
  final K Function(T item) groupBy;
  final Widget Function(K key) groupHeaderBuilder;
  final int Function(K a, K b)? groupCompare;
  final GroupedFirestoreItemBuilder<T> itemBuilder;
  final Widget onEmpty;
  final Widget? onLoading;
  final Widget? onError;
  final bool Function(T item)? filter;
  final int? maxItem;
  final int loadMoreThreshold;
  final EdgeInsetsGeometry padding;
  final Widget separator;
  final Widget footer;

  static const _loading = Center(child: CircularProgressIndicator.adaptive());

  @override
  Widget build(BuildContext context) {
    final items = _visibleItems();
    final canLoadMore = _canLoadMore(items);

    final errorWidget = ErrorWidget(
      snapshot.error ?? StateError('An unknown error occurred'),
    );

    return switch (_resolveState(items)) {
      _ViewState.loading => onLoading ?? _loading,
      _ViewState.error => onError ?? errorWidget,
      _ViewState.empty => _GroupedFirestoreEmpty<T>(
        snapshot: snapshot,
        canLoadMore: canLoadMore,
        onEmpty: onEmpty,
        onLoading: onLoading,
      ),
      _ViewState.data => _GroupedFirestoreList<T, K>(
        items: items,
        snapshot: snapshot,
        groupBy: groupBy,
        groupHeaderBuilder: groupHeaderBuilder,
        groupCompare: groupCompare,
        itemBuilder: itemBuilder,
        canLoadMore: canLoadMore,
        loadMoreThreshold: loadMoreThreshold,
        padding: padding,
        separator: separator,
        footer: footer,
      ),
    };
  }

  List<T> _visibleItems() {
    final items = snapshot.docs
        .map((document) => document.data())
        .whereType<T>()
        .where((item) => filter?.call(item) ?? true);

    if (maxItem == null) return items.toList(growable: false);
    return items.take(maxItem!).toList(growable: false);
  }

  bool _canLoadMore(List<T> items) {
    if (!snapshot.hasMore || snapshot.isFetchingMore) return false;
    return maxItem == null || items.length < maxItem!;
  }

  _ViewState _resolveState(List<T> items) {
    if (snapshot.isFetching && snapshot.docs.isEmpty) return _ViewState.loading;
    if (snapshot.hasError) return _ViewState.error;
    if (items.isEmpty) return _ViewState.empty;
    return _ViewState.data;
  }
}

final class _GroupedFirestoreList<T, K> extends StatelessWidget {
  const _GroupedFirestoreList({
    required this.items,
    required this.snapshot,
    required this.groupBy,
    required this.groupHeaderBuilder,
    required this.itemBuilder,
    required this.canLoadMore,
    required this.loadMoreThreshold,
    required this.padding,
    required this.separator,
    required this.footer,
    this.groupCompare,
  });

  final List<T> items;
  final FirestoreQueryBuilderSnapshot<T?> snapshot;
  final K Function(T item) groupBy;
  final Widget Function(K key) groupHeaderBuilder;
  final int Function(K a, K b)? groupCompare;
  final GroupedFirestoreItemBuilder<T> itemBuilder;
  final bool canLoadMore;
  final int loadMoreThreshold;
  final EdgeInsetsGeometry padding;
  final Widget separator;
  final Widget footer;

  @override
  Widget build(BuildContext context) {
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
}

final class _GroupedFirestoreEmpty<T> extends StatelessWidget {
  const _GroupedFirestoreEmpty({
    required this.snapshot,
    required this.canLoadMore,
    required this.onEmpty,
    this.onLoading,
  });

  final FirestoreQueryBuilderSnapshot<T?> snapshot;
  final bool canLoadMore;
  final Widget onEmpty;
  final Widget? onLoading;

  static const _loading = Center(child: CircularProgressIndicator.adaptive());

  @override
  Widget build(BuildContext context) {
    if (canLoadMore) {
      snapshot.fetchMore();
      return onLoading ?? _loading;
    }
    return onEmpty;
  }
}
