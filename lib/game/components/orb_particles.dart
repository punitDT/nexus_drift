import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class OrbParticles extends Component {
  final Vector2 position;
  
  OrbParticles({required this.position});

  @override
  Future<void> onLoad() async {
    for (int i = 0; i < 20; i++) {
      final angle = math.Random().nextDouble() * math.pi * 2;
      final speed = 2.0 + math.Random().nextDouble() * 5.0;
      add(OrbParticle(
        position: position.clone(),
        velocity: Vector2(math.cos(angle) * speed, math.sin(angle) * speed),
        lifespan: 0.8,
      ));
    }
  }
}

class OrbParticle extends PositionComponent {
  Vector2 velocity;
  double lifespan;
  double _timer = 0;

  OrbParticle({
    required Vector2 position,
    required this.velocity,
    required this.lifespan,
  }) : super(position: position);

  @override
  void update(double dt) {
    super.update(dt);
    _timer += dt;
    position += velocity * dt;
    velocity *= 0.95; // Damping
    if (_timer >= lifespan) {
      removeFromParent();
    }
  }

  @override
  void render(Canvas canvas) {
    final progress = _timer / lifespan;
    final alpha = (1.0 - progress).clamp(0.0, 1.0);
    final paint = Paint()
      ..color = Colors.purpleAccent.withValues(alpha: alpha)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 0.2);
      
    canvas.drawCircle(Offset.zero, 0.2 * (1.0 - progress), paint);
  }
}
