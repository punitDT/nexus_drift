part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const WELCOME = _Paths.WELCOME;
  static const LEVEL_SELECT = _Paths.LEVEL_SELECT;
  static const GAME = _Paths.GAME;
  static const SETTINGS = _Paths.SETTINGS;
}

abstract class _Paths {
  _Paths._();
  static const WELCOME = '/welcome';
  static const LEVEL_SELECT = '/level-select';
  static const GAME = '/game';
  static const SETTINGS = '/settings';
}
