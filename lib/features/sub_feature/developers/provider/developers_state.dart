import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:life_shared/life_shared.dart';

@immutable
final class DevelopersState extends Equatable {
  const DevelopersState({
    this.activeDevelopers = const [],
    this.contributorDevelopers = const [],
    this.isFetching = false,
    this.isError = false,
  });

  final List<DeveloperModel> activeDevelopers;
  final List<DeveloperModel> contributorDevelopers;
  final bool isFetching;
  final bool isError;

  @override
  List<Object?> get props => [
    activeDevelopers,
    contributorDevelopers,
    isFetching,
    isError,
  ];

  DevelopersState copyWith({
    List<DeveloperModel>? activeDevelopers,
    List<DeveloperModel>? contributorDevelopers,
    bool? isFetching,
    bool? isError,
  }) {
    return DevelopersState(
      activeDevelopers: activeDevelopers ?? this.activeDevelopers,
      contributorDevelopers:
          contributorDevelopers ?? this.contributorDevelopers,
      isFetching: isFetching ?? this.isFetching,
      isError: isError ?? this.isError,
    );
  }
}
