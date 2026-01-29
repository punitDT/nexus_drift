import 'package:flame/extensions.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';

class GamePlatform extends BodyComponent {
  final Vector2 position;
  final Vector2 size;

  GamePlatform({
    required this.position,
    required this.size,
  });

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
  void render(Canvas canvas) {
    canvas.save();
    canvas.translate(body.position.x, body.position.y);
    canvas.rotate(body.angle); 
    
    final baseColor = const Color(0xFF1E2633);
    final accentColor = Colors.cyanAccent;

    // Background
    final paint = Paint()
      ..color = baseColor
      ..style = PaintingStyle.fill;
    canvas.drawRect(Rect.fromCenter(center: Offset.zero, width: size.x, height: size.y), paint);
    
    // Border Glow
    final glowPaint = Paint()
      ..color = accentColor.withValues(alpha: 0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.3
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 0.2);
    canvas.drawRect(Rect.fromCenter(center: Offset.zero, width: size.x, height: size.y), glowPaint);

    // Sharp Border
    final borderPaint = Paint()
      ..color = accentColor.withValues(alpha: 0.8)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.15;
    canvas.drawRect(Rect.fromCenter(center: Offset.zero, width: size.x, height: size.y), borderPaint);
    
    // Diagonal Detail (Cyberpunk style)
    final detailPaint = Paint()
      ..color = accentColor.withValues(alpha: 0.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.1;
    canvas.drawLine(Offset(-size.x/2, -size.y/2), Offset(-size.x/2 + 1, -size.y/2 + 1), detailPaint);
    canvas.drawLine(Offset(size.x/2, size.y/2), Offset(size.x/2 - 1, size.y/2 - 1), detailPaint);

    canvas.restore();
  }
}
