import 'package:hive/hive.dart';

import '../infra/storage_abstraction.dart';

class HiveDriver<T> implements StorageAbstraction<T> {
  late final Box<T> box;

  @override
  final String storage;

  HiveDriver({required this.storage}) {
    if (Hive.isBoxOpen(storage)) {
      box = Hive.box<T>(storage);
    } else {
      Hive.openBox<T>(storage).then((openBox) => box = openBox);
    }
  }

  @override
  T? getData({required String key}) => box.get(key);

  @override
  Future<void> setData({required String key, required value}) =>
      box.put(key, value);
}
