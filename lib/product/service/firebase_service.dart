// import 'dart:io';

// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/foundation.dart';
// import 'package:logger/logger.dart';

// import 'package:vbaseproject/product/model/base/base_firebase_model.dart';
// import 'package:vbaseproject/product/service/custom_service.dart';

// import 'package:vbaseproject/product/utility/firebase/collection_enums.dart';

// enum RootStorageName {
//   company,
//   pending,
//   product,
//   user,
// }

// @immutable
// final class FirebaseService implements CustomService {
//   @override
//   Future<String?> add<T extends BaseFirebaseModel<T>>({
//     required T model,
//     required CollectionEnums path,
//   }) async {
//     try {
//       final response = await path.collection.add(model.toJson());
//       return response.id;
//     } catch (e) {
//       Logger().e(e.toString());
//     }
//     return null;
//   }

//   @override
//   Future<List<T>> getList<T extends BaseFirebaseConvert<T>>({
//     required T model,
//     required CollectionEnums path,
//   }) async {
//     final response = await path.collection.withConverter<T?>(
//       fromFirestore: (snapshot, options) {
//         final data = snapshot.data();
//         if (data == null) return null;
//         try {
//           return model.fromFirebase(snapshot);
//         } catch (e) {
//           return null;
//         }
//       },
//       toFirestore: (value, options) {
//         throw UnimplementedError();
//       },
//     ).get();

//     if (response.docs.isNotEmpty) {
//       final values = response.docs
//           .map((e) => e.data())
//           .where((element) => element != null)
//           .cast<T>()
//           .toList();
//       return values;
//     }

//     return [];
//   }

//   @override
//   Future<String?> uploadImage({
//     required File file,
//     required RootStorageName root,
//     required String key,
//   }) async {
//     final storage = FirebaseStorage.instance;
//     final name = '${root.name}/$key';
//     try {
//       await storage.ref(name).putFile(file);
//       final downloadURL = await storage.ref(name).getDownloadURL();
//       return downloadURL;
//     } catch (_) {}
//     return null;
//   }

//   @override
//   Future<T?> getSingleData<T extends BaseFirebaseConvert<T>>({
//     required T model,
//     required CollectionEnums path,
//     required String id,
//   }) async {
//     final response = await path.collection.doc(id).withConverter<T?>(
//       fromFirestore: (snapshot, options) {
//         final data = snapshot.data();
//         if (data == null) return null;
//         try {
//           return model.fromFirebase(snapshot);
//         } catch (e) {
//           return null;
//         }
//       },
//       toFirestore: (value, options) {
//         throw UnimplementedError();
//       },
//     ).get();

//     return response.data();
//   }
// }
