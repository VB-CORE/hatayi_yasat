import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:vbaseproject/product/init/firebase_custom_service.dart';
import 'package:vbaseproject/product/utility/state/app_provider.dart';
import 'package:vbaseproject/product/utility/state/items/app_provider_state.dart';

mixin ProjectDepedendencyMixin {
  final FirebaseCustomService firebaseService =
      GetIt.I.get<FirebaseCustomService>();

  final AppProvider appProvider = GetIt.I.get<AppProvider>();
  final StateNotifierProvider<AppProvider, AppProviderState> appProviderState =
      GetIt.I.get<StateNotifierProvider<AppProvider, AppProviderState>>();
}
