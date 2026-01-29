import 'package:get/get.dart';

import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/home/views/welcome_view.dart';
import '../modules/home/views/level_select_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.WELCOME;

  static final routes = [
    GetPage(
      name: _Paths.WELCOME,
      page: () => const WelcomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LEVEL_SELECT,
      page: () => const LevelSelectView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.GAME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
  ];
}
