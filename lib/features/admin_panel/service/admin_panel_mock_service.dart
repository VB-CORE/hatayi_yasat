import 'package:flutter/foundation.dart';
import 'package:lifeclient/features/admin_panel/mock/admin_mock_data.dart';
import 'package:lifeclient/features/admin_panel/model/merchant_application_model.dart';
import 'package:lifeclient/features/admin_panel/service/admin_panel_service.dart';
import 'package:lifeclient/product/model/auth/app_user.dart';
import 'package:lifeclient/product/model/auth/user_role.dart';

final class AdminPanelMockService implements AdminPanelService {
  static const int _pageSize = 20;
  static const Duration _latency = Duration(milliseconds: 400);

  static final List<AppUser> _users = AdminMockData.buildUsers();
  static final List<MerchantApplicationModel> _applications =
      AdminMockData.buildApplications();

  @visibleForTesting
  static void reset() {
    _users
      ..clear()
      ..addAll(AdminMockData.buildUsers());
    _applications
      ..clear()
      ..addAll(AdminMockData.buildApplications());
  }

  @override
  Future<List<AppUser>> fetchUsers({
    int limit = _pageSize,
    String? startAfterUid,
  }) async {
    await Future<void>.delayed(_latency);
    var start = 0;
    if (startAfterUid != null) {
      final cursorIndex = _users.indexWhere(
        (user) => user.uid == startAfterUid,
      );
      if (cursorIndex == -1) return [];
      start = cursorIndex + 1;
    }
    return _users.skip(start).take(limit).toList();
  }

  @override
  Future<bool> updateUserPermissions(AppUser user) async {
    await Future<void>.delayed(_latency);
    final index = _users.indexWhere((item) => item.uid == user.uid);
    if (index == -1) return false;
    _users[index] = user;
    return true;
  }

  @override
  Future<List<MerchantApplicationModel>> fetchPendingApplications() async {
    await Future<void>.delayed(_latency);
    return _applications
        .where(
          (application) =>
              application.status == MerchantApplicationStatus.pending,
        )
        .toList();
  }

  @override
  Future<bool> approveApplication(String uid) async {
    await Future<void>.delayed(_latency);
    final index = _applications.indexWhere(
      (application) => application.uid == uid,
    );
    if (index == -1) return false;
    _applications[index] = _applications[index].copyWith(
      status: MerchantApplicationStatus.approved,
    );
    final userIndex = _users.indexWhere((user) => user.uid == uid);
    if (userIndex != -1) {
      _users[userIndex] = _users[userIndex].copyWith(role: UserRole.merchant);
    }
    return true;
  }

  @override
  Future<bool> rejectApplication(String uid) async {
    await Future<void>.delayed(_latency);
    final index = _applications.indexWhere(
      (application) => application.uid == uid,
    );
    if (index == -1) return false;
    _applications[index] = _applications[index].copyWith(
      status: MerchantApplicationStatus.rejected,
    );
    return true;
  }
}
