import 'package:lifeclient/features/admin_panel/service/admin_panel_mock_service.dart';
import 'package:lifeclient/features/admin_panel/service/admin_panel_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'admin_panel_service_provider.g.dart';

@riverpod
AdminPanelService adminPanelService(Ref ref) => AdminPanelMockService();
