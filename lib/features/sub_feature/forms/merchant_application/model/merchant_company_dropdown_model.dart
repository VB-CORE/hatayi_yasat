import 'package:equatable/equatable.dart';
import 'package:life_shared/life_shared.dart';

final class MerchantCompanyDropdownModel extends Equatable
    with BaseDropDownModel {
  const MerchantCompanyDropdownModel(this.store);

  final StoreModel store;

  @override
  String get displayName => store.name;

  @override
  List<Object?> get props => [store.documentId];
}
