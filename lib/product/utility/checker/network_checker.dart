import 'dart:io';

final class NetworkChecker {
  NetworkChecker._init();

  static Future<bool> tryToConnect() async {
    try {
      final connectionResult = await InternetAddress.lookup('example.com');
      return connectionResult.isNotEmpty &&
          connectionResult[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }
}
