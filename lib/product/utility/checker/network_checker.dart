import 'package:connectivity_plus/connectivity_plus.dart';

final class NetworkChecker {
  NetworkChecker._init();

  static Future<bool> checkConnection() async {
    final connectionResult = await Connectivity().checkConnectivity();
    if (connectionResult == ConnectivityResult.none) return false;
    return true;
  }
}
