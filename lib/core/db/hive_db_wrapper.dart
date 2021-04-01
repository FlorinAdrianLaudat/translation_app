import 'package:hive/hive.dart';

class HiveDBWrapper {
  Future<Box<E>> openBox<E>(String boxName) async {
    if (!Hive.isBoxOpen(boxName)) {
      return await Hive.openBox<E>(boxName);
    }
    return Hive.box<E>(boxName);
  }
}
