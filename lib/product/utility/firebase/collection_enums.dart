// ignore_for_file: constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';

enum CollectionEnums {
  towns,
  unApprovedApplications,
  approvedApplications,
  notifications,
  developers,
  specialAgency;

  CollectionReference<Map<String, dynamic>> get collection {
    return FirebaseFirestore.instance.collection(name);
  }
}
