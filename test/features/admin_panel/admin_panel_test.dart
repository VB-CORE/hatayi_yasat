import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lifeclient/core/dependency/project_dependency.dart';
import 'package:lifeclient/features/admin_panel/model/merchant_application_model.dart';
import 'package:lifeclient/features/admin_panel/provider/admin_applications_view_model.dart';
import 'package:lifeclient/features/admin_panel/provider/admin_panel_service_provider.dart';
import 'package:lifeclient/features/admin_panel/model/admin_permission.dart';
import 'package:lifeclient/features/admin_panel/provider/admin_users_state.dart';
import 'package:lifeclient/features/admin_panel/provider/admin_users_view_model.dart';
import 'package:lifeclient/features/admin_panel/service/admin_panel_mock_service.dart';
import 'package:lifeclient/features/admin_panel/service/admin_panel_service.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/model/auth/app_user.dart';
import 'package:lifeclient/product/model/auth/user_role.dart';

final class _FailingAdminPanelService implements AdminPanelService {
  static const seedUser = AppUser(
    uid: 'user_01',
    email: 'user01@example.com',
    displayName: 'Mehmet Kaya',
  );

  @override
  Future<List<AppUser>> fetchUsers({
    int limit = 20,
    String? startAfterUid,
  }) async => startAfterUid == null ? [seedUser] : [];

  @override
  Future<bool> updateUserPermissions(AppUser user) async => false;

  @override
  Future<List<MerchantApplicationModel>> fetchPendingApplications() async => [];

  @override
  Future<bool> approveApplication(String uid) async => false;

  @override
  Future<bool> rejectApplication(String uid) async => false;
}

final class _ThrowingAdminPanelService implements AdminPanelService {
  @override
  Future<List<AppUser>> fetchUsers({
    int limit = 20,
    String? startAfterUid,
  }) async => throw Exception('service unavailable');

  @override
  Future<bool> updateUserPermissions(AppUser user) async => false;

  @override
  Future<List<MerchantApplicationModel>> fetchPendingApplications() async =>
      throw Exception('service unavailable');

  @override
  Future<bool> approveApplication(String uid) async => false;

  @override
  Future<bool> rejectApplication(String uid) async => false;
}

void main() {
  setUpAll(ProjectDependency.setup);

  group('AdminUsersState', () {
    const state = AdminUsersState(
      users: [_FailingAdminPanelService.seedUser],
      actionMessageKey: LocaleKeys.admin_permissionUpdateFailed,
    );

    test('copyWith without arguments keeps every field', () {
      expect(state.copyWith(), state);
    });

    test('copyWith clears the action message only when asked', () {
      expect(state.copyWith(isFetching: true).actionMessageKey, isNotNull);
      expect(state.copyWith(clearActionMessage: true).actionMessageKey, isNull);
    });
  });

  group('AdminPermission', () {
    test('toggle flips only the matching permission', () {
      final issueToggled = AdminPermission.createIssue.toggle(
        _FailingAdminPanelService.seedUser,
      );
      expect(issueToggled.canCreateIssue, isTrue);
      expect(issueToggled.canCreateGroup, isFalse);
      final groupToggled = AdminPermission.createGroup.toggle(
        _FailingAdminPanelService.seedUser,
      );
      expect(groupToggled.canCreateGroup, isTrue);
      expect(groupToggled.canCreateIssue, isFalse);
    });
  });

  group('AdminPanelMockService', () {
    late AdminPanelService service;

    setUp(() {
      AdminPanelMockService.reset();
      service = AdminPanelMockService();
    });

    test('pages users by cursor until the list runs out', () async {
      final first = await service.fetchUsers();
      final second = await service.fetchUsers(startAfterUid: first.last.uid);
      final third = await service.fetchUsers(startAfterUid: second.last.uid);
      expect(first, hasLength(20));
      expect(second.first.uid, 'user_21');
      expect(third, hasLength(8));
    });

    test('keeps permission updates visible to later fetches', () async {
      final updated = (await service.fetchUsers())[1].copyWith(
        canCreateIssue: true,
      );
      expect(await service.updateUserPermissions(updated), isTrue);
      expect((await service.fetchUsers())[1], updated);
    });

    test('approve grants the merchant role and rejects unknown uids', () async {
      expect(await service.approveApplication('user_07'), isTrue);
      final pending = await service.fetchPendingApplications();
      expect(pending.map((item) => item.uid), isNot(contains('user_07')));
      final users = await service.fetchUsers();
      expect(
        users.firstWhere((item) => item.uid == 'user_07').role,
        UserRole.merchant,
      );
      expect(await service.approveApplication('unknown'), isFalse);
    });

    test(
      'reject marks the application rejected and keeps the user role',
      () async {
        expect(await service.rejectApplication('user_12'), isTrue);
        final pending = await service.fetchPendingApplications();
        expect(pending.map((item) => item.uid), isNot(contains('user_12')));
        final users = await service.fetchUsers();
        expect(
          users.firstWhere((item) => item.uid == 'user_12').role,
          UserRole.user,
        );
        expect(await service.rejectApplication('unknown'), isFalse);
      },
    );
  });

  group('AdminUsersViewModel', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer(
        overrides: [
          adminPanelServiceProvider.overrideWithValue(
            _FailingAdminPanelService(),
          ),
        ],
        retry: (_, _) => null,
      );
      addTearDown(container.dispose);
      container.listen(adminUsersViewModelProvider, (_, _) {});
    });

    test('surfaces a load failure as the error state', () async {
      final failing = ProviderContainer(
        overrides: [
          adminPanelServiceProvider.overrideWithValue(
            _ThrowingAdminPanelService(),
          ),
        ],
        retry: (_, _) => null,
      );
      addTearDown(failing.dispose);
      failing.listen(adminUsersViewModelProvider, (_, _) {});
      await Future<void>.delayed(Duration.zero);
      final state = failing.read(adminUsersViewModelProvider);
      expect(state.isError, isTrue);
      expect(state.isFetching, isFalse);
    });

    test('rolls the toggle back when the service rejects the update', () async {
      await Future<void>.delayed(Duration.zero);
      expect(container.read(adminUsersViewModelProvider).users, hasLength(1));
      await container
          .read(adminUsersViewModelProvider.notifier)
          .togglePermission(
            uid: 'user_01',
            permission: AdminPermission.createIssue,
          );
      final state = container.read(adminUsersViewModelProvider);
      expect(state.users.single.canCreateIssue, isFalse);
      expect(state.actionMessageKey, LocaleKeys.admin_permissionUpdateFailed);
    });
  });

  group('AdminApplicationsViewModel', () {
    late ProviderContainer container;

    setUp(() {
      AdminPanelMockService.reset();
      container = ProviderContainer(retry: (_, _) => null);
      addTearDown(container.dispose);
      container.listen(adminApplicationsViewModelProvider, (_, _) {});
    });

    test('approve marks the pending application as approved', () async {
      while (container.read(adminApplicationsViewModelProvider).isFetching) {
        await Future<void>.delayed(const Duration(milliseconds: 50));
      }
      await container
          .read(adminApplicationsViewModelProvider.notifier)
          .approve('user_19');
      final state = container.read(adminApplicationsViewModelProvider);
      expect(
        state.applications.firstWhere((item) => item.uid == 'user_19').status,
        MerchantApplicationStatus.approved,
      );
      expect(state.actionMessageKey, LocaleKeys.admin_approveSuccess);
    });
  });
}
