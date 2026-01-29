import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';
import 'package:nexus_drift/game/components/drone.dart';
import 'package:nexus_drift/game/nexus_drift_game.dart';
import 'dart:math' as math;

enum MagnetPolarity { north, south }

class MagneticCoil extends BodyComponent with ContactCallbacks {
  @override
  final Vector2 position;
  final double radius;
  final double strength;
  final MagnetPolarity polarity;

  MagneticCoil({
    required this.position,
    required this.radius,
    required this.strength,
    required this.polarity,
  });

  bool _isDroneInRange = false;
  Drone? _drone;

  @override
  Body createBody() {
    final shape = CircleShape()..radius = radius;
    final fixtureDef = FixtureDef(shape)..isSensor = true;

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
      _isDroneInRange = true;
      _drone = other;
    }
  }

  @override
  void endContact(Object other, Contact contact) {
    if (other is Drone) {
      _isDroneInRange = false;
      _drone = null;
    }
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (_isDroneInRange && _drone != null) {
      final dronePos = _drone!.body.position;
      final direction = position - dronePos;
      final distance = direction.length;
      
      if (distance > 0) {
        // Polarity: North attracts, South repels
        final forceDirection = polarity == MagnetPolarity.north ? direction.normalized() : -direction.normalized();
        
        // Strength: Guide says 150-250 px/s2. 
        // We'll apply it as a continuous force.
        // We can scale it slightly by distance if we want falloff, but let's stick to constant for now as per "field".
        final force = forceDirection * strength;
        _drone!.body.applyForce(force);
      }
    }
  }

  @override
  void render(Canvas canvas) {
    if (!isMounted) return;
    
    final color = polarity == MagnetPolarity.north ? Colors.cyanAccent : Colors.orangeAccent;
    final pulse = 0.8 + 0.2 * math.sin((game as NexusDriftGame).elapsedTime * 4);
    
    // Core
    final paint = Paint()
      ..color = color.withValues(alpha: 0.9)
      ..style = PaintingStyle.fill;
    
    // Draw a small "coil" or "magnet" shape
    canvas.drawCircle(Offset.zero, 2.5, paint);
    canvas.drawCircle(Offset.zero, 3.0, Paint()..color = color.withValues(alpha: 0.3 * pulse)..style = PaintingStyle.stroke..strokeWidth = 0.5);
    
    // Field lines (Visual only)
    final fieldPaint = Paint()
      ..color = color.withValues(alpha: 0.1 * pulse)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.3;
    
    for (int i = 1; i <= 4; i++) {
        canvas.drawCircle(Offset.zero, radius * (i / 4), fieldPaint);
    }

    // Polarity label
    final textPainter = TextPainter(
      text: TextSpan(
        text: polarity == MagnetPolarity.north ? 'N' : 'S',
        style: TextStyle(
          color: Colors.white, 
          fontSize: 3.5, 
          fontWeight: FontWeight.bold,
          shadows: [Shadow(color: Colors.black, blurRadius: 2)],
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(canvas, Offset(-textPainter.width / 2, -textPainter.height / 2));
  }
}
