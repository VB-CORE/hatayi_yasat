import 'package:equatable/equatable.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';

enum MerchantApplicationStatus {
  pending,
  approved,
  rejected
  ;

  String get labelKey => switch (this) {
    MerchantApplicationStatus.pending => LocaleKeys.admin_statusPending,
    MerchantApplicationStatus.approved => LocaleKeys.admin_statusApproved,
    MerchantApplicationStatus.rejected => LocaleKeys.admin_statusRejected,
  };
}

final class MerchantApplicationModel extends Equatable {
  const MerchantApplicationModel({
    required this.uid,
    required this.businessName,
    required this.applicantName,
    required this.createdAt,
    this.status = MerchantApplicationStatus.pending,
  });

  final String uid;
  final String businessName;
  final String applicantName;
  final DateTime createdAt;
  final MerchantApplicationStatus status;

  @override
  List<Object?> get props => [
    uid,
    businessName,
    applicantName,
    createdAt,
    status,
  ];

  MerchantApplicationModel copyWith({
    String? uid,
    String? businessName,
    String? applicantName,
    DateTime? createdAt,
    MerchantApplicationStatus? status,
  }) => MerchantApplicationModel(
    uid: uid ?? this.uid,
    businessName: businessName ?? this.businessName,
    applicantName: applicantName ?? this.applicantName,
    createdAt: createdAt ?? this.createdAt,
    status: status ?? this.status,
  );
}
