part of '../settings_view.dart';

final class _ChooseLocationWidget extends ConsumerWidget {
  const _ChooseLocationWidget({required this.cities});

  final List<TownModel> cities;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCity = ref.watch(cityViewModelProvider);
    return GeneralExpansionTile(
      pageTitle: LocaleKeys.settings_locationSelection.tr(),
      children: [
        ...cities.map(
          (city) => RadioListTile.adaptive(
            value: city.displayName,
            groupValue: selectedCity,
            title: Text(
              city.displayName,
              style: context.general.textTheme.bodyLarge,
            ),
            onChanged: (String? newValue) async {
              if (newValue != null) {
                await _onCityChanged(context, newCity: newValue, ref: ref);
              }
            },
          ),
        ),
        const EmptyBox.middleHeight(),
      ],
    );
  }

  Future<void> _onCityChanged(
    BuildContext context, {
    required String newCity,
    required WidgetRef ref,
  }) async {
    unawaited(ChangingDialog.show(context));
    await Future<void>.delayed(Durations.long2);
    ref.read(cityViewModelProvider.notifier).city = newCity;
    if (context.mounted) Navigator.of(context).pop();
  }
}
