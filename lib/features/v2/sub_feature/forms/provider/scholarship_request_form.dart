import 'package:equatable/equatable.dart';
import 'package:vbaseproject/features/request/scholarship/model/request_scholarship_model.dart';

final class ScholarshipRequestState extends Equatable {
  const ScholarshipRequestState({
    this.scholarshipModel,
  });
  final RequestScholarshipModel? scholarshipModel;
  @override
  List<Object?> get props => [scholarshipModel];

  ScholarshipRequestState copyWith({
    RequestScholarshipModel? scholarshipModel,
  }) {
    return ScholarshipRequestState(
      scholarshipModel: scholarshipModel ?? this.scholarshipModel,
    );
  }
}
