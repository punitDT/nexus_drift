import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class ThrusterParticles extends Component {
  final Vector2 position;
  final Vector2 direction;
  final double power;
  
  ThrusterParticles({
    required this.position,
    required this.direction,
    required this.power,
  });

  @override
  Future<void> onLoad() async {
    // Add multiple particles
    for (int i = 0; i < 15; i++) {
      add(ThrusterParticle(
        position: position.clone(),
        velocity: (-direction * (3 + math.Random().nextDouble() * power * 0.2)),
        lifespan: 0.3 + math.Random().nextDouble() * 0.4,
      ));
    }
  }
}

class ThrusterParticle extends PositionComponent {
  Vector2 velocity;
  double lifespan;
  double _timer = 0;

  ThrusterParticle({
    required Vector2 position,
    required this.velocity,
    required this.lifespan,
  }) : super(position: position);

  @override
  void update(double dt) {
    super.update(dt);
    _timer += dt;
    position += velocity * dt;
    if (_timer >= lifespan) {
      removeFromParent();
    }
  }

  @override
  void render(Canvas canvas) {
    final progress = _timer / lifespan;
    final alpha = (1.0 - progress).clamp(0.0, 1.0);
    final paint = Paint()
      ..color = Colors.orangeAccent.withValues(alpha: alpha * 0.8)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 0.1);
      
    canvas.drawCircle(Offset.zero, 0.15 * (1.0 - progress), paint);
  }
}
