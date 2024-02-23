import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:vbaseproject/product/init/language/locale_keys.g.dart';
import 'package:vbaseproject/product/package/shimmer/general_shimmer.dart';
import 'package:vbaseproject/product/utility/decorations/custom_shimmer_height.dart';
import 'package:vbaseproject/product/widget/general/general_not_found_widget.dart';
import 'package:vbaseproject/product/widget/general/list/general_firestore_list_view.dart';
import 'package:vbaseproject/product/widget/size/widget_size.dart';

typedef FirestoreEmptyBuilder = Widget Function(BuildContext context);

int kDefaultSemanticIndexCallback(Widget _, int localIndex) => localIndex;

/// Sliver version of the [FirestoreListView]
class FirestoreSliverListView<T> extends StatelessWidget {
  const FirestoreSliverListView({
    required this.query,
    required this.itemBuilder,
    required this.onRetry,
    required this.itemGridBuilder,
    super.key,
    this.pageSize = 10,
    this.isGridDesign = false,
  });
  final Query<T?> query;

  final FireStoreGeneralBuilder<T> itemBuilder;
  final FireStoreGeneralBuilder<T> itemGridBuilder;

  final VoidCallback onRetry;

  final int pageSize;
  final bool isGridDesign;

  @override
  Widget build(BuildContext context) {
    return FirestoreQueryBuilder<T?>(
      query: query,
      pageSize: pageSize,
      builder: (context, snapshot, _) {
        if (snapshot.isFetching) {
          return const SliverFillRemaining(
            child: GeneralShimmer(height: CustomShimmerHeight.small),
          );
        }

        if (snapshot.docs.isEmpty || snapshot.hasError) {
          return SliverFillRemaining(
            child: GeneralNotFoundWidget(
              title: LocaleKeys.notFound_news.tr(),
              onRefresh: onRetry,
            ),
          );
        }

        return Visibility(
          visible: isGridDesign,
          replacement: _SliverList(
            snapshot: snapshot,
            itemBuilder: itemBuilder,
          ),
          child: _SliverGrid(
            snapshot: snapshot,
            itemGridBuilder: itemGridBuilder,
          ),
        );
      },
    );
  }
}

class _SliverList<T> extends StatelessWidget {
  const _SliverList({
    required this.itemBuilder,
    required this.snapshot,
    super.key,
  });

  final FireStoreGeneralBuilder<T> itemBuilder;
  final FirestoreQueryBuilderSnapshot<T?> snapshot;

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemCount: snapshot.docs.length,
      itemBuilder: (context, index) {
        if (snapshot.hasMore && index + 1 == snapshot.docs.length) {
          snapshot.fetchMore();
        }
        final model = snapshot.docs[index].data();
        if (model == null) return const SizedBox.shrink();

        return itemBuilder(context, model);
      },
    );
  }
}

class _SliverGrid<T> extends StatelessWidget {
  const _SliverGrid({
    required this.itemGridBuilder,
    required this.snapshot,
    super.key,
  });

  final FireStoreGeneralBuilder<T> itemGridBuilder;
  final FirestoreQueryBuilderSnapshot<T?> snapshot;
  @override
  Widget build(BuildContext context) {
    return SliverGrid.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: WidgetSizes.spacingSs,
        mainAxisSpacing: WidgetSizes.spacingS,
        mainAxisExtent: context.sized.dynamicHeight(0.24),
      ),
      itemCount: snapshot.docs.length,
      itemBuilder: (context, index) {
        if (snapshot.hasMore && index + 1 == snapshot.docs.length) {
          snapshot.fetchMore();
        }
        final model = snapshot.docs[index].data();
        if (model == null) return const SizedBox.shrink();

        return itemGridBuilder(context, model);
      },
    );
  }
}
