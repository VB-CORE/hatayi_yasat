import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:lifeclient/product/model/request_scholarship_model.dart';

@immutable
final class ScholarshipRequestState extends Equatable {
  const ScholarshipRequestState({
    this.scholarshipModel,
    this.isSendingRequest,
    this.canApply,
  });

  final RequestScholarshipModel? scholarshipModel;
  final bool? isSendingRequest;
  final bool? canApply;

  @override
  List<Object?> get props => [
        scholarshipModel,
        isSendingRequest,
        canApply,
      ];

  ScholarshipRequestState copyWith({
    RequestScholarshipModel? scholarshipModel,
    bool? isSendingRequest,
    bool? canApply,
  }) {
    return ScholarshipRequestState(
      scholarshipModel: scholarshipModel ?? this.scholarshipModel,
      isSendingRequest: isSendingRequest ?? this.isSendingRequest,
      canApply: canApply ?? this.canApply,
    );
  }
}
