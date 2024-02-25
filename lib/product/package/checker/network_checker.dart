import 'package:connectivity_plus/connectivity_plus.dart';

final class NetworkChecker {
  NetworkChecker._init();

  static Future<bool> checkConnection() async {
    final connectionResult = await Connectivity().checkConnectivity();
    return connectionResult != ConnectivityResult.none;
  }
}
