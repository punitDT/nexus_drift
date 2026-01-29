import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';
import 'package:nexus_drift/game/components/drone.dart';
import 'package:nexus_drift/game/nexus_drift_game.dart';
import 'dart:math' as math;

class BlackHole extends BodyComponent with ContactCallbacks {
  @override
  final Vector2 position;
  final double pullRadius;
  final double horizonRadius;
  final double maxPullForce;

  BlackHole({
    required this.position,
    this.pullRadius = 50.0,
    this.horizonRadius = 6.0,
    this.maxPullForce = 10000.0,
  });

  bool _isDroneInInfluence = false;
  Drone? _drone;

  @override
  Body createBody() {
    // Influence area
    final shape = CircleShape()..radius = pullRadius;
    final fixtureDef = FixtureDef(shape)..isSensor = true;

    final bodyDef = BodyDef()
      ..position = position
      ..type = BodyType.static;

    final body = world.createBody(bodyDef);
    body.createFixture(fixtureDef).userData = this;

    // We don't need a separate body for the horizon, we'll check it in update
    return body;
  }

  @override
  void beginContact(Object other, Contact contact) {
    if (other is Drone) {
      _isDroneInInfluence = true;
      _drone = other;
    }
  }

  @override
  void endContact(Object other, Contact contact) {
    if (other is Drone) {
      _isDroneInInfluence = false;
      _drone = null;
    }
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (_isDroneInInfluence && _drone != null) {
      final dronePos = _drone!.body.position;
      final direction = position - dronePos;
      final distance = direction.length;

      // 1. Check Event Horizon (Instant Death)
      if (distance < horizonRadius) {
        (game as NexusDriftGame).failLevel("SUCKED INTO VOID");
        return;
      }

      // 2. Apply Gravitational Pull
      if (distance > 0) {
        // Force increases as distance decreases (Inverse square or linear ramp)
        // Let's use a linear ramp from pullRadius to horizonRadius
        final t = 1.0 - ((distance - horizonRadius) / (pullRadius - horizonRadius)).clamp(0, 1);
        final forceMagnitude = maxPullForce * (0.2 + 0.8 * t); // Minimum 20% pull at edge
        
        final force = direction.normalized() * forceMagnitude;
        _drone!.body.applyForce(force);
      }
    }
  }

  @override
  void render(Canvas canvas) {
    if (!isMounted) return;
    final time = (game as NexusDriftGame).elapsedTime;

    // 1. Event Horizon (The Void)
    final horizonPaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset.zero, horizonRadius, horizonPaint);

    // 2. Glowing Edge / Accretion Disk
    final edgePaint = Paint()
      ..color = Colors.deepPurpleAccent.withValues(alpha: 0.8)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;
    
    final pulse = 0.9 + 0.1 * math.sin(time * 5);
    canvas.drawCircle(Offset.zero, horizonRadius * pulse, edgePaint);

    // 3. Swirling Vortex Effect
    final vortexPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.5;

    for (int i = 0; i < 3; i++) {
      final radius = horizonRadius + 2 + (i * 4);
      final rotation = time * (3 - i);
      vortexPaint.color = Colors.purple.withValues(alpha: 0.3 - (i * 0.1));
      
      canvas.save();
      canvas.rotate(rotation);
      // Draw some arcs to simulate swirling
      canvas.drawArc(
        Rect.fromCircle(center: Offset.zero, radius: radius),
        0,
        math.pi * 1.5,
        false,
        vortexPaint,
      );
      canvas.restore();
    }

    // 4. Outer Influence Hint
    final influencePaint = Paint()
      ..color = Colors.purple.withValues(alpha: 0.05)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset.zero, pullRadius, influencePaint);
  }
}
