import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart' show ContextExtension;
import 'package:lifeclient/product/init/application_theme.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/model/social/memory_model.dart';
import 'package:lifeclient/product/repository/memories/memories_repository_provider.dart';
import 'package:lifeclient/product/utility/decorations/colors_custom.dart';
import 'package:lifeclient/product/utility/decorations/custom_radius.dart';
import 'package:lifeclient/product/utility/decorations/empty_box.dart';
import 'package:lifeclient/product/widget/brand/eyebrow.dart';
import 'package:lifeclient/product/widget/brand/mosaic_grid.dart';
import 'package:lifeclient/product/widget/general/v2_empty_state.dart';

/// V2 Memories ("Hatıralar") list — gold mosaic hero + memory cards
/// (year + era + contributor + love count). Reads from `memories/`
/// via [memoriesRepositoryProvider].
class MemoriesView extends ConsumerWidget {
  const MemoriesView({super.key, this.cityId = 'hatay'});

  final String cityId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = context.general.colorScheme;
    final repo = ref.watch(memoriesRepositoryProvider);
    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: StreamBuilder<List<MemoryModel>>(
        stream: repo.watchMemories(cityId: cityId),
        builder: (context, snap) {
          final memories = snap.data ?? const <MemoryModel>[];
          return CustomScrollView(
            slivers: [
              const SliverToBoxAdapter(child: _Hero()),
              if (memories.isEmpty &&
                  snap.connectionState != ConnectionState.waiting)
                const SliverToBoxAdapter(child: V2EmptyState.memories()),
              if (snap.connectionState == ConnectionState.waiting)
                const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 48),
                    child: Center(child: CircularProgressIndicator()),
                  ),
                ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                sliver: SliverList.separated(
                  itemCount: memories.length,
                  separatorBuilder: (_, _) => const EmptyBox(height: 12),
                  itemBuilder: (_, i) => _MemoryCard(memory: memories[i]),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _Hero extends StatelessWidget {
  const _Hero();

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.general.colorScheme;
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(bottom: Radius.circular(24)),
      child: Stack(
        children: [
          Container(
            height: 220,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [ColorsCustom.navy, ColorsCustom.navy600],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          const Positioned.fill(
            child: IgnorePointer(child: MosaicGrid()),
          ),
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Eyebrow(
                    LocaleKeys.memories_heroEyebrow.tr(),
                    color: ColorsCustom.gold200,
                  ),
                  const EmptyBox(height: 6),
                  Text(
                    LocaleKeys.memories_heroTitle.tr(),
                    style: V2Typography.display(
                      color: colorScheme.onPrimary,
                    ),
                  ),
                  const EmptyBox.smallHeight(),
                  Text(
                    LocaleKeys.memories_heroBody.tr(),
                    style: context.general.textTheme.bodySmall?.copyWith(
                      color: colorScheme.onPrimary.withValues(alpha: 0.75),
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MemoryCard extends StatelessWidget {
  const _MemoryCard({required this.memory});

  final MemoryModel memory;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.general.colorScheme;
    final textTheme = context.general.textTheme;
    return Container(
      decoration: BoxDecoration(
        color: colorScheme.secondary,
        borderRadius: CustomRadius.large,
        border: Border.all(color: colorScheme.onPrimaryContainer),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 120,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [ColorsCustom.navy600, ColorsCustom.navy],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Stack(
              children: [
                const Positioned.fill(child: MosaicGrid()),
                Positioned(
                  left: 16,
                  bottom: 16,
                  right: 16,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Eyebrow(
                        memory.era,
                        color: ColorsCustom.gold200,
                      ),
                      const EmptyBox.xSmallHeight(),
                      Text(
                        memory.title,
                        style: V2Typography.display(
                          fontSize: 22,
                          color: colorScheme.onPrimary,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 16,
                  right: 16,
                  child: Text(
                    '${memory.year}',
                    style: V2Typography.display(
                      fontSize: 24,
                      color: colorScheme.onPrimary.withValues(alpha: 0.8),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  memory.text,
                  style: textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onPrimaryFixedVariant,
                    height: 1.5,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                const EmptyBox(height: 12),
                Row(
                  children: [
                    Text(
                      '${LocaleKeys.memories_contributorPrefix.tr()} ${memory.authorName} · ${memory.neighborhood}',
                      style: V2Typography.label(
                        fontSize: 11.5,
                        color: colorScheme.onSecondaryFixed,
                      ),
                    ),
                    const Spacer(),
                    Icon(
                      Icons.favorite_rounded,
                      size: 14,
                      color: colorScheme.error,
                    ),
                    const EmptyBox(width: 4),
                    Text(
                      '${memory.loveCount}',
                      style: V2Typography.label(
                        color: colorScheme.onPrimaryFixedVariant,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
