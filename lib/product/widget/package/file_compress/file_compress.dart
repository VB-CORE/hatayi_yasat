// import 'dart:io';

// import 'package:flutter/foundation.dart';
// import 'package:flutter_image_compress/flutter_image_compress.dart';

// enum Qualities {
//   /// 50 is default
//   low(25),

//   /// 50 is default
//   normal(50),

//   /// 75 is default
//   medium(75),

//   /// 90 is default
//   high(90);

//   final int value;
//   const Qualities(this.value);
// }

// final class FileCompress {
//   FileCompress(this.file);

//   final File file;

//   Future<File> compressAndGetFile(Qualities quality) async {
//     final result = await FlutterImageCompress.compressWithFile(
//       file.absolute.path,
//       quality: quality.value,
//     );

//     if (result == null) return file;
//     await compute<Uint8List, File>(file.writeAsBytes, result);

//     return file;
//   }
// }
