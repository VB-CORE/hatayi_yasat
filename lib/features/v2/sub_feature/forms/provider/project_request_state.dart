import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:vbaseproject/features/request/project/model/request_project_model.dart';

@immutable
final class ProjectRequestState extends Equatable {
  const ProjectRequestState({
    this.requestProjectModel,
  });
  final RequestProjectModel? requestProjectModel;
  @override
  List<Object?> get props => [requestProjectModel];

  ProjectRequestState copyWith({
    RequestProjectModel? requestProjectModel,
  }) {
    return ProjectRequestState(
      requestProjectModel: requestProjectModel ?? this.requestProjectModel,
    );
  }
}
