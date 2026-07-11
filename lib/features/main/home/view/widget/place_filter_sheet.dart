import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/theme/app_colors.dart';
import 'package:lifeclient/core/theme/app_radius.dart';
import 'package:lifeclient/core/theme/app_spacing.dart';
import 'package:lifeclient/core/theme/app_text.dart';
import 'package:lifeclient/features/main/home/provider/home_view_model.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/utility/constants/app_icons.dart';
import 'package:lifeclient/product/utility/mixin/app_provider_mixin.dart';

/// Full-height "Filtre" sheet with a draft state that is only committed to the
/// home list when the CTA is pressed. Category + district filter server-side;
/// open-now + favorites filter in memory (see [HomeViewModel]).
final class PlaceFilterSheet extends ConsumerStatefulWidget {
  const PlaceFilterSheet({super.key});

  static const int _otherCategoryValue = 1000;

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.surface,
      shape: RoundedRectangleBorder(borderRadius: AppRadius.sheet),
      builder: (_) => const PlaceFilterSheet(),
    );
  }

  @override
  ConsumerState<PlaceFilterSheet> createState() => _PlaceFilterSheetState();
}

class _PlaceFilterSheetState extends ConsumerState<PlaceFilterSheet>
    with AppProviderMixin<PlaceFilterSheet> {
  late Set<int> _categoryValues;
  late Set<int> _townCodes;
  late bool _openNow;
  late bool _favoritesOnly;

  final _searchController = TextEditingController();
  String _townQuery = '';
  Timer? _debounce;
  int _countToken = 0;
  int? _resultCount;
  bool _countLoading = false;

  @override
  void initState() {
    super.initState();
    final state = ref.read(homeViewModelProvider);
    _categoryValues = {...state.categoryValues};
    _townCodes = {...state.townCodes};
    _openNow = state.openNow;
    _favoritesOnly = state.favoritesOnly;
    _searchController.addListener(() {
      setState(() => _townQuery = _searchController.text.trim().toLowerCase());
    });
    unawaited(_recount());
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  void _onDraftChanged() {
    setState(() {});
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), _recount);
  }

  Future<void> _recount() async {
    final token = ++_countToken;
    setState(() => _countLoading = true);
    final count = await ref.read(homeViewModelProvider.notifier).countResults(
          categoryValues: _categoryValues,
          townCodes: _townCodes,
          openNow: _openNow,
          favoritesOnly: _favoritesOnly,
        );
    if (!mounted || token != _countToken) return;
    setState(() {
      _resultCount = count;
      _countLoading = false;
    });
  }

  void _toggleCategory(int value) {
    if (!_categoryValues.remove(value)) _categoryValues.add(value);
    _onDraftChanged();
  }

  void _toggleTown(int code) {
    if (!_townCodes.remove(code)) _townCodes.add(code);
    _onDraftChanged();
  }

  void _clearAll() {
    _categoryValues = {};
    _townCodes = {};
    _openNow = false;
    _favoritesOnly = false;
    _searchController.clear();
    _onDraftChanged();
  }

  void _apply() {
    unawaited(
      ref.read(homeViewModelProvider.notifier).applyFilters(
            categoryValues: _categoryValues,
            townCodes: _townCodes,
            openNow: _openNow,
            favoritesOnly: _favoritesOnly,
          ),
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final categories = productState.categoryItems
        .where((e) => e.value != PlaceFilterSheet._otherCategoryValue)
        .toList();
    final towns = productProvider.regionalTowns;
    final filteredTowns = _townQuery.isEmpty
        ? towns
        : towns
            .where((t) => t.displayName.toLowerCase().contains(_townQuery))
            .toList();

    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.92,
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [
            const _SheetHandle(),
            _Header(onClear: _clearAll),
            const Divider(height: 1, color: AppColors.ink50),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.lg,
                  AppSpacing.lg,
                  AppSpacing.lg,
                  AppSpacing.xl,
                ),
                children: [
                  _SectionHeader(
                    title: LocaleKeys.filter_categories.tr(),
                    trailing: _countLabel(_categoryValues.length, categories.length),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Wrap(
                    spacing: AppSpacing.xs,
                    runSpacing: AppSpacing.xs,
                    children: [
                      for (final category in categories)
                        _FilterChip(
                          label: category.displayName.toUpperCase(),
                          isSelected: _categoryValues.contains(category.value),
                          onTap: () => _toggleCategory(category.value),
                        ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  _SectionTitle(LocaleKeys.filter_others.tr()),
                  const SizedBox(height: AppSpacing.xs),
                  _ToggleRow(
                    icon: Icons.schedule_outlined,
                    label: LocaleKeys.filter_openNow.tr(),
                    value: _openNow,
                    onChanged: (value) {
                      _openNow = value;
                      _onDraftChanged();
                    },
                  ),
                  _ToggleRow(
                    icon: AppIcons.favoriteBorder,
                    label: LocaleKeys.filter_favoritesOnly.tr(),
                    value: _favoritesOnly,
                    onChanged: (value) {
                      _favoritesOnly = value;
                      _onDraftChanged();
                    },
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  _SectionHeader(
                    title: LocaleKeys.filter_districts.tr(),
                    trailing: _countLabel(_townCodes.length, towns.length),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  _TownSearchField(controller: _searchController),
                  const SizedBox(height: AppSpacing.sm),
                  _NearYouChips(
                    towns: towns.take(3).toList(),
                    selected: _townCodes,
                    onTap: _toggleTown,
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  for (final town in filteredTowns)
                    _TownCheckRow(
                      name: town.displayName,
                      isSelected: _townCodes.contains(town.code),
                      onTap: () => _toggleTown(town.code),
                    ),
                ],
              ),
            ),
            _CtaFooter(
              count: _resultCount,
              loading: _countLoading,
              onApply: _apply,
            ),
          ],
        ),
      ),
    );
  }

  String _countLabel(int selected, int total) =>
      LocaleKeys.filter_selectedCount.tr(args: ['$selected', '$total']);
}

final class _SheetHandle extends StatelessWidget {
  const _SheetHandle();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36,
      height: 4,
      margin: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
      decoration: BoxDecoration(
        color: AppColors.ink200,
        borderRadius: BorderRadius.circular(AppRadius.pill),
      ),
    );
  }
}

final class _Header extends StatelessWidget {
  const _Header({required this.onClear});

  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
      child: Row(
        children: [
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: TextButton(
                onPressed: onClear,
                child: Text(
                  LocaleKeys.filter_clear.tr(),
                  style: AppText.label.copyWith(color: AppColors.ink500),
                ),
              ),
            ),
          ),
          Text(
            LocaleKeys.filter_title.tr(),
            style: AppText.title.copyWith(fontSize: 18),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(AppIcons.close, color: AppColors.ink500),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

final class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(title, style: AppText.title);
  }
}

final class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title, required this.trailing});

  final String title;
  final String trailing;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _SectionTitle(title),
        Text(
          trailing,
          style: AppText.label.copyWith(color: AppColors.coral),
        ),
      ],
    );
  }
}

final class _FilterChip extends StatelessWidget {
  const _FilterChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: isSelected ? AppColors.coral50 : AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.pill),
        border: Border.all(
          color: isSelected ? AppColors.coral : AppColors.ink100,
          width: isSelected ? 1.5 : 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(AppRadius.pill),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.sm,
              vertical: AppSpacing.xs,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  isSelected ? AppIcons.check : AppIcons.add,
                  size: 16,
                  color: isSelected ? AppColors.coral : AppColors.ink400,
                ),
                const SizedBox(width: AppSpacing.xxs),
                Text(
                  label,
                  style: AppText.caption.copyWith(
                    color: isSelected ? AppColors.coral700 : AppColors.ink700,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

final class _ToggleRow extends StatelessWidget {
  const _ToggleRow({
    required this.icon,
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final IconData icon;
  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xxs),
      child: Row(
        children: [
          Icon(icon, color: AppColors.ink500),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              label,
              style: AppText.body.copyWith(
                color: AppColors.ink900,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeTrackColor: AppColors.coral,
          ),
        ],
      ),
    );
  }
}

final class _TownSearchField extends StatelessWidget {
  const _TownSearchField({required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.ink50,
        hintText: LocaleKeys.filter_searchDistrict.tr(),
        hintStyle: AppText.body.copyWith(color: AppColors.ink400),
        prefixIcon: const Icon(AppIcons.search, color: AppColors.ink400),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

final class _NearYouChips extends StatelessWidget {
  const _NearYouChips({
    required this.towns,
    required this.selected,
    required this.onTap,
  });

  final List<RegionalTownSubItem> towns;
  final Set<int> selected;
  final void Function(int code) onTap;

  @override
  Widget build(BuildContext context) {
    if (towns.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.near_me_outlined, size: 16, color: AppColors.teal),
            const SizedBox(width: AppSpacing.xxs),
            Text(
              LocaleKeys.filter_nearYou.tr(),
              style: AppText.caption.copyWith(
                color: AppColors.teal600,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.xs),
        Wrap(
          spacing: AppSpacing.xs,
          runSpacing: AppSpacing.xs,
          children: [
            for (final town in towns)
              _NearYouChip(
                label: town.displayName,
                isSelected: selected.contains(town.code),
                onTap: () => onTap(town.code),
              ),
          ],
        ),
      ],
    );
  }
}

final class _NearYouChip extends StatelessWidget {
  const _NearYouChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: isSelected ? AppColors.teal : AppColors.teal50,
        borderRadius: BorderRadius.circular(AppRadius.pill),
        border: Border.all(color: AppColors.teal200),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(AppRadius.pill),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.sm,
              vertical: AppSpacing.xs,
            ),
            child: Text(
              label,
              style: AppText.caption.copyWith(
                color: isSelected ? AppColors.white : AppColors.teal700,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

final class _TownCheckRow extends StatelessWidget {
  const _TownCheckRow({
    required this.name,
    required this.isSelected,
    required this.onTap,
  });

  final String name;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
        child: Row(
          children: [
            Container(
              width: 22,
              height: 22,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isSelected ? AppColors.navy : AppColors.surface,
                borderRadius: BorderRadius.circular(AppRadius.sm),
                border: Border.all(
                  color: isSelected ? AppColors.navy : AppColors.ink200,
                ),
              ),
              child: isSelected
                  ? const Icon(AppIcons.check, size: 15, color: AppColors.white)
                  : null,
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Text(
                name,
                style: AppText.body.copyWith(color: AppColors.ink900),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

final class _CtaFooter extends StatelessWidget {
  const _CtaFooter({
    required this.count,
    required this.loading,
    required this.onApply,
  });

  final int? count;
  final bool loading;
  final VoidCallback onApply;

  @override
  Widget build(BuildContext context) {
    final resolved = count ?? 0;
    final enabled = !loading && resolved > 0;
    final label = resolved == 0 && !loading
        ? LocaleKeys.filter_noResults.tr()
        : LocaleKeys.filter_showResults.tr(args: ['$resolved']);

    return Container(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.sm,
        AppSpacing.lg,
        AppSpacing.sm,
      ),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(top: BorderSide(color: AppColors.ink50)),
      ),
      child: SafeArea(
        top: false,
        child: Opacity(
          opacity: enabled ? 1 : 0.4,
          child: Material(
            color: AppColors.navy,
            borderRadius: BorderRadius.circular(AppRadius.md),
            child: InkWell(
              borderRadius: BorderRadius.circular(AppRadius.md),
              onTap: enabled ? onApply : null,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (loading)
                      const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: AppColors.white,
                        ),
                      )
                    else ...[
                      Text(
                        label,
                        style: AppText.label.copyWith(color: AppColors.white),
                      ),
                      if (enabled) ...[
                        const SizedBox(width: AppSpacing.xs),
                        const Icon(
                          Icons.arrow_forward_rounded,
                          size: 18,
                          color: AppColors.white,
                        ),
                      ],
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
