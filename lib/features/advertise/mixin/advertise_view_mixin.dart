import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:life_shared/life_shared.dart';
import 'package:vbaseproject/features/advertise/view/advertise_view.dart';

mixin AdvertiseViewMixin on State<AdvertiseView> {
  final CustomService _customService = FirebaseService();

  CollectionReference<AdvertiseModel?> advertiseCollectionReference() {
    return _customService.collectionReference(
      CollectionPaths.approvedAdvertise,
      AdvertiseModel(),
    );
  }
}
