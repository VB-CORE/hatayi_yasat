import 'package:lifeclient/features/admin_panel/model/merchant_application_model.dart';
import 'package:lifeclient/product/model/auth/app_user.dart';

abstract interface class AdminPanelService {
  Future<List<AppUser>> fetchUsers({int limit, String? startAfterUid});
  Future<bool> updateUserPermissions(AppUser user);
  Future<List<MerchantApplicationModel>> fetchPendingApplications();
  Future<bool> approveApplication(String uid);
  Future<bool> rejectApplication(String uid);
}
