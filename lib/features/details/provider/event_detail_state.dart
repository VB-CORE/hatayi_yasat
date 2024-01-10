import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
final class EventDetailState extends Equatable {
  const EventDetailState();

  @override
  List<Object?> get props => [];

  EventDetailState copyWith() {
    return const EventDetailState();
  }
}
