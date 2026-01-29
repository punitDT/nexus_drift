import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexus_drift/game/nexus_drift_game.dart';
import '../controllers/home_controller.dart';
import 'package:nexus_drift/screens/result_overlay.dart';
import 'package:nexus_drift/screens/game_hud.dart';
import 'package:nexus_drift/app/routes/app_pages.dart';

import 'package:nexus_drift/game/components/game_controls.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F1A),
      body: GameWidget(
        game: NexusDriftGame(),
        overlayBuilderMap: {
          'hud': (context, game) => GameHud(game: game as NexusDriftGame),
          'controls': (context, game) => GameControls(game: game as NexusDriftGame),
          'win': (context, game) => ResultOverlay(
            isWin: true,
            title: "MISSION SUCCESS",
            message: (game as NexusDriftGame).lossMessage,
            onAction: () => Get.offAllNamed(Routes.LEVEL_SELECT), 
            onMenu: () => Get.offAllNamed(Routes.WELCOME),
          ),
          'loss': (context, game) => ResultOverlay(
            isWin: false,
            title: "MISSION FAILED",
            message: (game as NexusDriftGame).lossMessage,
            onAction: () => Get.offAllNamed(Routes.LEVEL_SELECT), 
            onMenu: () => Get.offAllNamed(Routes.WELCOME),
          ),
        },
        initialActiveOverlays: const ['hud', 'controls'],
      ),
    );
  }
}
