import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:nexus_drift/game/components/platform.dart';

class RotatingPlatform extends GamePlatform {
  final double angularSpeed;

  RotatingPlatform({
    required super.position,
    required super.size,
    this.angularSpeed = 1.0, // radians per second
  });

  @override
  Body createBody() {
    final shape = PolygonShape()..setAsBox(size.x / 2, size.y / 2, Vector2.zero(), 0);
    final fixtureDef = FixtureDef(shape)
      ..restitution = 1.0 
      ..friction = 1.0; // Higher friction to help "sticking"

    final bodyDef = BodyDef()
      ..position = position
      ..type = BodyType.kinematic;

    final body = world.createBody(bodyDef)..createFixture(fixtureDef);
    body.angularVelocity = angularSpeed;
    return body;
  }
}
