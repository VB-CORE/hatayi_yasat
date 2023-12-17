import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vbaseproject/features/v2/details/provider/place_detail_state.dart';

part 'place_detail_provider.g.dart';

@riverpod
final class PlaceRequestProvider extends _$PlaceRequestProvider {
  @override
  PlaceDetailState build() => const PlaceDetailState();
}
