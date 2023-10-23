import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:vbaseproject/product/init/language/locale_keys.g.dart';
import 'package:vbaseproject/product/model/enum/video_resource_path.dart';
import 'package:video_player/video_player.dart';

final class VideoDialog extends StatefulWidget {
  const VideoDialog({required this.path, super.key, this.closeTitle});
  final VideoResourcePath path;
  final String? closeTitle;

  static Future<void> show({
    required BuildContext context,
    required VideoResourcePath path,
  }) async {
    return showDialog<void>(
      context: context,
      builder: (context) {
        return VideoDialog(path: path);
      },
    );
  }

  @override
  State<VideoDialog> createState() => _VideoDialogState();
}

class _VideoDialogState extends State<VideoDialog> {
  late final VideoPlayerController _controller;
  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(
      widget.path.withAsset,
    );

    Future.microtask(() async {
      await _controller.initialize();
      setState(() {});
      await _controller.setLooping(true);
      await _controller.play();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      insetPadding: EdgeInsets.zero,
      actionsPadding: EdgeInsets.zero,
      content: SizedBox(
        child: _controller.value.isInitialized
            ? AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(
                  _controller,
                ),
              )
            : const Center(
                child: CircularProgressIndicator(),
              ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(widget.closeTitle ?? LocaleKeys.button_close.tr()),
        ),
      ],
    );
  }
}

extension VideoDialogRepublic on VideoDialog {
  static Future<void> show({
    required BuildContext context,
  }) async {
    return showDialog<void>(
      context: context,
      builder: (context) {
        return VideoDialog(
          path: VideoResourcePath.republic,
          closeTitle: LocaleKeys.message_republicDay.tr(),
        );
      },
    );
  }
}
