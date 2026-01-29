import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class VanishingPlatform extends BodyComponent {
  @override
  final Vector2 position;
  final Vector2 size;
  final double visibleDuration;
  final double vanishDuration;

  VanishingPlatform({
    required this.position,
    required this.size,
    this.visibleDuration = 3.0,
    this.vanishDuration = 2.0,
  });

  bool _isVisible = true;
  double _timer = 0;

  @override
  Body createBody() {
    final shape = PolygonShape()..setAsBox(size.x / 2, size.y / 2, Vector2.zero(), 0);
    final fixtureDef = FixtureDef(shape)
      ..restitution = 1.0
      ..friction = 0.0;

    final bodyDef = BodyDef()
      ..position = position
      ..type = BodyType.static;

    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }

  @override
  void update(double dt) {
    super.update(dt);
    _timer += dt;

    if (_isVisible) {
      if (_timer >= visibleDuration) {
        _isVisible = false;
        _timer = 0;
        body.setActive(false); // Disable collision
      }
    } else {
      if (_timer >= vanishDuration) {
        _isVisible = true;
        _timer = 0;
        body.setActive(true); // Enable collision
      }
    }
  }

  @override
  void render(Canvas canvas) {
    if (!isMounted) return;
    
    double opacity = 1.0;
    if (_isVisible) {
      // Warning pulse near the end of visible duration
      if (visibleDuration - _timer < 1.0) {
        opacity = 0.5 + 0.5 * math.sin(_timer * 20);
      }
    } else {
      // Very faint ghost when vanished or just nothing
      opacity = 0.05 + 0.05 * math.sin(_timer * 5);
    }

    canvas.save();
    canvas.translate(body.position.x, body.position.y);
    
    final baseColor = const Color(0xFF1E2633).withValues(alpha: opacity);
    final accentColor = Colors.purpleAccent.withValues(alpha: opacity);

    // Background
    final paint = Paint()
      ..color = baseColor
      ..style = PaintingStyle.fill;
    canvas.drawRect(Rect.fromCenter(center: Offset.zero, width: size.x, height: size.y), paint);
    
    // Border Glow
    final borderPaint = Paint()
      ..color = accentColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.2;
    canvas.drawRect(Rect.fromCenter(center: Offset.zero, width: size.x, height: size.y), borderPaint);

    // Pattern Detail
    final detailPaint = Paint()
      ..color = accentColor.withValues(alpha: 0.2 * opacity)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.1;
    for (int i = 0; i < 3; i++) {
        double x = -size.x/2 + (size.x/4 * (i+1));
        canvas.drawLine(Offset(x, -size.y/2), Offset(x, size.y/2), detailPaint);
    }

    canvas.restore();
  }
}
