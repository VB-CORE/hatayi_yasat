import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:lifeclient/features/details/provider/event_detail_state.dart';

part 'event_detail_provider.g.dart';

@riverpod
final class EventDetailProvider extends _$EventDetailProvider {
  @override
  EventDetailState build() => const EventDetailState();
}
