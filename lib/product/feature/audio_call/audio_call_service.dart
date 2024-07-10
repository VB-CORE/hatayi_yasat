import 'package:lifeclient/product/feature/audio_call/agora_audio_call_service.dart';

abstract class AudioCallService {
  Future<void> initialize();
  Future<void> createChannel({
    required AgoraLocalUserJoinedCallback onLocalUserJoined,
    required AgoraRemoteUserJoinedCallback onRemoteUserJoined,
    required AgoraRemoteUserLeftCallback onRemoteUserLeft,
    required AgoraRemoteActiveUserCallback onRemoteActiveUser,
  });
  Future<void> joinChannel();
  Future<void> dispose();
}
