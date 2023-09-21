// import 'dart:io';

// import 'package:vbaseproject/product/model/base/base_firebase_model.dart';
// import 'package:vbaseproject/product/service/firebase_service.dart';

// import 'package:vbaseproject/product/utility/firebase/collection_enums.dart';

// abstract class CustomService {
//   Future<String?> add<T extends BaseFirebaseModel<T>>({
//     required T model,
//     required CollectionEnums path,
//   });

//   Future<List<T>> getList<T extends BaseFirebaseConvert<T>>({
//     required T model,
//     required CollectionEnums path,
//   });

//   Future<T?> getSingleData<T extends BaseFirebaseConvert<T>>({
//     required T model,
//     required CollectionEnums path,
//     required String id,
//   });

//   Future<String?> uploadImage({
//     required File file,
//     required RootStorageName root,
//     required String key,
//   });
// }
