import 'package:equatable/equatable.dart';

sealed class ContentActionStatus extends Equatable {
  const ContentActionStatus();
}

final class ContentActionIdle extends ContentActionStatus {
  const ContentActionIdle();
  @override
  List<Object?> get props => [];
}

final class ContentActionProcessing extends ContentActionStatus {
  const ContentActionProcessing();
  @override
  List<Object?> get props => [];
}

final class ContentActionSucceeded extends ContentActionStatus {
  const ContentActionSucceeded(this.messageKey);
  final String messageKey;
  @override
  List<Object?> get props => [messageKey];
}

final class ContentActionFailed extends ContentActionStatus {
  const ContentActionFailed(this.messageKey);
  final String messageKey;
  @override
  List<Object?> get props => [messageKey];
}
