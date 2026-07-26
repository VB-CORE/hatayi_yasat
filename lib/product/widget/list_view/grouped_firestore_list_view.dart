import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lifeclient/product/widget/list_view/firestore_list_state.dart';
import 'package:lifeclient/product/widget/list_view/grouped_list_view.dart';

typedef GroupedFirestoreItemBuilder<T> =
    Widget Function(BuildContext context, T item);

final class CustomGroupedFirestoreListView<T, K> extends StatelessWidget {
  const CustomGroupedFirestoreListView({
    required this.query,
    required this.groupBy,
    required this.groupHeaderBuilder,
    required this.itemBuilder,
    this.onEmpty,
    this.groupCompare,
    this.onLoading,
    this.onError,
    this.pageSize = 10,
    this.itemThreshold,
    this.padding = EdgeInsets.zero,
    this.separator = const SizedBox.shrink(),
    this.footer,
    super.key,
  }) : assert(pageSize > 0, 'pageSize must be greater than 0'),
       assert(
         itemThreshold == null || itemThreshold > 0,
         'itemTreshold must be greater than 0',
       );

  final Query<T?> query;
  final K Function(T item) groupBy;
  final Widget Function(K key) groupHeaderBuilder;
  final int Function(K a, K b)? groupCompare;
  final GroupedFirestoreItemBuilder<T> itemBuilder;
  final Widget? onEmpty;
  final Widget? onLoading;
  final Widget? onError;
  final int pageSize;
  final int? itemThreshold;
  final EdgeInsetsGeometry padding;
  final Widget separator;
  final Widget? footer;

  @override
  Widget build(BuildContext context) {
    return FirestoreQueryBuilder<T?>(
      query: query,
      pageSize: pageSize,
      builder: (context, snapshot, _) {
        final items = snapshot.docs
            .map((document) => document.data())
            .whereType<T>()
            .toList(growable: false);

        final state = FirestoreListState.resolve(
          snapshot: snapshot,
          items: items,
        );

        return switch (state) {
          FirestoreListState.loading =>
            onLoading ?? const FirestoreListLoading(),
          FirestoreListState.error => onError ?? const FirestoreListError(),
          FirestoreListState.empty => onEmpty ?? const FirestoreListEmpty(),
          FirestoreListState.data => _GroupedFirestoreListContent<T, K>(
            snapshot: snapshot,
            items: items,
            groupBy: groupBy,
            groupHeaderBuilder: groupHeaderBuilder,
            groupCompare: groupCompare,
            itemBuilder: itemBuilder,
            itemThreshold: itemThreshold,
            padding: padding,
            separator: separator,
            footer: footer ?? const FirestoreListFooter(),
          ),
        };
      },
    );
  }
}

final class _GroupedFirestoreListContent<T, K> extends StatelessWidget {
  const _GroupedFirestoreListContent({
    required this.snapshot,
    required this.items,
    required this.groupBy,
    required this.groupHeaderBuilder,
    required this.itemBuilder,
    required this.footer,
    this.groupCompare,
    this.itemThreshold,
    this.padding = EdgeInsets.zero,
    this.separator = const SizedBox.shrink(),
  });

  final FirestoreQueryBuilderSnapshot<T?> snapshot;
  final List<T> items;
  final K Function(T item) groupBy;
  final Widget Function(K key) groupHeaderBuilder;
  final int Function(K a, K b)? groupCompare;
  final GroupedFirestoreItemBuilder<T> itemBuilder;
  final int? itemThreshold;
  final EdgeInsetsGeometry padding;
  final Widget separator;
  final Widget footer;

  bool get canLoadMore =>
      snapshot.hasMore &&
      !snapshot.isFetchingMore &&
      (itemThreshold == null || items.length < itemThreshold!);

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
