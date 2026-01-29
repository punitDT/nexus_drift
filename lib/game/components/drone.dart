import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexus_drift/game/controllers/game_controller.dart';
import 'package:nexus_drift/game/components/thruster_particles.dart';

class Drone extends BodyComponent with ContactCallbacks {
  final Vector2 startPosition;
  late final GameController _gameController;
  
  Drone({required this.startPosition});

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    _gameController = Get.find<GameController>();
  }

  @override
  Body createBody() {
    print("Drone: createBody at $startPosition");
    final shape = CircleShape()..radius = 2.5; 
    final fixtureDef = FixtureDef(shape)
      ..restitution = 0.8 // Bouncy
      ..density = 1.0
      ..friction = 0.4; 

    final bodyDef = BodyDef()
      ..position = startPosition
      ..type = BodyType.dynamic
      ..linearDamping = 0.05 // Tiny bit of damping
      ..angularDamping = 0.8 // High damping so it doesn't spin wildly forever
      ..fixedRotation = false; 

    final body = world.createBody(bodyDef);
    final fixture = body.createFixture(fixtureDef);
    fixture.userData = this; // Explicitly set userData on the fixture
    return body;
  }

  void applyThrust(Vector2 force, double cost) {
    if (cost.isNaN) return;
    
    final availableFuel = _gameController.fuel.value;
    if (availableFuel > 0) {
      double actualCost = cost;
      Vector2 actualForce = force;

      // Allow using the last bit of fuel even if cost > available
      if (availableFuel < cost) {
        final ratio = availableFuel / cost;
        actualForce = force * ratio;
        actualCost = availableFuel;
      }

      body.applyLinearImpulse(actualForce);
      _gameController.consumeFuel(actualCost);
      
      // Spawn Visual Effects
      if (actualForce.length > 0.1) {
        world.add(ThrusterParticles(
          position: body.position,
          direction: actualForce.normalized(),
          power: actualForce.length,
        ));
      }
    }
  }

  void addFuel(double amount) {
    _gameController.addFuel(amount);
  }

  @override
  void update(double dt) {
    super.update(dt);
  }

  @override
  void render(Canvas canvas) {
    try {
      final body = this.body; 
      if (!body.isActive) return;

      canvas.save();
      canvas.translate(body.position.x, body.position.y);
      canvas.rotate(body.angle);
      
      // Draw Body
      final isDamaged = _gameController.health.value < 100.0;
      final healthFactor = _gameController.health.value / 100.0;
      
      final bodyColor = Color.lerp(Colors.redAccent, Colors.cyanAccent, healthFactor) ?? Colors.cyanAccent;
      final glowColor = Color.lerp(Colors.red.withOpacity(0.5), Colors.cyanAccent.withOpacity(0.3), healthFactor) ?? Colors.cyanAccent.withOpacity(0.3);

      final paint = Paint()..color = bodyColor;
      canvas.drawCircle(Offset.zero, 2.5, paint);
      
      // Draw Glow
      canvas.drawCircle(Offset.zero, 3.5, Paint()..color = glowColor);
      
      // Forward indicator
      canvas.drawRect(Rect.fromLTWH(0, -0.5, 2.5, 1.0), Paint()..color = Colors.white);
      
      canvas.restore();
    } catch (e) {
      print("Drone Render Error: $e");
    }
  }
}
