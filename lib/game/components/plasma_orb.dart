import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';
import 'package:nexus_drift/game/components/drone.dart';
import 'package:nexus_drift/game/components/orb_particles.dart';
import 'package:nexus_drift/game/nexus_drift_game.dart';

class PlasmaOrb extends BodyComponent with ContactCallbacks {
  final Vector2 position;
  final double radius;
  final double fuelAmount;
  bool collected = false;

  PlasmaOrb({
    required this.position,
    this.radius = 5.0,
    this.fuelAmount = 30.0,
  });

  @override
  Body createBody() {
    final shape = CircleShape()..radius = radius; 
    final fixtureDef = FixtureDef(shape)
      ..isSensor = true; 

    final bodyDef = BodyDef()
      ..position = position
      ..type = BodyType.static;

    final body = world.createBody(bodyDef);
    final fixture = body.createFixture(fixtureDef);
    fixture.userData = this; 
    return body;
  }

  @override
  void beginContact(Object other, Contact contact) {
    if (!isMounted) return;
    final nexusGame = game as NexusDriftGame;
    
    bool isDrone = other is Drone;
    if (!isDrone) {
      if (other == nexusGame.drone) {
        isDrone = true;
      }
    }

    if (isDrone && !collected) {
      collected = true;
      world.add(OrbParticles(position: body.position));
      removeFromParent();
      
      final drone = isDrone ? (other as Drone) : nexusGame.drone;
      drone.addFuel(fuelAmount); 
    }
  }

  @override
  void render(Canvas canvas) {
    canvas.save();
    canvas.translate(body.position.x, body.position.y);
    
    final accentColor = Colors.purpleAccent;
    
    // Outer Glow
    canvas.drawCircle(Offset.zero, radius, Paint()
      ..color = accentColor.withOpacity(0.2)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 2.0));

    // Mid Glow
    canvas.drawCircle(Offset.zero, radius * 0.7, Paint()
      ..color = accentColor.withOpacity(0.5)
      ..style = PaintingStyle.fill);
    
    // Core
    final paint = Paint()..color = Colors.white;
    canvas.drawCircle(Offset.zero, radius * 0.3, paint);
    
    canvas.restore();
  }
}
