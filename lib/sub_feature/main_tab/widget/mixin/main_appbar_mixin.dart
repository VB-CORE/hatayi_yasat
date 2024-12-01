import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/product/widget/dialog/changing_dialog.dart';
import 'package:lifeclient/sub_feature/city/provider/city_state.dart';
import 'package:lifeclient/sub_feature/city/provider/city_view_model.dart';
import 'package:lifeclient/sub_feature/city/widget/select_city_sheet.dart';

mixin MainAppBarMixin<T extends ConsumerStatefulWidget> on ConsumerState<T> {
  /// Holds the reference to the CityViewModel notifier.
  late final CityViewModel cityViewModel;

  /// Provides the current state of the CityViewModel.
  CityState get cityState => ref.watch(cityViewModelProvider);

  @override
  void initState() {
    super.initState();
    cityViewModel = ref.read(cityViewModelProvider.notifier);
    Future.microtask(_fetchCities);
  }

  /// Fetches the list of cities from the CityViewModel.
  Future<void> _fetchCities() async {
    await cityViewModel.fetchCities();
  }

  /// Handles the city selection process:
  /// - Displays a selection sheet to the user.
  /// - Shows a dialog indicating a change is in progress.
  /// - Updates the selected city in the view model.
  Future<void> handleCitySelection(BuildContext context) async {
    final cityState = ref.read(cityViewModelProvider);
    final cityList = cityState.cityList;

    if (cityList != null) {
      final selectedItem = await SelectCitySheet.show(
        context,
        cities: cityList,
        selectedCity: cityState.selectedCity,
      );
      if (selectedItem != null) {
        await _showChangingDialog();
        _changeSelectedCity(cityList, selectedItem);
        if (context.mounted) Navigator.of(context).pop();
      }
    }
  }

  /// Displays a dialog to inform the user that a change is in progress
  /// and waits for a predefined delay.
  Future<void> _showChangingDialog() async {
    if (context.mounted) unawaited(ChangingDialog.show(context));
    await Future<void>.delayed(Durations.long2);
  }

  /// Updates the selected city in the view model based on the user's selection.
  void _changeSelectedCity(
    List<StoreCityModel> cityList,
    StoreCityModel selectedCity,
  ) {
    cityViewModel.changeSelectedCity(
      cityList.firstWhere((city) => city.name == selectedCity.name).name,
    );
  }
}
