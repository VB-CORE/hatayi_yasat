import 'package:cloud_firestore/cloud_firestore.dart';

/// json_serializable converter'ı; her yazmada serverTimestamp yazar.
Object serverTimestampToJson(DateTime? _) => FieldValue.serverTimestamp();
