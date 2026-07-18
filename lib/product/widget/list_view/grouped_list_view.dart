import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart' as grouped_list;
import 'package:lifeclient/core/theme/app_colors.dart';

final class GroupedListView<T, K> extends StatelessWidget {
  const GroupedListView({
    required this.items,
    required this.groupBy,
    required this.groupHeaderBuilder,
    required this.itemBuilder,
    this.groupCompare,
    this.padding = EdgeInsets.zero,
    this.separator = const SizedBox.shrink(),
    this.footer,
    this.onReachEnd,
    this.canLoadMore = false,
    this.loadMoreThreshold = 2,
    this.stickyHeaderBackgroundColor = AppColors.ink25,
    this.useStickyGroupSeparators = true,
    super.key,
  }) : assert(loadMoreThreshold >= 0, 'loadMoreThreshold cannot be negative');

  final List<T> items;
  final K Function(T item) groupBy;
  final Widget Function(K key) groupHeaderBuilder;
  final Widget Function(BuildContext context, T item) itemBuilder;
  final int Function(K a, K b)? groupCompare;

  final EdgeInsetsGeometry padding;
  final Widget separator;
  final Widget? footer;

  final VoidCallback? onReachEnd;
  final bool canLoadMore;
  final int loadMoreThreshold;
  final Color stickyHeaderBackgroundColor;
  final bool useStickyGroupSeparators;

  @override
  Widget build(BuildContext context) {
    return grouped_list.GroupedListView<T, K>(
      elements: items,
      groupBy: groupBy,
      groupSeparatorBuilder: groupHeaderBuilder,
      indexedItemBuilder: _buildItem,
      groupComparator: groupCompare,
      sort: groupCompare != null,
      useStickyGroupSeparators: useStickyGroupSeparators,
      stickyHeaderBackgroundColor: stickyHeaderBackgroundColor,
      padding: padding,
      separator: separator,
      footer: footer,
    );
  }

  Widget _buildItem(BuildContext context, T item, int index) {
    final remainingItemCount = items.length - index - 1;

    if (canLoadMore && remainingItemCount <= loadMoreThreshold) {
      onReachEnd?.call();
    }

    return itemBuilder(context, item);
  }
}
