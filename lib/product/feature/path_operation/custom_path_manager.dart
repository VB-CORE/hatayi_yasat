import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';

final class CustomPathManager {
  Future<File?> writeByteToFile(Uint8List bytes, String fileName) async {
    final directory = await getTemporaryDirectory();
    final path = '${directory.path}/$fileName';
    final file = File(path);
    return file.writeAsBytes(bytes);
  }

  Future<Uint8List?> readFileToByte(String fileName) async {
    final directory = await getTemporaryDirectory();
    final path = '${directory.path}/$fileName';
    final file = File(path);
    if (await file.exists()) {
      return file.readAsBytes();
    }
    return null;
  }
}
