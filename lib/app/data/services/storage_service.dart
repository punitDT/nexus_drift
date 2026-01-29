import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService extends GetxService {
  late final SharedPreferences _prefs;

  Future<StorageService> init() async {
    _prefs = await SharedPreferences.getInstance();
    return this;
  }

  // Keys
  static const String _keyHighScrore = 'high_score';
  static const String _keyCurrentLevel = 'current_level';
  static const String _keyControlType = 'control_type';

  int get highScore => _prefs.getInt(_keyHighScrore) ?? 0;
  int get currentLevel => _prefs.getInt(_keyCurrentLevel) ?? 1;
  String get controlType => _prefs.getString(_keyControlType) ?? 'drag';

  Future<void> saveHighScore(int score) async {
    if (score > highScore) {
      await _prefs.setInt(_keyHighScrore, score);
    }
  }

  Future<void> saveCurrentLevel(int level) async {
    await _prefs.setInt(_keyCurrentLevel, level);
  }

  Future<void> saveControlType(String type) async {
    await _prefs.setString(_keyControlType, type);
  }
}
