import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
final class ProjectDetailState extends Equatable {
  const ProjectDetailState();
  @override
  List<Object?> get props => [];

  ProjectDetailState copyWith() {
    return const ProjectDetailState();
  }
}
