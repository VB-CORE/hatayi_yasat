import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
final class UsefulLinksState extends Equatable {
  const UsefulLinksState({this.count = 0});
  final int count;

  @override
  List<Object?> get props => [count];

  UsefulLinksState copyWith({int? count}) {
    return UsefulLinksState(count: count ?? this.count);
  }
}
