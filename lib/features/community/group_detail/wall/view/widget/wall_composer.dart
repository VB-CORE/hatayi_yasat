import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/features/community/group_detail/wall/view/mixin/wall_composer_mixin.dart';
import 'package:lifeclient/features/community/group_detail/wall/view/widget/group_post_composer.dart';
import 'package:lifeclient/product/utility/decorations/empty_box.dart';
import 'package:lifeclient/product/utility/mixin/app_provider_mixin.dart';

final class WallComposer extends ConsumerStatefulWidget {
  const WallComposer({required this.groupId, super.key});

  final String groupId;

  @override
  ConsumerState<WallComposer> createState() => _WallComposerState();
}

final class _WallComposerState extends ConsumerState<WallComposer>
    with AppProviderMixin<WallComposer>, WallComposerMixin {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const PagePadding.horizontal16Symmetric(),
      child: Column(
        children: [
          const EmptyBox.middleHeight(),
          GroupPostComposer(
            controller: postController,
            imageFile: postImageFile,
            onPickImage: pickPostImage,
            onRemoveImage: removePostImage,
            onSubmit: submitPost,
          ),
          const EmptyBox.middleHeight(),
        ],
      ),
    );
  }
}
