import 'dart:math' as math;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/widget/general/general_not_found_widget.dart';
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
    this.pageSize = 10,
    this.maxItem,
    this.padding = EdgeInsets.zero,
    this.separator = const SizedBox.shrink(),
    this.footer = _defaultFooter,
    super.key,
  }) : assert(pageSize > 0, 'pageSize must be greater than 0'),
       assert(maxItem == null || maxItem > 0, 'maxItem must be greater than 0');

  final Query<T?> query;
  final K Function(T item) groupBy;
  final Widget Function(K key) groupHeaderBuilder;
  final int Function(K a, K b)? groupCompare;
  final GroupedFirestoreItemBuilder<T> itemBuilder;
  final Widget onEmpty;
  final Widget? onLoading;
  final Widget? onError;
  final int pageSize;
  final int? maxItem;
  final EdgeInsetsGeometry padding;
  final Widget separator;
  final Widget footer;

  static const _defaultFooter = Padding(
    padding: PagePadding.verticalLowSymmetric(),
    child: Center(child: CircularProgressIndicator.adaptive()),
  );

  static Widget _defaultError() {
    return GeneralNotFoundWidget(
      title: LocaleKeys.message_somethingWentWrong.tr(),
    );
  }

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
        maxItem: maxItem,
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
    required this.padding,
    required this.separator,
    required this.footer,
    this.groupCompare,
    this.onLoading,
    this.onError,
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
  final int? maxItem;
  final EdgeInsetsGeometry padding;
  final Widget separator;
  final Widget footer;

  static const _loading = Center(child: CircularProgressIndicator.adaptive());

  @override
  Widget build(BuildContext context) {
    final items = _visibleItems();
    final canLoadMore = _canLoadMore(items);

    return switch (_resolveState(items)) {
      _ViewState.loading => onLoading ?? _loading,
      _ViewState.error =>
        onError ?? CustomGroupedFirestoreListView._defaultError(),
      _ViewState.empty => onEmpty,
      _ViewState.data => _GroupedFirestoreList<T, K>(
        items: items,
        snapshot: snapshot,
        groupBy: groupBy,
        groupHeaderBuilder: groupHeaderBuilder,
        groupCompare: groupCompare,
        itemBuilder: itemBuilder,
        canLoadMore: canLoadMore,
        padding: padding,
        separator: separator,
        footer: footer,
      ),
    };
  }

  List<T> _visibleItems() {
    final items = snapshot.docs
        .map((document) => document.data())
        .whereType<T>();

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
      onReachEnd: snapshot.fetchMore,
      footer: snapshot.isFetchingMore ? footer : null,
    );
  }
}
