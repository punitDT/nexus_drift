import 'package:flame/components.dart';
import 'package:nexus_drift/game/components/drone.dart';
import 'package:nexus_drift/game/components/exit_portal.dart';
import 'package:nexus_drift/game/components/moving_platform.dart';
import 'package:nexus_drift/game/components/platform.dart';
import 'package:nexus_drift/game/components/rotating_platform.dart';
import 'package:nexus_drift/game/components/plasma_orb.dart';
import 'package:nexus_drift/game/components/radiation_zone.dart';
import 'package:nexus_drift/game/components/magnetic_coil.dart';
import 'package:nexus_drift/game/components/solar_wind_zone.dart';
import 'package:nexus_drift/game/components/black_hole.dart';
import 'package:nexus_drift/game/components/space_debris.dart';
import 'package:nexus_drift/game/nexus_drift_game.dart';
import 'package:nexus_drift/game/controllers/game_controller.dart';
import 'package:get/get.dart';
import 'dart:math' as math;

class Level9 extends Component with HasGameReference<NexusDriftGame> {
  @override
  Future<void> onLoad() async {
    final controller = Get.find<GameController>();
    controller.setStartingFuel(58.0);
    controller.resetHealth();

    // 1. Spawn Drone (Top Left)
    final startPos = Vector2(-110.0, -40.0); 
    final p1Size = Vector2(25, 4);
    add(GamePlatform(position: startPos + Vector2(0, 4.5), size: p1Size)); 
    
    final drone = Drone(startPosition: startPos);
    game.drone = drone;
    add(drone);
    
    // 2. Black Hole (The Void)
    add(BlackHole(
      position: Vector2(60.0, -10.0),
      pullRadius: 50.0,
      horizonRadius: 6.5,
      maxPullForce: 7500.0,
    ));

    // 3. Solar Wind Zones
    add(SolarWindZone(
      position: Vector2(-60.0, -15.0),
      size: Vector2(40, 20),
      windForce: Vector2(2000.0, 0),
    ));
    add(SolarWindZone(
      position: Vector2(20.0, 30.0),
      size: Vector2(50, 20),
      windForce: Vector2(0, -1500.0), // Upward push
    ));

    // 4. Magnets
    add(MagneticCoil(
      position: Vector2(-20.0, -30.0),
      radius: 35.0,
      strength: 4000.0,
      polarity: MagnetPolarity.north,
    ));
    add(MagneticCoil(
      position: Vector2(30.0, 45.0),
      radius: 40.0,
      strength: 4500.0,
      polarity: MagnetPolarity.south,
    ));

    // 5. Debris Clusters
    _spawnDebrisCluster(Vector2(-30.0, 0.0), 10);
    _spawnDebrisCluster(Vector2(40.0, 20.0), 8);
    _spawnDebrisCluster(Vector2(90.0, 50.0), 12);

    // 6. Platforms & Hazards
    add(MovingPlatform(
      position: Vector2(-50.0, 10.0),
      size: Vector2(25, 4),
      endPosition: Vector2(-10.0, 10.0),
      speed: 160.0,
    ));
    
    add(RadiationZone(
      position: Vector2(80.0, -30.0),
      size: Vector2(40, 15),
      damageRate: 14.0,
    ));
    
    add(RotatingPlatform(
      position: Vector2(20.0, -5.0),
      size: Vector2(30, 4),
      angularSpeed: 2.5,
    ));
    
    add(MovingPlatform(
      position: Vector2(70.0, 35.0),
      size: Vector2(25, 4),
      endPosition: Vector2(20.0, 35.0),
      speed: 130.0,
    ));
    
    // 7. Plasma Orbs (Must collect 4)
    add(PlasmaOrb(position: Vector2(-55.0, -35.0), radius: 3.2, fuelAmount: 16.0));
    add(PlasmaOrb(position: Vector2(20.0, -35.0), radius: 3.2, fuelAmount: 16.0));
    add(PlasmaOrb(position: Vector2(65.0, 15.0), radius: 3.2, fuelAmount: 16.0));
    add(PlasmaOrb(position: Vector2(95.0, -10.0), radius: 3.2, fuelAmount: 16.0));
    
    // 8. Exit Portal
    final portalPos = Vector2(110.0, 55.0);
    add(ExitPortal(
      position: portalPos, 
      onLevelComplete: game.onLevelComplete,
      size: Vector2(6.5, 6.5),
    ));
  }

  void _spawnDebrisCluster(Vector2 center, int count) {
    final random = math.Random();
    for (int i = 0; i < count; i++) {
        final offset = Vector2(
            (random.nextDouble() - 0.5) * 20,
            (random.nextDouble() - 0.5) * 20,
        );
        final velocity = Vector2(
            (random.nextDouble() - 0.5) * 40,
            (random.nextDouble() - 0.5) * 40,
        );
        add(SpaceDebris(
            initialPosition: center + offset,
            initialVelocity: velocity,
            radius: 1.0 + random.nextDouble() * 0.8,
        ));
    }
  }
}
