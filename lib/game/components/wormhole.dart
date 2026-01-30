import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';
import 'package:nexus_drift/game/components/drone.dart';
import 'package:nexus_drift/game/nexus_drift_game.dart';
import 'package:nexus_drift/game/controllers/game_controller.dart';
import 'package:get/get.dart';

class Wormhole extends BodyComponent<NexusDriftGame> with ContactCallbacks {
  final Vector2 position;
  final double radius;

  Wormhole({
    required this.position,
    this.radius = 5.0,
  });

  @override
  Body createBody() {
    final shape = CircleShape()..radius = radius;
    final fixtureDef = FixtureDef(shape, isSensor: true);
    final bodyDef = BodyDef(
      position: position,
      type: BodyType.static,
    );
    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }

  @override
  void render(Canvas canvas) {
    // Purple/Neon swirl effect
    final paint = Paint()
      ..color = Colors.purpleAccent.withOpacity(0.6)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;
      
    canvas.drawCircle(Offset.zero, radius, paint);
    canvas.drawCircle(Offset.zero, radius * 0.7, paint..color = Colors.blueAccent.withOpacity(0.8));
  }

  @override
  void beginContact(Object other, Contact contact) {
    if (other is Drone) {
      // Teleport Effect + Bonus
      final controller = Get.find<GameController>();
      controller.addFuel(20.0); // Bonus
      
      // Random safe teleport (simple x-shift for endless linearity)
      final drone = other;
      drone.body.setTransform(drone.body.position + Vector2(30, 0), 0);
      
      // Remove wormhole after use
      removeFromParent();
    }
  }
}
