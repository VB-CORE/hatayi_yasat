import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

final class FirestoreGridView<Document>
    extends FirestoreQueryBuilder<Document> {
  FirestoreGridView({
    required super.query,
    required FirestoreItemBuilder<Document> itemBuilder,
    required SliverGridDelegate gridDelegate,
    super.key,
    super.pageSize,
    FirestoreLoadingBuilder? loadingBuilder,
    FirestoreErrorBuilder? errorBuilder,
    Widget Function(BuildContext)? emptyBuilder,
    Axis scrollDirection = Axis.vertical,
    bool reverse = false,
    ScrollController? controller,
    bool? primary,
    ScrollPhysics? physics,
    bool shrinkWrap = false,
    EdgeInsetsGeometry? padding,
    bool addAutomaticKeepAlives = true,
    bool addRepaintBoundaries = true,
    bool addSemanticIndexes = true,
    double? cacheExtent,
    int? semanticChildCount,
    DragStartBehavior dragStartBehavior = DragStartBehavior.start,
    ScrollViewKeyboardDismissBehavior keyboardDismissBehavior =
        ScrollViewKeyboardDismissBehavior.manual,
    String? restorationId,
    Clip clipBehavior = Clip.hardEdge,
  }) : super(
          builder: (context, snapshot, _) {
            if (snapshot.isFetching) {
              return loadingBuilder?.call(context) ??
                  const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError && errorBuilder != null) {
              return errorBuilder(
                context,
                snapshot.error!,
                snapshot.stackTrace!,
              );
            }

            if (snapshot.docs.isEmpty && emptyBuilder != null) {
              return emptyBuilder(context);
            }

            return GridView.builder(
              gridDelegate: gridDelegate,
              itemCount: snapshot.docs.length,
              itemBuilder: (context, index) {
                final isLastItem = index + 1 == snapshot.docs.length;
                if (isLastItem && snapshot.hasMore) snapshot.fetchMore();

                final doc = snapshot.docs[index];
                return itemBuilder(context, doc);
              },
              scrollDirection: scrollDirection,
              reverse: reverse,
              controller: controller,
              primary: primary,
              physics: physics,
              shrinkWrap: shrinkWrap,
              padding: padding,
              addAutomaticKeepAlives: addAutomaticKeepAlives,
              addRepaintBoundaries: addRepaintBoundaries,
              addSemanticIndexes: addSemanticIndexes,
              cacheExtent: cacheExtent,
              semanticChildCount: semanticChildCount,
              dragStartBehavior: dragStartBehavior,
              keyboardDismissBehavior: keyboardDismissBehavior,
              restorationId: restorationId,
              clipBehavior: clipBehavior,
            );
          },
        );
}

final class FirestoreGridSliverView<Document>
    extends FirestoreQueryBuilder<Document> {
  FirestoreGridSliverView({
    required super.query,
    required FirestoreItemBuilder<Document> itemBuilder,
    required SliverGridDelegate gridDelegate,
    super.key,
    super.pageSize,
    FirestoreLoadingBuilder? loadingBuilder,
    FirestoreErrorBuilder? errorBuilder,
    Widget Function(BuildContext)? emptyBuilder,
  }) : super(
          builder: (context, snapshot, _) {
            if (snapshot.isFetching) {
              return loadingBuilder?.call(context) ??
                  const SliverFillRemaining(
                    child: Center(child: CircularProgressIndicator()),
                  );
            }

            if (snapshot.hasError && errorBuilder != null) {
              return errorBuilder(
                context,
                snapshot.error!,
                snapshot.stackTrace!,
              );
            }

            if (snapshot.docs.isEmpty && emptyBuilder != null) {
              return emptyBuilder(context);
            }

            return SliverGrid.builder(
              gridDelegate: gridDelegate,
              itemCount: snapshot.docs.length,
              itemBuilder: (context, index) {
                final isLastItem = index + 1 == snapshot.docs.length;
                if (isLastItem && snapshot.hasMore) snapshot.fetchMore();

                final doc = snapshot.docs[index];
                return itemBuilder(context, doc);
              },
            );
          },
        );
}
