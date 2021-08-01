abstract class StorageAbstraction<T> {
  final String storage;

  const StorageAbstraction({required this.storage});

  Future<void> setData({required String key, required T value});
  T? getData({required String key});
}
