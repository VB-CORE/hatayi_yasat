import 'package:flutter/material.dart';
import 'package:life_shared/life_shared.dart';

@immutable
final class CalendarModel {
  const CalendarModel({
    required this.title,
    required this.description,
    required this.expireDate,
  });
  factory CalendarModel.fromCampaignModel({
    required CampaignModel campaignModel,
  }) {
    return CalendarModel(
      title: campaignModel.name ?? '',
      description: campaignModel.description ?? '',
      expireDate: campaignModel.expireDate ?? DateTime.now(),
    );
  }

  final String title;
  final String description;
  final DateTime expireDate;
}
