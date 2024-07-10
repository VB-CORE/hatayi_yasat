import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:lifeclient/product/feature/audio_call/agora_audio_call_service.dart';
import 'package:lifeclient/product/feature/audio_call/audio_call_service.dart';
import 'package:lifeclient/product/utility/decorations/empty_box.dart';
import 'package:lifeclient/product/widget/general/index.dart';

final class AudioCallView extends StatefulWidget {
  const AudioCallView({super.key});

  @override
  State<AudioCallView> createState() => _AudioCallViewState();
}

final class _AudioCallViewState extends State<AudioCallView> {
  late final AudioCallService _audioCallService;
  final ValueNotifier<int> _hostUserNotifier = ValueNotifier(0);
  final ValueNotifier<int> _activeUserNotifier = ValueNotifier(0);
  final ValueNotifier<List<int>> _userListNotifier = ValueNotifier([]);

  @override
  void initState() {
    super.initState();
    _audioCallService = AgoraAudioCallService(
      appId: '*',
      token: '*',
      channel: '*',
    );
    _audioCallInitialize();
  }

  @override
  void dispose() {
    _audioCallService.dispose();
    super.dispose();
  }

  Future<void> _audioCallInitialize() async {
    await _audioCallService.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return GeneralScaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            const EmptyBox.largeHeight(),
            ValueListenableBuilder(
              valueListenable: _hostUserNotifier,
              builder: (context, int value, child) {
                return Text('Host User: $value');
              },
            ),
            const EmptyBox.middleHeight(),
            const Text('User List: '),
            const EmptyBox.middleHeight(),
            Expanded(
              child: ValueListenableBuilder<List<int>>(
                valueListenable: _userListNotifier,
                builder: (context, List<int> value, child) {
                  return ListView.builder(
                    itemCount: value.length,
                    itemBuilder: (context, index) {
                      return Text(
                        'User: ${value[index]}',
                        textAlign: TextAlign.center,
                        style:
                            context.general.textTheme.headlineSmall?.copyWith(
                          fontWeight: value[index] == _activeUserNotifier.value
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                _audioCallService.createChannel(
                  onLocalUserJoined: (int uid) {
                    _hostUserNotifier.value = uid;
                    print('Local user joined with uid: $uid');
                  },
                  onRemoteUserJoined: (int uid) {
                    final currentItems = _userListNotifier.value.toList();
                    if (currentItems.contains(uid)) return;
                    currentItems.add(uid);
                    _userListNotifier.value = currentItems;
                    print('Remote user joined with uid: $uid');
                  },
                  onRemoteUserLeft: (int uid, UserOfflineReasonType reason) {
                    final currentItems = _userListNotifier.value.toList();
                    if (!currentItems.contains(uid)) return;
                    currentItems.remove(uid);
                    _userListNotifier.value = currentItems;
                    print(
                      'Remote user left with uid: $uid and reason: $reason',
                    );
                  },
                  onRemoteActiveUser: (int uid) {
                    _activeUserNotifier.value = uid;
                  },
                );
              },
              child: const Text('Create Channel'),
            ),
            ElevatedButton(
              onPressed: () async {
                await _audioCallService.joinChannel();
              },
              child: const Text('Join Channel'),
            ),
            const EmptyBox.largeHeight(),
          ],
        ),
      ),
    );
  }
}
