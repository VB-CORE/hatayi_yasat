import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:vbaseproject/product/model/request_project_model.dart';

@immutable
final class ProjectRequestState extends Equatable {
  const ProjectRequestState({
    this.isSendingRequest,
    this.requestProjectModel,
    this.isServiceError,
  });

  final RequestProjectModel? requestProjectModel;
  final bool? isSendingRequest;
  final bool? isServiceError;

  @override
  List<Object?> get props =>
      [requestProjectModel, isSendingRequest, isServiceError];

  ProjectRequestState copyWith({
    RequestProjectModel? requestProjectModel,
    bool? isSendingRequest,
    bool? isServiceError,
  }) {
    return ProjectRequestState(
      requestProjectModel: requestProjectModel ?? this.requestProjectModel,
      isSendingRequest: isSendingRequest ?? this.isSendingRequest,
      isServiceError: isServiceError ?? this.isServiceError,
    );
  }
}
