import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import 'package:vbaseproject/features/request/company/modal/request_company_modal.dart';

@immutable
class RequestCompanyState extends Equatable {
  const RequestCompanyState({
    this.requestCompanyModel,
    this.isSendingRequest,
    this.isServiceError,
  });

  final RequestCompanyModel? requestCompanyModel;
  final bool? isSendingRequest;
  final bool? isServiceError;

  @override
  List<Object?> get props =>
      [requestCompanyModel, isSendingRequest, isServiceError];

  RequestCompanyState copyWith({
    RequestCompanyModel? requestCompanyModel,
    bool? isSendingRequest,
    bool? isServiceError,
  }) {
    return RequestCompanyState(
      requestCompanyModel: requestCompanyModel ?? this.requestCompanyModel,
      isSendingRequest: isSendingRequest ?? this.isSendingRequest,
      isServiceError: isServiceError ?? this.isServiceError,
    );
  }
}
