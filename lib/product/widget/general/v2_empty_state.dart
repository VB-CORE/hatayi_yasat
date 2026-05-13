import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart' show ContextExtension;
import 'package:lifeclient/product/init/application_theme.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/utility/decorations/custom_radius.dart';
import 'package:lifeclient/product/utility/decorations/empty_box.dart';
import 'package:lifeclient/product/widget/brand/eyebrow.dart';

/// V2 empty state — eyebrow + display title + body + optional action.
///
/// Use the named constructors for the canonical V2 empty surfaces:
///  - [V2EmptyState.feed]  — community feed has no posts yet
///  - [V2EmptyState.search] — search returned no results
///  - [V2EmptyState.favorites] — saved list is empty
///  - [V2EmptyState.memories] — memory archive is empty
class V2EmptyState extends StatelessWidget {
  const V2EmptyState({
    required this.eyebrow,
    required this.title,
    required this.body,
    super.key,
    this.actionLabel,
    this.onAction,
  });

  /// Empty community feed.
  const V2EmptyState.feed({super.key, this.onAction})
    : eyebrow = LocaleKeys.emptyStates_feedEyebrow,
      title = LocaleKeys.emptyStates_feedTitle,
      body = LocaleKeys.emptyStates_feedBody,
      actionLabel = LocaleKeys.emptyStates_feedAction;

  /// Search returned nothing.
  const V2EmptyState.search({super.key})
    : eyebrow = LocaleKeys.emptyStates_searchEyebrow,
      title = LocaleKeys.emptyStates_searchTitle,
      body = LocaleKeys.emptyStates_searchBody,
      actionLabel = null,
      onAction = null;

  /// User has saved nothing.
  const V2EmptyState.favorites({super.key, this.onAction})
    : eyebrow = LocaleKeys.emptyStates_favoritesEyebrow,
      title = LocaleKeys.emptyStates_favoritesTitle,
      body = LocaleKeys.emptyStates_favoritesBody,
      actionLabel = LocaleKeys.emptyStates_favoritesAction;

  /// Memory archive empty.
  const V2EmptyState.memories({super.key, this.onAction})
    : eyebrow = LocaleKeys.memories_heroEyebrow,
      title = LocaleKeys.memories_emptyTitle,
      body = LocaleKeys.memories_emptyBody,
      actionLabel = LocaleKeys.memories_addMemory;

  final String eyebrow;
  final String title;
  final String body;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.general.colorScheme;
    final textTheme = context.general.textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 48),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Eyebrow(eyebrow.tr()),
          const EmptyBox.smallHeight(),
          Text(
            title.tr(),
            style: V2Typography.display(
              fontSize: 24,
              color: colorScheme.onSurface,
            ),
          ),
          const EmptyBox.smallHeight(),
          Text(
            body.tr(),
            style: textTheme.bodyMedium?.copyWith(
              color: colorScheme.onPrimaryFixedVariant,
              height: 1.5,
            ),
          ),
          if (actionLabel != null && onAction != null) ...[
            const EmptyBox.middleHeight(),
            ElevatedButton(
              onPressed: onAction,
              style: ElevatedButton.styleFrom(
                backgroundColor: colorScheme.error,
                foregroundColor: colorScheme.onPrimary,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                shape: const RoundedRectangleBorder(
                  borderRadius: CustomRadius.medium,
                ),
              ),
              child: Text(
                actionLabel!.tr(),
                style: const TextStyle(fontWeight: FontWeight.w800),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
