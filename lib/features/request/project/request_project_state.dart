import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:vbaseproject/features/request/project/model/request_project_model.dart';

@immutable
final class RequestProjectState extends Equatable {
  const RequestProjectState({
    required this.isSendingRequest,
    this.requestProjectModel,
    this.isServiceError,
  });

  final RequestProjectModel? requestProjectModel;
  final bool isSendingRequest;
  final bool? isServiceError;

  @override
  List<Object?> get props =>
      [requestProjectModel, isSendingRequest, isServiceError];

  RequestProjectState copyWith({
    RequestProjectModel? requestProjectModel,
    bool? isSendingRequest,
    bool? isServiceError,
  }) {
    return RequestProjectState(
      requestProjectModel: requestProjectModel ?? this.requestProjectModel,
      isSendingRequest: isSendingRequest ?? this.isSendingRequest,
      isServiceError: isServiceError ?? this.isServiceError,
    );
  }
}
