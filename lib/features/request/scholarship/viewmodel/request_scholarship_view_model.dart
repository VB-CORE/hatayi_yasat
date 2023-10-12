import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vbaseproject/features/request/scholarship/request_scholarship_state.dart';

class RequestScholarshipViewModel
    extends StateNotifier<RequestScholarshipState> {
  RequestScholarshipViewModel() : super(const RequestScholarshipState());
}
