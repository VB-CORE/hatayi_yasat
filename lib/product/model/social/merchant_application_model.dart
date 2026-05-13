import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

/// Merchant ("esnaf") onboarding application. Captures the 4-step form
/// data (place, contact, owner, documents) and a lifecycle [status] +
/// [timeline] of moderation events. Stored at `merchant_applications/{id}`.
final class MerchantApplicationModel extends Equatable {
  const MerchantApplicationModel({
    required this.id,
    required this.uid,
    required this.placeName,
    required this.placeCategory,
    required this.description,
    required this.photos,
    required this.phone,
    required this.address,
    required this.location,
    required this.hours,
    required this.ownerName,
    required this.taxNumber,
    required this.registryNumber,
    required this.documents,
    required this.status,
    required this.timeline,
    required this.createdAt,
  });

  factory MerchantApplicationModel.fromJson(
    String id,
    Map<String, dynamic> json,
  ) {
    final timelineRaw = json['timeline'] as List? ?? const [];
    return MerchantApplicationModel(
      id: id,
      uid: json['uid'] as String? ?? '',
      placeName: json['placeName'] as String? ?? '',
      placeCategory: json['placeCategory'] as String? ?? '',
      description: json['description'] as String? ?? '',
      photos: (json['photos'] as List?)?.cast<String>() ?? const <String>[],
      phone: json['phone'] as String? ?? '',
      address: json['address'] as String? ?? '',
      location: json['location'] as GeoPoint?,
      hours: json['hours'] as String? ?? '',
      ownerName: json['ownerName'] as String? ?? '',
      taxNumber: json['taxNumber'] as String? ?? '',
      registryNumber: json['registryNumber'] as String? ?? '',
      documents:
          (json['documents'] as List?)?.cast<String>() ?? const <String>[],
      status: MerchantApplicationStatus.fromString(
        json['status'] as String?,
      ),
      timeline: timelineRaw
          .whereType<Map<String, dynamic>>()
          .map(MerchantTimelineEntry.fromJson)
          .toList(growable: false),
      createdAt: (json['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  final String id;
  final String uid;
  final String placeName;
  final String placeCategory;
  final String description;
  final List<String> photos;
  final String phone;
  final String address;
  final GeoPoint? location;
  final String hours;
  final String ownerName;
  final String taxNumber;
  final String registryNumber;
  final List<String> documents;
  final MerchantApplicationStatus status;
  final List<MerchantTimelineEntry> timeline;
  final DateTime createdAt;

  Map<String, dynamic> toJson() => {
    'uid': uid,
    'placeName': placeName,
    'placeCategory': placeCategory,
    'description': description,
    'photos': photos,
    'phone': phone,
    'address': address,
    'location': location,
    'hours': hours,
    'ownerName': ownerName,
    'taxNumber': taxNumber,
    'registryNumber': registryNumber,
    'documents': documents,
    'status': status.name,
    'timeline': timeline.map((e) => e.toJson()).toList(),
    'createdAt': Timestamp.fromDate(createdAt),
  };

  @override
  List<Object?> get props => [id, uid, status, timeline.length];
}

enum MerchantApplicationStatus {
  none,
  submitted,
  inReview,
  approved,
  rejected
  ;

  static MerchantApplicationStatus fromString(String? value) => switch (value) {
    'submitted' => MerchantApplicationStatus.submitted,
    'in_review' => MerchantApplicationStatus.inReview,
    'approved' => MerchantApplicationStatus.approved,
    'rejected' => MerchantApplicationStatus.rejected,
    _ => MerchantApplicationStatus.none,
  };

  String get firestoreValue => switch (this) {
    MerchantApplicationStatus.inReview => 'in_review',
    _ => name,
  };
}

final class MerchantTimelineEntry extends Equatable {
  const MerchantTimelineEntry({
    required this.stage,
    required this.at,
    this.note,
  });

  factory MerchantTimelineEntry.fromJson(Map<String, dynamic> json) {
    return MerchantTimelineEntry(
      stage: MerchantApplicationStatus.fromString(json['stage'] as String?),
      at: (json['at'] as Timestamp?)?.toDate() ?? DateTime.now(),
      note: json['note'] as String?,
    );
  }

  final MerchantApplicationStatus stage;
  final DateTime at;
  final String? note;

  Map<String, dynamic> toJson() => {
    'stage': stage.firestoreValue,
    'at': Timestamp.fromDate(at),
    if (note != null) 'note': note,
  };

  @override
  List<Object?> get props => [stage, at, note];
}
