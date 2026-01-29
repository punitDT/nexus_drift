import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class WinParticles extends Component {
  final Vector2 position;
  
  WinParticles({required this.position});

  @override
  Future<void> onLoad() async {
    final random = math.Random();
    // Burst of confetti-like particles
    for (int i = 0; i < 60; i++) {
      final angle = random.nextDouble() * math.pi * 2;
      final speed = 5.0 + random.nextDouble() * 15.0;
      final color = [
        Colors.cyanAccent,
        Colors.greenAccent,
        Colors.yellowAccent,
        Colors.pinkAccent,
        Colors.white,
      ][random.nextInt(5)];

      add(WinParticle(
        position: position.clone(),
        velocity: Vector2(math.cos(angle) * speed, math.sin(angle) * speed),
        lifespan: 1.5 + random.nextDouble() * 1.0,
        color: color,
      ));
    }
  }
}

class WinParticle extends PositionComponent {
  Vector2 velocity;
  double lifespan;
  double _timer = 0;
  final Color color;

  WinParticle({
    required Vector2 position,
    required this.velocity,
    required this.lifespan,
    required this.color,
  }) : super(position: position);

  @override
  void update(double dt) {
    super.update(dt);
    _timer += dt;
    position += velocity * dt;
    velocity *= 0.98; // Air resistance
    velocity.y += 5 * dt; // Gravity effect
    
    if (_timer >= lifespan) {
      removeFromParent();
    }
  }

  @override
  void render(Canvas canvas) {
    final progress = _timer / lifespan;
    final alpha = (1.0 - progress).clamp(0.0, 1.0);
    final paint = Paint()
      ..color = color.withValues(alpha: alpha);
      
    // Rotate particle slightly for "confetti" feel
    canvas.save();
    canvas.rotate(_timer * 2);
    canvas.drawRect(Rect.fromCenter(center: Offset.zero, width: 0.3, height: 0.15), paint);
    canvas.restore();
  }
}
