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
    this.onEmpty,
    this.groupCompare,
    this.onLoading,
    this.onError,
    this.pageSize = 10,
    this.itemTreshold,
    this.padding = EdgeInsets.zero,
    this.separator = const SizedBox.shrink(),
    this.footer,
    super.key,
  }) : assert(pageSize > 0, 'pageSize must be greater than 0'),
       assert(
         itemTreshold == null || itemTreshold > 0,
         'itemTreshold must be greater than 0',
       );

  final Query<T> query;

  final K Function(T item) groupBy;
  final Widget Function(K key) groupHeaderBuilder;
  final int Function(K a, K b)? groupCompare;
  final GroupedFirestoreItemBuilder<T> itemBuilder;

  final Widget? onEmpty;
  final Widget? onLoading;
  final Widget? onError;

  final int pageSize;
  final int? itemTreshold;

  final EdgeInsetsGeometry padding;
  final Widget separator;
  final Widget? footer;

  @override
  Widget build(BuildContext context) {
    return FirestoreQueryBuilder<T>(
      query: query,
      pageSize: pageSize,
      builder: (context, snapshot, _) {
        final items = snapshot.docs
            .map((document) => document.data())
            .toList(growable: false);

        final state = _resolveState(snapshot: snapshot, items: items);

        return switch (state) {
          _ViewState.loading => onLoading ?? const _DefaultLoading(),
          _ViewState.error => onError ?? const _DefaultError(),
          _ViewState.empty => onEmpty ?? const _DefaultEmpty(),
          _ViewState.data => _GroupedFirestoreListContent<T, K>(
            snapshot: snapshot,
            items: items,
            groupBy: groupBy,
            groupHeaderBuilder: groupHeaderBuilder,
            groupCompare: groupCompare,
            itemBuilder: itemBuilder,
            itemTreshold: itemTreshold,
            padding: padding,
            separator: separator,
            footer: footer ?? const _DefaultFooter(),
          ),
        };
      },
    );
  }

  _ViewState _resolveState({
    required FirestoreQueryBuilderSnapshot<T> snapshot,
    required List<T> items,
  }) {
    if (snapshot.isFetching && items.isEmpty) return _ViewState.loading;
    if (snapshot.hasError && items.isEmpty) return _ViewState.error;
    if (items.isEmpty) return _ViewState.empty;
    return _ViewState.data;
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
    this.itemTreshold,
    this.padding = EdgeInsets.zero,
    this.separator = const SizedBox.shrink(),
  });

  final FirestoreQueryBuilderSnapshot<T> snapshot;
  final List<T> items;
  final K Function(T item) groupBy;
  final Widget Function(K key) groupHeaderBuilder;
  final int Function(K a, K b)? groupCompare;
  final GroupedFirestoreItemBuilder<T> itemBuilder;
  final int? itemTreshold;
  final EdgeInsetsGeometry padding;
  final Widget separator;
  final Widget footer;

  bool get canLoadMore =>
      snapshot.hasMore &&
      !snapshot.isFetchingMore &&
      (itemTreshold == null || items.length < itemTreshold!);

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

final class _DefaultLoading extends StatelessWidget {
  const _DefaultLoading();

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator.adaptive());
  }
}

final class _DefaultError extends StatelessWidget {
  const _DefaultError();

  @override
  Widget build(BuildContext context) {
    return GeneralNotFoundWidget(
      title: LocaleKeys.message_somethingWentWrong.tr(),
    );
  }
}

final class _DefaultEmpty extends StatelessWidget {
  const _DefaultEmpty();

  @override
  Widget build(BuildContext context) {
    return GeneralNotFoundWidget(title: LocaleKeys.message_emptyList.tr());
  }
}

final class _DefaultFooter extends StatelessWidget {
  const _DefaultFooter();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: PagePadding.verticalLowSymmetric(),
      child: Center(child: CircularProgressIndicator.adaptive()),
    );
  }
}
