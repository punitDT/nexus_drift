import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:nexus_drift/game/controllers/game_controller.dart';
import 'package:nexus_drift/app/data/services/storage_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Game Logic Robustness Tests', () {
    late StorageService storageService;
    late GameController gameController;

    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      storageService = await StorageService().init();
      Get.put(storageService);
      gameController = GameController();
      Get.put(gameController);
    });

    tearDown(() {
      Get.reset();
    });

    test('Initial fuel should be 100', () {
      expect(gameController.fuel.value, equals(100.0));
    });

    test('Consuming fuel should reduce fuel level', () {
      gameController.consumeFuel(20.0);
      expect(gameController.fuel.value, equals(80.0));
    });

    test('Adding fuel should not exceed 100', () {
      gameController.consumeFuel(10.0);
      gameController.addFuel(50.0);
      expect(gameController.fuel.value, equals(100.0));
    });

    test('Adding score should update high score in storage', () {
      gameController.addScore(100);
      expect(gameController.score.value, equals(100));
      expect(storageService.highScore, equals(100));
    });

    test('Advancing level should update storage', () {
      gameController.nextLevel();
      expect(gameController.currentLevel.value, equals(2));
      expect(storageService.currentLevel, equals(2));
    });
  });
}
