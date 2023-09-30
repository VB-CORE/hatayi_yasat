import 'package:flutter/material.dart';
import 'package:life_shared/life_shared.dart';

@immutable
final class CalendarModel {
  const CalendarModel({
    required this.title,
    required this.description,
    required this.startDate,
  });
  factory CalendarModel.fromCampaignModel({
    required CampaignModel campaignModel,
  }) {
    return CalendarModel(
      title: campaignModel.name ?? '',
      description: campaignModel.description ?? '',
      startDate: campaignModel.startDate ?? DateTime.now(),
    );
  }

  final String title;
  final String description;
  final DateTime startDate;
}
