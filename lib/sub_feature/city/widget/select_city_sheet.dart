import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/utility/constants/index.dart';
import 'package:lifeclient/product/utility/decorations/custom_radius.dart';
import 'package:lifeclient/product/widget/spacer/dynamic_vertical_spacer.dart';

final class SelectCitySheet extends StatelessWidget {
  const SelectCitySheet({
    required this.cities,
    required this.selectedCity,
    super.key,
  });

  final List<StoreCityModel> cities;
  final String selectedCity;

  static Future<StoreCityModel?> show(
    BuildContext context, {
    required List<StoreCityModel> cities,
    required String selectedCity,
  }) async {
    return showModalBottomSheet<StoreCityModel?>(
      context: context,
      builder: (context) {
        return SelectCitySheet(
          cities: cities,
          selectedCity: selectedCity,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const PagePadding.generalAllNormal(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            LocaleKeys.city_citySelectionTitle.tr(),
            style: context.general.textTheme.headlineSmall,
          ),
          const VerticalSpace.standard(),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: cities.length,
            itemBuilder: (context, index) {
              final city = cities[index];
              return _CityTile(
                selectedCity: selectedCity,
                city: city,
              );
            },
          ),
          const VerticalSpace.xxSmall(),
        ],
      ),
    );
  }
}

final class _CityTile extends StatelessWidget {
  const _CityTile({
    required this.selectedCity,
    required this.city,
  });

  final String selectedCity;
  final StoreCityModel city;

  @override
  Widget build(BuildContext context) {
    final isSelected = city.name == selectedCity;
    return ListTile(
      onTap: () => context.route.pop(city),
      shape: const RoundedRectangleBorder(
        borderRadius: CustomRadius.medium,
      ),
      title: Text(
        city.name,
        style: context.general.textTheme.titleLarge?.copyWith(
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          color: isSelected ? Colors.green : Colors.black,
        ),
      ),
      subtitle: Text(
        isSelected
            ? LocaleKeys.city_selectedCitySubtitle.tr(args: [selectedCity])
            : LocaleKeys.city_unselectedCitySubtitle.tr(args: [city.name]),
      ),
      trailing: isSelected
          ? const Icon(AppIcons.checkCircle, color: Colors.green)
          : null,
    );
  }
}
