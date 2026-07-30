import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lifeclient/product/widget/list_view/firestore_list_state.dart';

typedef FirestoreItemBuilder<T> = Widget Function(BuildContext context, T item);

final class CustomFireStoreListView<T> extends StatelessWidget {
  const CustomFireStoreListView({
    required this.query,
    required this.itemBuilder,
    this.onEmpty,
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
         'itemThreshold must be greater than 0',
       );

  final Query<T?> query;
  final FirestoreItemBuilder<T> itemBuilder;

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
          FirestoreListState.loading => SliverFillRemaining(
            hasScrollBody: false,
            child: onLoading ?? const FirestoreListLoading(),
          ),
          FirestoreListState.error => SliverFillRemaining(
            hasScrollBody: false,
            child: onError ?? const FirestoreListError(),
          ),
          FirestoreListState.empty => SliverFillRemaining(
            hasScrollBody: false,
            child: onEmpty ?? const FirestoreListEmpty(),
          ),
          FirestoreListState.data => _FirestoreListContent<T>(
            snapshot: snapshot,
            items: items,
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

final class _FirestoreListContent<T> extends StatelessWidget {
  const _FirestoreListContent({
    required this.snapshot,
    required this.items,
    required this.itemBuilder,
    required this.padding,
    required this.separator,
    required this.footer,
    this.itemThreshold,
  });

  final FirestoreQueryBuilderSnapshot<T?> snapshot;
  final List<T> items;
  final FirestoreItemBuilder<T> itemBuilder;

  final int? itemThreshold;
  final EdgeInsetsGeometry padding;
  final Widget separator;
  final Widget footer;

  bool get _canLoadMore {
    if (!snapshot.hasMore || snapshot.isFetchingMore) {
      return false;
    }

    return itemThreshold == null || items.length < itemThreshold!;
  }

  @override
  Widget build(BuildContext context) {
    final showFooter = snapshot.isFetchingMore;

    return SliverPadding(
      padding: padding,
      sliver: SliverList.separated(
        itemCount: items.length + (showFooter ? 1 : 0),
        separatorBuilder: (_, _) => separator,
        itemBuilder: (context, index) {
          if (index == items.length) {
            return footer;
          }

          if (_canLoadMore && index == items.length - 1) {
            snapshot.fetchMore();
          }

          return itemBuilder(context, items[index]);
        },
      ),
    );
  }
}
