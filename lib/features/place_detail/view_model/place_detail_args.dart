import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:life_shared/life_shared.dart';

@immutable
final class PlaceDetailArgs extends Equatable {
  const PlaceDetailArgs({required this.id, required this.store});

  final String id;
  final StoreModel store;

  String get placeId => id.isNotEmpty ? id : store.documentId;

  bool get hasStore => store.documentId.isNotEmpty;

  @override
  List<Object> get props => [placeId];
}
