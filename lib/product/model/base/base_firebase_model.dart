// ignore: one_member_abstracts
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class BaseFirebaseModel<T> {
  Map<String, dynamic> toJson();
}

abstract class BaseFirebaseConvert<T> {
  T fromFirebase(DocumentSnapshot<Map<String, dynamic>> json);
  String get id;
}
