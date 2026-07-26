import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:life_shared/life_shared.dart';

@immutable
final class DevelopersState extends Equatable {
  const DevelopersState({
    this.developers = const [],
    this.isFetching = false,
    this.isError = false,
  });

  final List<DeveloperModel> developers;
  final bool isFetching;
  final bool isError;

  @override
  List<Object?> get props => [developers, isFetching, isError];

  DevelopersState copyWith({
    List<DeveloperModel>? developers,
    bool? isFetching,
    bool? isError,
  }) {
    return DevelopersState(
      developers: developers ?? this.developers,
      isFetching: isFetching ?? this.isFetching,
      isError: isError ?? this.isError,
    );
  }
}
