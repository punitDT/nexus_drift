import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';
import 'package:nexus_drift/game/components/drone.dart';
import 'package:nexus_drift/game/nexus_drift_game.dart';

class ExitPortal extends BodyComponent with ContactCallbacks {
  final Vector2 position;
  final Vector2 size;
  final Function onLevelComplete;

  ExitPortal({
    required this.position, 
    required this.onLevelComplete,
    Vector2? size,
  }) : size = size ?? Vector2(10, 10);

  @override
  Body createBody() {
    final shape = PolygonShape()..setAsBox(size.x / 2 * 0.9, size.y / 2 * 0.9, Vector2.zero(), 0); // Hitbox slightly smaller than visual
    final fixtureDef = FixtureDef(shape)
      ..isSensor = true;

    final bodyDef = BodyDef()
      ..position = position
      ..type = BodyType.static;

    final body = world.createBody(bodyDef);
    final fixture = body.createFixture(fixtureDef);
    fixture.userData = this; 
    return body;
  }

  @override
  void beginContact(Object other, Contact contact) {
    if (!isMounted) return;
    final nexusGame = game as NexusDriftGame;

    bool isDrone = other is Drone;
    if (!isDrone) {
      if (other == nexusGame.drone) {
        isDrone = true;
      }
    }

    if (isDrone) {
      onLevelComplete();
    }
  }

  @override
  void render(Canvas canvas) {
    canvas.save();
    canvas.translate(body.position.x, body.position.y);
    
    final baseColor = Colors.greenAccent;
    
    // Outer Frame Glow
    final outerGlowPaint = Paint()
      ..color = baseColor.withOpacity(0.2)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 2.0);
    canvas.drawRect(Rect.fromCenter(center: Offset.zero, width: size.x * 1.2, height: size.y * 1.2), outerGlowPaint);

    final paint = Paint()
      ..color = baseColor.withOpacity(0.8)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.6;
    
    // Outer Frame
    canvas.drawRect(Rect.fromCenter(center: Offset.zero, width: size.x, height: size.y), paint);
    
    // Inner Portal "Event Horizon"
    final glowRect = Rect.fromCenter(center: Offset.zero, width: size.x * 0.9, height: size.y * 0.9);
    final glowPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          baseColor.withOpacity(0.6),
          baseColor.withOpacity(0.1),
        ],
      ).createShader(glowRect)
      ..style = PaintingStyle.fill;
    canvas.drawRect(glowRect, glowPaint);

    canvas.restore();
  }
}

