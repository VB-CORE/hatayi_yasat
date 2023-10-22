import 'package:hive/hive.dart';

abstract class HiveBoxList<E extends List<E>> extends Box<List<dynamic>> {
  @override
  List<dynamic>? get(key, {List<dynamic>? defaultValue}) {
    // TODO: implement get
    throw UnimplementedError();
  }
}
