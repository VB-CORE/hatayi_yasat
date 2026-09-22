import 'package:lifeclient/product/init/error_handler/error_handler_binder.dart';

final class PlatformErrorHandlerBinder implements ErrorHandlerBinder {
  const PlatformErrorHandlerBinder();

  /// Web error channel is tracked in WEB-35 (#516).
  @override
  void bind() {}
}
