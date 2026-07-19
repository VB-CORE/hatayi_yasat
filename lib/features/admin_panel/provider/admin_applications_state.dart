import 'package:equatable/equatable.dart';
import 'package:lifeclient/features/admin_panel/model/merchant_application_model.dart';

final class AdminApplicationsState extends Equatable {
  const AdminApplicationsState({
    this.applications = const [],
    this.isFetching = false,
    this.isError = false,
    this.processingUid,
    this.actionMessageKey,
  });

  final List<MerchantApplicationModel> applications;
  final bool isFetching;
  final bool isError;
  final String? processingUid;
  final String? actionMessageKey;

  bool get isBusy => processingUid != null;

  AdminApplicationsState copyWith({
    List<MerchantApplicationModel>? applications,
    bool? isFetching,
    bool? isError,
    String? processingUid,
    String? actionMessageKey,
    bool clearProcessingUid = false,
    bool clearActionMessage = false,
  }) => AdminApplicationsState(
    applications: applications ?? this.applications,
    isFetching: isFetching ?? this.isFetching,
    isError: isError ?? this.isError,
    processingUid: clearProcessingUid
        ? null
        : (processingUid ?? this.processingUid),
    actionMessageKey: clearActionMessage
        ? null
        : (actionMessageKey ?? this.actionMessageKey),
  );

  @override
  List<Object?> get props => [
    applications,
    isFetching,
    isError,
    processingUid,
    actionMessageKey,
  ];
}
