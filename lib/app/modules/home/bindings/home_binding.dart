import 'package:get/get.dart';

import '../controllers/home_controller.dart';
import 'package:nexus_drift/game/controllers/game_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    Get.lazyPut<GameController>(
      () => GameController(),
    );
  }
}
