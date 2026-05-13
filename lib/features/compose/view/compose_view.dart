import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart' show ContextExtension;
import 'package:lifeclient/features/compose/provider/compose_state.dart';
import 'package:lifeclient/features/compose/provider/compose_view_model.dart';
import 'package:lifeclient/product/init/application_theme.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/model/social/sample_social_data.dart';
import 'package:lifeclient/product/package/photo_picker/photo_picker_manager.dart';
import 'package:lifeclient/product/utility/decorations/custom_radius.dart';
import 'package:lifeclient/product/utility/decorations/empty_box.dart';
import 'package:lifeclient/product/widget/circle_avatar/v2_avatar.dart';
import 'package:lifeclient/product/widget/snackbar/v2_post_submitted_toast.dart';

part 'widget/_compose_kind_segment.dart';
part 'widget/_compose_photo_strip.dart';
part 'widget/_compose_place_picker_button.dart';
part 'widget/_compose_place_picker_sheet.dart';
part 'widget/_compose_submit_bar.dart';
part 'widget/_compose_text_field.dart';

/// V2 compose flow — text + optional place tag + optional photos. On
/// submit, calls [ComposeViewModel.submit] which writes to Firestore
/// (`posts/`) and uploads photos to Storage. Memory mode writes to
/// `memories/` instead.
final class ComposeView extends ConsumerStatefulWidget {
  const ComposeView({
    super.key,
    this.initialKind = ComposeKind.post,
  });

  final ComposeKind initialKind;

  @override
  ConsumerState<ComposeView> createState() => _ComposeViewState();
}

class _ComposeViewState extends ConsumerState<ComposeView> {
  late final TextEditingController _controller;
  late final ComposeViewModelProvider _vmProvider;
  static const _maxLength = 500;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _vmProvider = composeViewModelProvider(initialKind: widget.initialKind);
    _controller.addListener(() {
      ref.read(_vmProvider.notifier).setText(_controller.text);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(_vmProvider);
    final me = V2SampleData.me;
    final colorScheme = context.general.colorScheme;
    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        backgroundColor: colorScheme.secondary,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.of(context).maybePop(),
          icon: Icon(Icons.close_rounded, color: colorScheme.primary),
        ),
        title: Text(
          LocaleKeys.compose_title.tr(),
          style: V2Typography.display(
            fontSize: 20,
            color: colorScheme.primary,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: _ComposeSubmitButton(
              canSubmit: state.canSubmit,
              isSubmitting: state.isSubmitting,
              onSubmit: _onSubmit,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            color: colorScheme.secondary,
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
            child: _ComposeKindSegment(
              kind: state.kind,
              onChanged: (v) => ref.read(_vmProvider.notifier).setKind(v),
            ),
          ),
          Divider(height: 1, color: colorScheme.onPrimaryContainer),
          Expanded(
            child: Container(
              color: colorScheme.secondary,
              padding: const EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  V2Avatar(user: me),
                  const EmptyBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _ComposeTextField(
                          controller: _controller,
                          maxLength: _maxLength,
                        ),
                        if (state.selectedPlace != null) ...[
                          const EmptyBox.smallHeight(),
                          _ComposePlacePickerButton(
                            place: state.selectedPlace,
                            onClear: () =>
                                ref.read(_vmProvider.notifier).clearPlace(),
                          ),
                        ],
                        if (state.photos.isNotEmpty) ...[
                          const SizedBox(height: 12),
                          _ComposePhotoStrip(
                            photos: state.photos,
                            onRemove: (i) =>
                                ref.read(_vmProvider.notifier).removePhoto(i),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          _ComposeToolbar(
            controller: _controller,
            maxLength: _maxLength,
            onPickPhoto: _pickPhoto,
            onPickPlace: _pickPlace,
          ),
        ],
      ),
    );
  }

  Future<void> _pickPhoto() async {
    final manager = PhotoPickerManager(context: context);
    final file = await manager.pickPhoto(type: PhotoPickType.gallery);
    if (file == null) return;
    ref.read(_vmProvider.notifier).addPhoto(file);
  }

  Future<void> _pickPlace() async {
    if (!mounted) return;
    final colorScheme = context.general.colorScheme;
    final picked = await showModalBottomSheet<ComposePlaceTag>(
      context: context,
      isScrollControlled: true,
      backgroundColor: colorScheme.secondary,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => const _ComposePlacePickerSheet(),
    );
    if (picked == null || !mounted) return;
    ref.read(_vmProvider.notifier).pickPlace(picked);
  }

  Future<void> _onSubmit() async {
    final id = await ref.read(_vmProvider.notifier).submit();
    if (!mounted) return;
    if (id != null) {
      Navigator.of(context).maybePop();
      showV2PostSubmittedToast(context);
    } else {
      final err = ref.read(_vmProvider).errorMessage;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: context.general.colorScheme.error,
          content: Text(err ?? LocaleKeys.compose_submitErr.tr()),
        ),
      );
    }
  }
}
