part of '../settings_view.dart';

final class _ChooseLocationWidget extends ConsumerStatefulWidget {
  const _ChooseLocationWidget();

  @override
  ConsumerState<_ChooseLocationWidget> createState() =>
      _ChooseLocationWidgetState();
}

class _ChooseLocationWidgetState extends ConsumerState<_ChooseLocationWidget>
    with _ChooseLocationMixin {
  @override
  Widget build(BuildContext context) {
    if (cityState.cityList == null) return const SizedBox.shrink();
    return GeneralExpansionTile(
      pageTitle: LocaleKeys.settings_locationSelection.tr(),
      children: [
        ...cityState.cityList!.map(
          (city) => RadioListTile.adaptive(
            value: city.name,
            groupValue: cityState.selectedCity,
            title: Text(
              city.name,
              style: context.general.textTheme.bodyLarge,
            ),
            onChanged: (String? newValue) async {
              if (newValue != null) {
                await handleCityChanged(context, newCity: newValue);
              }
            },
          ),
        ),
        const EmptyBox.middleHeight(),
      ],
    );
  }
}

/// Mixin to handle city selection logic for the [_ChooseLocationWidget].
mixin _ChooseLocationMixin on ConsumerState<_ChooseLocationWidget> {
  late final CityViewModel cityViewModel;
  CityState get cityState => ref.watch(cityViewModelProvider);

  @override
  void initState() {
    super.initState();
    cityViewModel = ref.read(cityViewModelProvider.notifier);
    Future.microtask(_fetchCities);
  }

  /// Fetches the list of cities.
  Future<void> _fetchCities() async {
    await cityViewModel.fetchCities();
  }

  /// Handles the logic for city selection and updates the selected city.
  Future<void> handleCityChanged(
    BuildContext context, {
    required String newCity,
  }) async {
    unawaited(ChangingDialog.show(context));
    await Future<void>.delayed(Durations.long2);
    cityViewModel.setSelectedCity(newCity);
    if (context.mounted) Navigator.of(context).pop();
  }
}
