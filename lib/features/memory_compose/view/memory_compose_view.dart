import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart' show ContextExtension;
import 'package:lifeclient/features/memory_compose/provider/memory_compose_view_model.dart';
import 'package:lifeclient/product/init/application_theme.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/package/photo_picker/photo_picker_manager.dart';
import 'package:lifeclient/product/utility/decorations/custom_radius.dart';
import 'package:lifeclient/product/utility/decorations/empty_box.dart';
import 'package:lifeclient/product/widget/brand/eyebrow.dart';

part 'widget/_memory_compose_field.dart';
part 'widget/_memory_compose_photos.dart';

/// V2 memory compose form. Reads the current city from `productProvider`
/// and submits via `memoriesRepositoryProvider`.
class MemoryComposeView extends ConsumerStatefulWidget {
  const MemoryComposeView({super.key});

  @override
  ConsumerState<MemoryComposeView> createState() => _MemoryComposeViewState();
}

class _MemoryComposeViewState extends ConsumerState<MemoryComposeView> {
  final _titleCtrl = TextEditingController();
  final _textCtrl = TextEditingController();
  final _yearCtrl = TextEditingController();
  final _eraCtrl = TextEditingController();
  final _neighborhoodCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    _titleCtrl.addListener(
      () => ref
          .read(memoryComposeViewModelProvider.notifier)
          .setTitle(_titleCtrl.text),
    );
    _textCtrl.addListener(
      () => ref
          .read(memoryComposeViewModelProvider.notifier)
          .setText(_textCtrl.text),
    );
    _yearCtrl.addListener(() {
      final n = int.tryParse(_yearCtrl.text);
      ref.read(memoryComposeViewModelProvider.notifier).setYear(n);
    });
    _eraCtrl.addListener(
      () => ref
          .read(memoryComposeViewModelProvider.notifier)
          .setEra(_eraCtrl.text),
    );
    _neighborhoodCtrl.addListener(
      () => ref
          .read(memoryComposeViewModelProvider.notifier)
          .setNeighborhood(_neighborhoodCtrl.text),
    );
  }

  @override
  void dispose() {
    _titleCtrl.dispose();
    _textCtrl.dispose();
    _yearCtrl.dispose();
    _eraCtrl.dispose();
    _neighborhoodCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.general.colorScheme;
    final state = ref.watch(memoryComposeViewModelProvider);
    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close_rounded),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
        title: Text(
          LocaleKeys.memories_composeTitle.tr(),
          style: V2Typography.display(
            fontSize: 20,
            color: colorScheme.onSurface,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: ElevatedButton(
              onPressed: state.canSubmit ? _onSubmit : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: colorScheme.tertiary,
                foregroundColor: colorScheme.onPrimary,
                disabledBackgroundColor: colorScheme.onPrimaryContainer,
                shape: const RoundedRectangleBorder(
                  borderRadius: CustomRadius.medium,
                ),
              ),
              child: state.isSubmitting
                  ? const SizedBox(
                      width: 14,
                      height: 14,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Text(LocaleKeys.memories_composePublish.tr()),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Eyebrow(LocaleKeys.memories_heroEyebrow.tr()),
          const EmptyBox.smallHeight(),
          Text(
            LocaleKeys.memories_heroTitle.tr(),
            style: V2Typography.display(
              fontSize: 28,
              color: colorScheme.onSurface,
            ),
          ),
          const EmptyBox.middleHeight(),
          _MemoryComposeField(
            label: LocaleKeys.memories_composeTitle.tr(),
            controller: _titleCtrl,
          ),
          _MemoryComposeField(
            label: LocaleKeys.compose_memoryYearLabel.tr(),
            controller: _yearCtrl,
            keyboardType: TextInputType.number,
          ),
          _MemoryComposeField(
            label: LocaleKeys.compose_memoryEraLabel.tr(),
            controller: _eraCtrl,
          ),
          _MemoryComposeField(
            label: LocaleKeys.compose_memoryNeighborhoodLabel.tr(),
            controller: _neighborhoodCtrl,
          ),
          _MemoryComposeField(
            label: LocaleKeys.compose_placeholder.tr(),
            controller: _textCtrl,
            maxLines: 6,
          ),
          const EmptyBox.middleHeight(),
          _MemoryComposePhotos(
            photos: state.photos,
            onAdd: _addPhoto,
            onRemove: (i) => ref
                .read(memoryComposeViewModelProvider.notifier)
                .removePhoto(i),
          ),
        ],
      ),
    );
  }

  Future<void> _addPhoto() async {
    final manager = PhotoPickerManager(context: context);
    final file = await manager.pickPhoto(type: PhotoPickType.gallery);
    if (file == null) return;
    ref.read(memoryComposeViewModelProvider.notifier).addPhoto(file);
  }

  Future<void> _onSubmit() async {
    final id = await ref.read(memoryComposeViewModelProvider.notifier).submit();
    if (!mounted) return;
    final colorScheme = context.general.colorScheme;
    if (id != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: colorScheme.primaryContainer,
          content: Text(LocaleKeys.compose_submitOk.tr()),
        ),
      );
      Navigator.of(context).maybePop();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: colorScheme.error,
          content: Text(
            ref.read(memoryComposeViewModelProvider).errorMessage ??
                LocaleKeys.compose_submitErr.tr(),
          ),
        ),
      );
    }
  }
}
