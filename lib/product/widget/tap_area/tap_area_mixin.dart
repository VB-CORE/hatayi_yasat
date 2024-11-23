part of 'tap_area.dart';

mixin TapAreaMixin on State<TapArea> {
  final ValueNotifier<bool> _isTappedNotifier = ValueNotifier<bool>(false);

  // ignore: use_setters_to_change_properties
  void updateClicked({required bool value}) {
    _isTappedNotifier.value = value;
  }

  @override
  void dispose() {
    _isTappedNotifier.dispose();
    super.dispose();
  }
}
