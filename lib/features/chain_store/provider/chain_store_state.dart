import 'package:equatable/equatable.dart';
import 'package:life_shared/life_shared.dart';

final class ChainStoreState extends Equatable {
  const ChainStoreState({
    this.isFetching = false,
    this.chainStores = const [],
  });

  final List<ChainStoreModel> chainStores;
  final bool isFetching;

  @override
  List<Object?> get props => [
        chainStores,
        isFetching,
      ];

  ChainStoreState copyWith({
    List<ChainStoreModel>? chainStores,
    bool? isFetching,
  }) {
    return ChainStoreState(
      chainStores: chainStores ?? this.chainStores,
      isFetching: isFetching ?? this.isFetching,
    );
  }
}
