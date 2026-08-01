import 'package:equatable/equatable.dart';
import 'package:life_shared/life_shared.dart';

final class PlaceShowcaseState extends Equatable {
  const PlaceShowcaseState({
    this.modules = const [],
    this.isFetching = false,
    this.isError = false,
  });

  final List<MerchantShowcaseModuleModel> modules;
  final bool isFetching;
  final bool isError;

  PlaceShowcaseState copyWith({
    List<MerchantShowcaseModuleModel>? modules,
    bool? isFetching,
    bool? isError,
  }) {
    return PlaceShowcaseState(
      modules: modules ?? this.modules,
      isFetching: isFetching ?? this.isFetching,
      isError: isError ?? this.isError,
    );
  }

  @override
  List<Object?> get props => [modules, isFetching, isError];
}
