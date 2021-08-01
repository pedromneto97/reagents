import '../drivers/hive_driver.dart';
import '../infra/storage_abstraction.dart';

const _boxName = 'preferences';

class PreferencesService {
  const PreferencesService._({required this.storage});

  final StorageAbstraction<bool> storage;

  static PreferencesService? _instance;

  factory PreferencesService() {
    _instance ??= PreferencesService._(
      storage: HiveDriver<bool>(
        storage: _boxName,
      ),
    );

    return _instance!;
  }

  Future<void> setPreference({required String key, required bool value}) {
    return storage.setData(key: key, value: value);
  }

  bool getPreference({required String key}) {
    return storage.getData(key: key) ?? false;
  }

  static String get dontShowKey => 'dontShowAgain';
}
