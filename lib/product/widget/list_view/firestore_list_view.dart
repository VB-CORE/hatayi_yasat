import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lifeclient/product/widget/list_view/firestore_list_state.dart';

typedef FirestoreItemBuilder<T> = Widget Function(BuildContext context, T item);

final class CustomFirestoreListView<T> extends StatelessWidget {
  const CustomFirestoreListView({
    required this.query,
    required this.itemBuilder,
    this.header,
    this.onEmpty,
    this.onLoading,
    this.onError,
    this.pageSize = 10,
    this.itemThreshold,
    this.padding = EdgeInsets.zero,
    this.separator = const SizedBox.shrink(),
    this.footer,
    this.controller,
    super.key,
  }) : assert(pageSize > 0, 'pageSize must be greater than 0'),
       assert(
         itemThreshold == null || itemThreshold > 0,
         'itemThreshold must be greater than 0',
       );

  final Query<T?> query;
  final FirestoreItemBuilder<T> itemBuilder;
  final Widget? header;
  final Widget? onEmpty;
  final Widget? onLoading;
  final Widget? onError;
  final int pageSize;
  final int? itemThreshold;
  final EdgeInsetsGeometry padding;
  final Widget separator;
  final Widget? footer;
  final ScrollController? controller;

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

        return CustomScrollView(
          controller: controller,
          slivers: [
            if (header != null) SliverToBoxAdapter(child: header),
            _content(snapshot: snapshot, items: items),
          ],
        );
      },
    );
  }

  Widget _content({
    required FirestoreQueryBuilderSnapshot<T?> snapshot,
    required List<T> items,
  }) {
    final state = FirestoreListState.resolve(snapshot: snapshot, items: items);
    return switch (state) {
      FirestoreListState.loading => SliverFillRemaining(
        child: onLoading ?? const FirestoreListLoading(),
      ),
      FirestoreListState.error => SliverFillRemaining(
        child: SingleChildScrollView(
          child: onError ?? const FirestoreListError(),
        ),
      ),
      FirestoreListState.empty => SliverFillRemaining(
        child: SingleChildScrollView(
          child: onEmpty ?? const FirestoreListEmpty(),
        ),
      ),
      FirestoreListState.data => _FirestoreListContent<T>(
        snapshot: snapshot,
        items: items,
        itemBuilder: itemBuilder,
        itemTreshold: itemThreshold,
        padding: padding,
        separator: separator,
        footer: footer ?? const FirestoreListFooter(),
      ),
    };
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
    this.itemTreshold,
  });

  final FirestoreQueryBuilderSnapshot<T?> snapshot;
  final List<T> items;
  final FirestoreItemBuilder<T> itemBuilder;
  final int? itemTreshold;
  final EdgeInsetsGeometry padding;
  final Widget separator;
  final Widget footer;

  bool get _canLoadMore =>
      snapshot.hasMore &&
      !snapshot.isFetchingMore &&
      (itemTreshold == null || items.length < itemTreshold!);

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: padding,
      sliver: SliverList.separated(
        itemCount: snapshot.isFetchingMore ? items.length + 1 : items.length,
        separatorBuilder: (context, index) => separator,
        itemBuilder: (context, index) {
          if (index == items.length) return footer;
          if (_canLoadMore && index + 1 == items.length) snapshot.fetchMore();
          return itemBuilder(context, items[index]);
        },
      ),
    );
  }
}
