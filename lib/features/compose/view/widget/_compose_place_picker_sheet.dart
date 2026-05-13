part of '../compose_view.dart';

class _ComposePlacePickerSheet extends StatefulWidget {
  const _ComposePlacePickerSheet();

  @override
  State<_ComposePlacePickerSheet> createState() =>
      _ComposePlacePickerSheetState();
}

class _ComposePlacePickerSheetState extends State<_ComposePlacePickerSheet> {
  final _searchController = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.general.colorScheme;
    return DraggableScrollableSheet(
      initialChildSize: 0.85,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      expand: false,
      builder: (context, scrollController) {
        return Column(
          children: [
            const SizedBox(height: 12),
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: colorScheme.onPrimaryContainer,
                borderRadius: const BorderRadius.all(Radius.circular(99)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      LocaleKeys.compose_placePickerTitle.tr(),
                      style: V2Typography.display(
                        fontSize: 22,
                        color: colorScheme.primary,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.close_rounded,
                      color: colorScheme.onPrimaryFixedVariant,
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: _searchController,
                onChanged: (v) => setState(() => _query = v),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: colorScheme.onPrimaryFixed,
                  hintText: LocaleKeys.compose_placePickerSearch.tr(),
                  prefixIcon: Icon(
                    Icons.search_rounded,
                    color: colorScheme.onSecondaryFixed,
                    size: 20,
                  ),
                  border: const OutlineInputBorder(
                    borderRadius: CustomRadius.medium,
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            const EmptyBox.smallHeight(),
            Expanded(
              child: _PlacePickerList(
                scrollController: scrollController,
                query: _query,
              ),
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.add_circle_outline_rounded),
                    label: Text(
                      LocaleKeys.compose_placePickerSuggestNew.tr(),
                    ),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      foregroundColor: colorScheme.primary,
                      side: BorderSide(color: colorScheme.onPrimaryContainer),
                      shape: const RoundedRectangleBorder(
                        borderRadius: CustomRadius.medium,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _PlacePickerList extends StatelessWidget {
  const _PlacePickerList({
    required this.scrollController,
    required this.query,
  });

  final ScrollController scrollController;
  final String query;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.general.colorScheme;
    final textTheme = context.general.textTheme;
    final firestore = FirebaseFirestore.instance;
    final stream = firestore
        .collection('approvedApplications')
        .limit(60)
        .snapshots();
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: stream,
      builder: (context, snap) {
        if (!snap.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        final docs = snap.data!.docs;
        final filtered = query.trim().isEmpty
            ? docs
            : docs.where((d) {
                final name = (d.data()['name'] as String? ?? '').toLowerCase();
                return name.contains(query.toLowerCase());
              }).toList();
        if (filtered.isEmpty) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Text(
                LocaleKeys.places_noResultsTitle.tr(),
                style: textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSecondaryFixed,
                ),
              ),
            ),
          );
        }
        return ListView.separated(
          controller: scrollController,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: filtered.length,
          separatorBuilder: (_, _) =>
              Divider(height: 1, color: colorScheme.onPrimaryContainer),
          itemBuilder: (_, index) {
            final doc = filtered[index];
            final data = doc.data();
            final name = data['name'] as String? ?? '';
            final address = data['address'] as String? ?? '';
            return ListTile(
              dense: true,
              contentPadding: const EdgeInsets.symmetric(horizontal: 4),
              leading: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: colorScheme.error.withValues(alpha: 0.1),
                  borderRadius: CustomRadius.small,
                ),
                child: Icon(
                  Icons.place_rounded,
                  color: colorScheme.error,
                  size: 18,
                ),
              ),
              title: Text(
                name,
                style: textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: colorScheme.onSurface,
                ),
              ),
              subtitle: address.isEmpty
                  ? null
                  : Text(
                      address,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSecondaryFixed,
                      ),
                    ),
              onTap: () => Navigator.of(context).pop<ComposePlaceTag>(
                ComposePlaceTag(
                  id: doc.id,
                  name: name,
                  district: address,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
