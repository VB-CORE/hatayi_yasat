import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:lifeclient/core/service/microphone_permission_service.dart';
import 'package:lifeclient/product/feature/audio_call/audio_call_service.dart';

typedef AgoraLocalUserJoinedCallback = void Function(int uid);
typedef AgoraRemoteUserJoinedCallback = void Function(int uid);
typedef AgoraRemoteActiveUserCallback = void Function(int uid);
typedef AgoraRemoteUserLeftCallback = void Function(
  int uid,
  UserOfflineReasonType reason,
);

final class AgoraAudioCallService extends AudioCallService {
  AgoraAudioCallService({
    required String appId,
    required String token,
    required String channel,
  })  : _appId = appId,
        _token = token,
        _channel = channel;

  final String _appId;
  final String _token;
  final String _channel;

  late final RtcEngine _rtcEngine;

  @override
  Future<void> initialize() async {
    final permission = await MicrophonePermissionService().ensurePermission();
    if (!permission) {
      throw Exception('Microphone permission is not granted');
    }
    _rtcEngine = createAgoraRtcEngine();
    final context = RtcEngineContext(
      appId: _appId,
      channelProfile: ChannelProfileType.channelProfileCommunication,
    );
    await _rtcEngine.initialize(context);
  }

  @override
  Future<void> createChannel({
    required AgoraRemoteUserLeftCallback onRemoteUserLeft,
    required AgoraRemoteUserJoinedCallback onRemoteUserJoined,
    required AgoraLocalUserJoinedCallback onLocalUserJoined,
    required AgoraRemoteActiveUserCallback onRemoteActiveUser,
  }) async {
    _rtcEngine.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (connection, elapsed) {
          final uid = connection.localUid;
          if (uid == null) return;
          onLocalUserJoined(uid);
        },
        onUserJoined: (connection, remoteUid, elapsed) {
          onRemoteUserJoined(remoteUid);
        },
        onUserOffline: (connection, remoteUid, reason) {
          onRemoteUserLeft(remoteUid, reason);
        },
        onActiveSpeaker: (connection, uid) {
          onRemoteActiveUser(uid);
        },
      ),
    );

    await _rtcEngine.joinChannel(
      token: _token,
      channelId: _channel,
      options: const ChannelMediaOptions(
        clientRoleType: ClientRoleType.clientRoleBroadcaster,
      ),
      uid: 0,
    );
  }

  @override
  Future<void> joinChannel() async {
    await _rtcEngine.joinChannel(
      token: _token,
      channelId: _channel,
      options: const ChannelMediaOptions(
        // if clientRoleType is set to audience, the user will not be able to speak
        clientRoleType: ClientRoleType.clientRoleBroadcaster,
      ),
      uid: 0,
    );
  }

  @override
  Future<void> dispose() async {
    await _rtcEngine.leaveChannel(); // Leave the channel
    await _rtcEngine.release(); // Release resources
  }
}
