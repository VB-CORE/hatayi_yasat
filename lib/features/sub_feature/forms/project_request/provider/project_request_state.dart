import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:lifeclient/product/model/request_project_model.dart';

@immutable
final class ProjectRequestState extends Equatable {
  const ProjectRequestState({
    this.isSendingRequest,
    this.requestProjectModel,
  });

  final RequestProjectModel? requestProjectModel;
  final bool? isSendingRequest;

  @override
  List<Object?> get props => [requestProjectModel, isSendingRequest];

  ProjectRequestState copyWith({
    RequestProjectModel? requestProjectModel,
    bool? isSendingRequest,
  }) {
    return ProjectRequestState(
      requestProjectModel: requestProjectModel ?? this.requestProjectModel,
      isSendingRequest: isSendingRequest ?? this.isSendingRequest,
    );
  }
}
