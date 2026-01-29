import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';
import 'package:nexus_drift/game/components/drone.dart';
import 'package:nexus_drift/game/nexus_drift_game.dart';
import 'dart:math' as math;

class SpaceDebris extends BodyComponent with ContactCallbacks {
  final Vector2 initialPosition;
  final Vector2 initialVelocity;
  final double radius;

  SpaceDebris({
    required this.initialPosition,
    required this.initialVelocity,
    this.radius = 1.5,
  });

  @override
  Body createBody() {
    final shape = CircleShape()..radius = radius;
    final fixtureDef = FixtureDef(shape)
      ..restitution = 1.0 // Bouncy
      ..friction = 0.0
      ..density = 0.5;

    final bodyDef = BodyDef()
      ..position = initialPosition
      ..type = BodyType.dynamic
      ..linearVelocity = initialVelocity
      ..linearDamping = 0.0 // No air resistance in space
      ..angularDamping = 0.1;

    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }

  @override
  void beginContact(Object other, Contact contact) {
    if (other is Drone) {
      (game as NexusDriftGame).failLevel("DEBRIS COLLISION");
    }
  }

  @override
  void render(Canvas canvas) {
    if (!isMounted) return;
    
    canvas.save();
    canvas.translate(body.position.x, body.position.y);
    canvas.rotate(body.angle);

    final color = Colors.blueGrey[300]!;
    
    // Core (Metallic chunk)
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    
    // Draw an irregular-ish hexagon for a "chunk" feel
    final path = Path();
    final sides = 6;
    for (int i = 0; i < sides; i++) {
        final angle = (i * 2 * math.pi / sides);
        final r = radius * (0.8 + 0.2 * math.sin(i * 10)); // Slightly irregular
        final x = r * math.cos(angle);
        final y = r * math.sin(angle);
        if (i == 0) {
          path.moveTo(x, y);
        } else {
          path.lineTo(x, y);
        }
    }
    path.close();
    canvas.drawPath(path, paint);

    // Metallic Shine
    final shinePaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.4)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.2;
    canvas.drawPath(path, shinePaint);

    // Small detail line
    canvas.drawLine(Offset(-radius*0.3, -radius*0.3), Offset(radius*0.3, radius*0.3), shinePaint);

    canvas.restore();
  }
}
