import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';
import 'package:nexus_drift/game/components/drone.dart';
import 'package:nexus_drift/game/nexus_drift_game.dart';
import 'dart:math' as math;

class SolarWindZone extends BodyComponent with ContactCallbacks {
  @override
  final Vector2 position;
  final Vector2 size;
  final Vector2 windForce; // Direction and magnitude

  SolarWindZone({
    required this.position,
    required this.size,
    required this.windForce,
  });

  bool _isDroneInside = false;
  Drone? _drone;

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
      _drone = other;
    }
  }

  @override
  void endContact(Object other, Contact contact) {
    if (other is Drone) {
      _isDroneInside = false;
      _drone = null;
    }
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (_isDroneInside && _drone != null) {
      // Apply constant wind force
      _drone!.body.applyForce(windForce);
    }
  }

  @override
  void render(Canvas canvas) {
    if (!isMounted) return;
    
    final pulse = 0.5 + 0.5 * math.sin((game as NexusDriftGame).elapsedTime * 2);
    final color = Colors.orangeAccent;
    
    // Background haze
    final paint = Paint()
      ..color = color.withValues(alpha: 0.05 + 0.05 * pulse)
      ..style = PaintingStyle.fill;
    
    final rect = Rect.fromCenter(center: Offset.zero, width: size.x, height: size.y);
    canvas.drawRect(rect, paint);

    // Wind arrows / streamers
    final streamPaint = Paint()
      ..color = color.withValues(alpha: 0.2 + 0.1 * pulse)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.5;

    final arrowCount = (size.y / 8).clamp(2, 6).toInt();
    final spacing = size.y / (arrowCount + 1);
    
    for (int i = 1; i <= arrowCount; i++) {
      final yOffset = -size.y / 2 + spacing * i;
      final xStart = -size.x / 2;
      final xEnd = size.x / 2;
      
      // Moving pulse for the wind speed visualization
      final timeShift = ((game as NexusDriftGame).elapsedTime * 1.5) % 1.0;
      final pulseX = xStart + (size.x * timeShift);

      // Draw horizontal line
      canvas.drawLine(Offset(xStart, yOffset), Offset(xEnd, yOffset), streamPaint);
      
      // Draw arrow head at pulse position
      final arrowSize = 2.0;
      final path = Path();
      if (windForce.x >= 0) {
        path.moveTo(pulseX, yOffset - arrowSize);
        path.lineTo(pulseX + arrowSize, yOffset);
        path.lineTo(pulseX, yOffset + arrowSize);
      } else {
        path.moveTo(pulseX, yOffset - arrowSize);
        path.lineTo(pulseX - arrowSize, yOffset);
        path.lineTo(pulseX, yOffset + arrowSize);
      }
      canvas.drawPath(path, streamPaint);
    }
  }
}
