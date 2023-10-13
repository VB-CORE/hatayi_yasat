import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:vbaseproject/features/request/scholarship/model/request_scholarship_model.dart';

@immutable
final class RequestScholarshipState extends Equatable {
  const RequestScholarshipState({
    this.requestScholarshipModel,
    this.isPolicyChecked = false,
    this.isLoading = false,
  });

  final RequestScholarshipModel? requestScholarshipModel;
  final bool isPolicyChecked;
  final bool isLoading;

  @override
  List<Object?> get props => [
        requestScholarshipModel,
        isPolicyChecked,
        isLoading,
      ];

  RequestScholarshipState copyWith({
    RequestScholarshipModel? requestScholarshipModel,
    bool? isPolicyChecked,
    bool? isLoading,
  }) {
    return RequestScholarshipState(
      requestScholarshipModel:
          requestScholarshipModel ?? this.requestScholarshipModel,
      isPolicyChecked: isPolicyChecked ?? this.isPolicyChecked,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
