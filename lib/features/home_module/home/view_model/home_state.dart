import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:life_shared/life_shared.dart';
import 'package:vbaseproject/product/init/language/locale_keys.g.dart';
import 'package:vbaseproject/product/utility/constants/app_constants.dart';
import 'package:vbaseproject/product/widget/sheet/operation/town_category_operation.dart';

@immutable
class HomeState extends Equatable {
  const HomeState({
    this.isServiceRequestSending = false,
    this.items = const [],
    this.townCategoryModel,
  });

  final bool isServiceRequestSending;
  final List<StoreModel> items;
  final TownCategoryModel? townCategoryModel;

  bool get isEnabled =>
      (!isServiceRequestSending && items.isNotEmpty) ||
      townCategoryModel != null;

  String get filterTitle {
    if (townCategoryModel == null) return LocaleKeys.button_filter.tr();
    if (townCategoryModel!.town == null &&
        townCategoryModel!.category == null) {
      return LocaleKeys.button_filter.tr();
    }

    final town = townCategoryModel!.town;
    final category = townCategoryModel!.category;

    if (town?.code == kErrorNumber.toInt() &&
        category?.value == kErrorNumber.toInt()) {
      return LocaleKeys.button_filter.tr();
    }

    if (town == null && category?.value != kErrorNumber.toInt()) {
      return '${category!.displayName} - ${LocaleKeys.button_allFilter.tr()}';
    }
    if (category == null && town?.code != kErrorNumber.toInt()) {
      return '${town!.displayName} -${LocaleKeys.button_allFilter.tr()}';
    }
    return '${town!.displayName} - ${category!.displayName}';
  }

  @override
  List<Object?> get props =>
      [isServiceRequestSending, items, townCategoryModel];

  HomeState copyWith({
    bool? isServiceRequestSending,
    List<StoreModel>? items,
    TownCategoryModel? townCategoryModel,
  }) {
    return HomeState(
      isServiceRequestSending:
          isServiceRequestSending ?? this.isServiceRequestSending,
      items: items ?? this.items,
      townCategoryModel: townCategoryModel ?? this.townCategoryModel,
    );
  }
}
