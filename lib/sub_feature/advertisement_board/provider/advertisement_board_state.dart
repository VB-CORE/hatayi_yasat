import 'package:equatable/equatable.dart';
import 'package:life_shared/life_shared.dart';

final class AdvertisementBoardState extends Equatable {
  const AdvertisementBoardState({required this.advertisements});

  const AdvertisementBoardState.empty()
      : this(advertisements: const <AdBoardModel>[]);

  final List<AdBoardModel> advertisements;
  @override
  List<Object?> get props => [advertisements];

  AdvertisementBoardState copyWith({List<AdBoardModel>? advertisements}) {
    return AdvertisementBoardState(
      advertisements: advertisements ?? this.advertisements,
    );
  }
}
