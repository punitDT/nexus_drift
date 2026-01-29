import 'package:get/get.dart';
import 'package:nexus_drift/app/data/services/storage_service.dart';

class GameController extends GetxController {
  final _storage = Get.find<StorageService>();

  // Global State
  final RxDouble fuel = 100.0.obs;
  final RxDouble maxFuel = 100.0.obs;
  final RxDouble health = 100.0.obs;
  final RxInt score = 0.obs;
  
  // Level Management
  final RxInt currentLevel = 1.obs;
  final RxInt unlockedLevel = 1.obs;
  
  // Endless Mode State
  final RxInt wavesSurvived = 0.obs;
  final RxDouble distanceTravelled = 0.0.obs;
  final RxDouble scoreMultiplier = 1.0.obs;

  // Settings
  final RxString controlType = 'drag'.obs; // 'drag' or 'buttons'
  
  @override
  void onInit() {
    super.onInit();
    unlockedLevel.value = _storage.currentLevel;
    currentLevel.value = unlockedLevel.value;
    controlType.value = _storage.controlType;
  }

  void setControlType(String type) {
    controlType.value = type;
    _storage.saveControlType(type);
  }

  void resetHealth() {
    health.value = 100.0;
  }

  void takeDamage(double amount) {
    health.value -= amount;
    if (health.value < 0) health.value = 0;
  }

  void setStartingFuel(double amount) {
    maxFuel.value = amount;
    fuel.value = amount;
  }

  void consumeFuel(double customCost) {
    if (fuel.value > 0) {
      fuel.value -= customCost;
      if (fuel.value < 0) fuel.value = 0;
    }
  }
  
  void addFuel(double amount) {
    fuel.value += amount;
    if (fuel.value > maxFuel.value) fuel.value = maxFuel.value;
  }

  void addScore(int points) {
    score.value += points;
    _storage.saveHighScore(score.value);
  }

  void nextLevel() {
    // If we completed the highest unlocked level, unlock the next one
    if (currentLevel.value == unlockedLevel.value) {
      unlockedLevel.value++;
      _storage.saveCurrentLevel(unlockedLevel.value);
    }
    // Prepare next level for playing
    currentLevel.value++;
  }
}
