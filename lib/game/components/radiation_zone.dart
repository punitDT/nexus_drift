import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';
import 'package:nexus_drift/game/components/drone.dart';
import 'package:nexus_drift/game/nexus_drift_game.dart';
import 'package:nexus_drift/game/controllers/game_controller.dart';
import 'package:get/get.dart';
import 'dart:math' as math;

class RadiationZone extends BodyComponent with ContactCallbacks {
  final Vector2 position;
  final Vector2 size;
  final double damageRate; // per second

  RadiationZone({
    required this.position,
    required this.size,
    this.damageRate = 10.0,
  });

  bool _isDroneInside = false;

  @override
  Body createBody() {
    final shape = PolygonShape()..setAsBox(size.x / 2, size.y / 2, Vector2.zero(), 0);
    final fixtureDef = FixtureDef(shape)
      ..isSensor = true;

    final bodyDef = BodyDef()
      ..position = position
      ..type = BodyType.static;

    final body = world.createBody(bodyDef);
    body.createFixture(fixtureDef).userData = this;
    return body;
  }

  @override
  void beginContact(Object other, Contact contact) {
    if (other is Drone) {
      _isDroneInside = true;
    }
  }

  @override
  void endContact(Object other, Contact contact) {
    if (other is Drone) {
      _isDroneInside = false;
    }
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (_isDroneInside) {
      Get.find<GameController>().takeDamage(damageRate * dt);
    }
  }

  @override
  void render(Canvas canvas) {
    if (!isMounted) return;
    final pulse = 0.5 + 0.3 * math.sin((game as NexusDriftGame).elapsedTime * 3);
    final paint = Paint()
      ..color = Colors.red.withOpacity(0.2 * pulse)
      ..style = PaintingStyle.fill;
    
    final borderPaint = Paint()
      ..color = Colors.red.withOpacity(0.4 * pulse)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.5;

    canvas.drawRect(Rect.fromCenter(center: Offset.zero, width: size.x, height: size.y), paint);
    canvas.drawRect(Rect.fromCenter(center: Offset.zero, width: size.x, height: size.y), borderPaint);
    
    // Tiny floating particles simulation is hard in render, so just a haze
    final hazePaint = Paint()
      ..color = Colors.red.withOpacity(0.1 * pulse)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3.0);
    canvas.drawRect(Rect.fromCenter(center: Offset.zero, width: size.x * 1.1, height: size.y * 1.1), hazePaint);
  }
}
