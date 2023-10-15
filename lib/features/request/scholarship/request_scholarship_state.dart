import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:vbaseproject/features/request/scholarship/model/request_scholarship_model.dart';

@immutable
final class RequestScholarshipState extends Equatable {
  const RequestScholarshipState({
    this.requestScholarshipModel,
    this.isPolicyChecked = false,
    this.isLoading = false,
    this.canApply = true,
  });

  final RequestScholarshipModel? requestScholarshipModel;
  final bool isPolicyChecked;
  final bool isLoading;
  final bool canApply;

  @override
  List<Object?> get props => [
        requestScholarshipModel,
        isPolicyChecked,
        isLoading,
        canApply,
      ];

  RequestScholarshipState copyWith({
    RequestScholarshipModel? requestScholarshipModel,
    bool? isPolicyChecked,
    bool? isLoading,
    bool? canApply,
  }) {
    return RequestScholarshipState(
      requestScholarshipModel:
          requestScholarshipModel ?? this.requestScholarshipModel,
      isPolicyChecked: isPolicyChecked ?? this.isPolicyChecked,
      isLoading: isLoading ?? this.isLoading,
      canApply: canApply ?? this.canApply,
    );
  }
}
