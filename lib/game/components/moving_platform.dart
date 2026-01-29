import 'package:flame/extensions.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';
import 'package:nexus_drift/game/components/platform.dart';

class MovingPlatform extends GamePlatform {
  final Vector2 endPosition;
  final double speed;
  
  late Vector2 _startPosition;
  late Vector2 _targetPosition;
  bool _movingToEnd = true;

  MovingPlatform({
    required super.position,
    required super.size,
    required this.endPosition,
    this.speed = 80.0,
  });

  @override
  Body createBody() {
    _startPosition = position.clone();
    _targetPosition = endPosition.clone();

    final shape = PolygonShape()..setAsBox(size.x / 2, size.y / 2, Vector2.zero(), 0);
    final fixtureDef = FixtureDef(shape)
      ..restitution = 1.0 
      ..friction = 0.0;

    final bodyDef = BodyDef()
      ..position = position
      ..type = BodyType.kinematic; // Kinematic bodies can have velocity but aren't affected by forces

    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }

  @override
  void update(double dt) {
    super.update(dt);

    final currentPos = body.position;
    final distToTarget = (currentPos - _targetPosition).length;

    if (distToTarget < 0.5) {
      // Switch direction
      _movingToEnd = !_movingToEnd;
      _targetPosition = _movingToEnd ? endPosition : _startPosition;
    }

    final direction = (_targetPosition - currentPos).normalized();
    body.linearVelocity = direction * speed;
  }
}
