import 'package:kartal/kartal.dart';
import 'package:url_launcher/url_launcher.dart';

final class UriUtility {
  UriUtility({
    required this.address,
  });

  static const _httpScheme = 'http://';
  static const _httpsScheme = 'https://';

  final String address;

  Uri get toUri {
    if (_containsScheme) {
      return Uri.parse(address);
    } else {
      return Uri.parse('$_httpsScheme$address');
    }
  }

  bool get _containsScheme {
    return address.contains(_httpScheme) || address.contains(_httpsScheme);
  }

  Future<void> launch() async {
    try {
      await launchUrl(toUri);
    } on Object catch (e) {
      CustomLogger.showError<dynamic>(e);
    }
  }
}
