import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:nexus_drift/game/nexus_drift_game.dart';
import 'package:nexus_drift/game/controllers/game_controller.dart';
import 'package:get/get.dart';
import 'dart:math' as math;

class HintArrow extends PositionComponent with HasGameReference<NexusDriftGame> {
  double _lifetime = 0;
  bool _shouldShow = true;
  late final int _level;

  @override
  void onMount() {
    super.onMount();
    _level = Get.find<GameController>().currentLevel.value;
  }

  @override
  void update(double dt) {
    super.update(dt);
    
    final drone = game.drone;
    if (!drone.isMounted) return;

    _lifetime += dt;
    
    // Level 1: 30s, Level 2+: 15s
    final maxLifetime = _level == 1 ? 30.0 : 15.0;
    
    // Disappear after specified seconds OR if drone moves significantly
    if (_lifetime > maxLifetime || drone.body.linearVelocity.length > 5.0) {
      _shouldShow = false;
    }
    
    if (_shouldShow) {
      position = drone.body.position;
    }
  }

  @override
  void render(Canvas canvas) {
    if (!_shouldShow) return;
    
    final pulse = 0.4 + 0.3 * math.sin(game.elapsedTime * 4);
    final paint = Paint()
      ..color = Colors.white.withOpacity(pulse)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.3;
      
    canvas.save();
    canvas.rotate(-0.4); // Rotate path to point right-up
    
    final path = Path();
    path.moveTo(4.0, 0); // Start outside drone (radius 2.5)
    path.lineTo(8.5, 0); // Tail
    
    // Arrow head
    path.moveTo(8.5, 0);
    path.lineTo(7.5, 0.8);
    path.moveTo(8.5, 0);
    path.lineTo(7.5, -0.8);
    
    canvas.drawPath(path, paint);
    canvas.restore();
  }
}
