import 'package:flutter/material.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/dependency/project_dependency_items.dart';
import 'package:lifeclient/product/model/regional_city_model.dart';

/// City DropDown for regional Hatay,Mersin
final class RegionalCitySheet extends StatefulWidget {
  const RegionalCitySheet({
    super.key,
  });

  static Future<RegionalCityModel?> show(
    BuildContext context,
  ) async {
    final result = await showModalBottomSheet<RegionalCityModel>(
      context: context,
      builder: (context) => const RegionalCitySheet(),
    );
    return result;
  }

  @override
  State<RegionalCitySheet> createState() => _RegionalCitySheetState();
}

class _RegionalCitySheetState extends State<RegionalCitySheet>
    with _RegionalCitySheetMixin {
  @override
  Widget build(BuildContext context) {
    if (_cities.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.close),
          ),
        ),
        ListView.separated(
          itemCount: _cities.length,
          padding: const PagePadding.horizontalSymmetric() +
              const PagePadding.onlyBottom(),
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return CheckboxListTile(
              value: _cities[index].documentId == _selectedCity.documentId,
              title: Text(_cities[index].name),
              onChanged: (value) {
                if (value == null) return;
                _updateSelectedCity(_cities[index]);
              },
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return const Divider();
          },
        ),
        SafeArea(
          child: ElevatedButton(
            onPressed: _selectedCityId == _initialCityId
                ? null
                : () {
                    Navigator.pop(context, _selectedCity);
                  },
            child: Text('${_selectedCity.name} için mekanları göster'),
          ),
        ),
      ],
    );
  }
}

mixin _RegionalCitySheetMixin on State<RegionalCitySheet> {
  late final String _initialCityId;
  late final List<RegionalCityModel> _cities;

  late RegionalCityModel _selectedCity;
  late String _selectedCityId;

  void _updateSelectedCity(RegionalCityModel value) {
    setState(() {
      _selectedCityId = value.documentId;
      _selectedCity = value;
    });
  }

  @override
  void initState() {
    super.initState();
    _cities = ProjectDependencyItems.productProvider.regionalCities;
    _initialCityId =
        ProjectDependencyItems.productProvider.selectedCity.documentId;
    _selectedCityId = _initialCityId;
    _changeRelationalCity();
  }

  Future<void> _changeRelationalCity() async {
    final selectedCity = _cities.firstWhere(
      (element) => element.documentId == _selectedCityId,
    );
    final city = selectedCity.copyWith(
      documentId: selectedCity.documentId,
    );
    _updateSelectedCity(city);
  }
}
