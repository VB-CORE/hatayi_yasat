import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:life_shared/life_shared.dart';

@immutable
final class SpecialAgencyState extends Equatable {
  const SpecialAgencyState({
    this.townNamesAndAgency = const {},
  });
  final Map<String, List<SpecialAgencyModel>> townNamesAndAgency;

  @override
  List<Object?> get props => [
        townNamesAndAgency,
      ];

  SpecialAgencyState copyWith({
    required Map<String, List<SpecialAgencyModel>>? townNamesAndAgency,
  }) {
    return SpecialAgencyState(
      townNamesAndAgency: townNamesAndAgency ?? this.townNamesAndAgency,
    );
  }
}
