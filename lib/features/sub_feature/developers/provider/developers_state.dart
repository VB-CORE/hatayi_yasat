import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:life_shared/life_shared.dart';

@immutable
final class DevelopersState extends Equatable {
  const DevelopersState({
    this.activeDevelopers = const [],
    this.veteranDevelopers = const [],
    this.isFetching = false,
    this.isError = false,
  });

  final List<DeveloperModel> activeDevelopers;
  final List<DeveloperModel> veteranDevelopers;
  final bool isFetching;
  final bool isError;

  @override
  List<Object?> get props => [
    activeDevelopers,
    veteranDevelopers,
    isFetching,
    isError,
  ];

  DevelopersState copyWith({
    List<DeveloperModel>? activeDevelopers,
    List<DeveloperModel>? veteranDevelopers,
    bool? isFetching,
    bool? isError,
  }) {
    return DevelopersState(
      activeDevelopers: activeDevelopers ?? this.activeDevelopers,
      veteranDevelopers: veteranDevelopers ?? this.veteranDevelopers,
      isFetching: isFetching ?? this.isFetching,
      isError: isError ?? this.isError,
    );
  }
}
