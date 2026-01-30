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
import 'package:nexus_drift/game/components/vanishing_platform.dart';
import 'package:nexus_drift/game/nexus_drift_game.dart';
import 'package:nexus_drift/game/controllers/game_controller.dart';
import 'package:get/get.dart';
import 'dart:math' as math;

class Level10 extends Component with HasGameReference<NexusDriftGame> {
  @override
  Future<void> onLoad() async {
    final controller = Get.find<GameController>();
    controller.setStartingFuel(55.0);
    controller.resetHealth();

    // 1. Spawn Drone (Top Left)
    final startPos = Vector2(-110.0, -45.0); 
    final p1Size = Vector2(25, 4);
    add(GamePlatform(position: startPos + Vector2(0, 4.5), size: p1Size)); 
    
    final drone = Drone(startPosition: startPos);
    game.drone = drone;
    add(drone);
    
    // 2. Black Holes (Double Danger)
    add(BlackHole(
      position: Vector2(30.0, 0.0),
      pullRadius: 50.0,
      horizonRadius: 6.0,
      maxPullForce: 7000.0,
    ));
    add(BlackHole(
      position: Vector2(80.0, 45.0),
      pullRadius: 45.0,
      horizonRadius: 5.5,
      maxPullForce: 8000.0,
    ));

    // 3. Solar Wind Zones (Intersecting Chaos)
    add(SolarWindZone(
      position: Vector2(-70.0, -20.0),
      size: Vector2(40, 20),
      windForce: Vector2(2500.0, 0),
    ));
    add(SolarWindZone(
      position: Vector2(10.0, -35.0),
      size: Vector2(60, 20),
      windForce: Vector2(0, 2000.0), // Downward push
    ));
    add(SolarWindZone(
      position: Vector2(100.0, 10.0),
      size: Vector2(30, 40),
      windForce: Vector2(-2000.0, 0), // Push back left
    ));

    // 4. Magnets
    add(MagneticCoil(
      position: Vector2(-30.0, 30.0),
      radius: 40.0,
      strength: 4500.0,
      polarity: MagnetPolarity.north,
    ));
    add(MagneticCoil(
      position: Vector2(60.0, -40.0),
      radius: 35.0,
      strength: 5000.0,
      polarity: MagnetPolarity.south,
    ));

    // 5. Debris Fields (Maximum Chaos)
    _spawnDebrisCluster(Vector2(-50.0, -10.0), 8);
    _spawnDebrisCluster(Vector2(20.0, 20.0), 10);
    _spawnDebrisCluster(Vector2(70.0, -20.0), 8);
    _spawnDebrisCluster(Vector2(110.0, 30.0), 6);

    // 6. Vanishing Platforms
    add(VanishingPlatform(
      position: Vector2(-15.0, -20.0),
      size: Vector2(20, 3),
      visibleDuration: 3.0,
      vanishDuration: 2.0,
    ));
    add(VanishingPlatform(
      position: Vector2(85.0, 15.0),
      size: Vector2(20, 3),
      visibleDuration: 3.0,
      vanishDuration: 2.0,
    ));

    // 7. Platforms & Hazards
    add(MovingPlatform(
      position: Vector2(-50.0, 25.0),
      size: Vector2(25, 4),
      endPosition: Vector2(10.0, 25.0),
      speed: 180.0,
    ));
    
    add(RadiationZone(
      position: Vector2(40.0, -15.0),
      size: Vector2(50, 12),
      damageRate: 16.0,
    ));
    
    add(RotatingPlatform(
      position: Vector2(70.0, 10.0),
      size: Vector2(30, 4),
      angularSpeed: 2.8,
    ));
    
    // 8. Plasma Orbs (Must collect 5)
    // 8. Plasma Orbs (Must collect 5)
    // Guide: 0.8-1.0x drone radius (2.5) -> ~2.0 - 2.5
    add(PlasmaOrb(position: Vector2(-60.0, -30.0), radius: 2.3, fuelAmount: 15.0));
    add(PlasmaOrb(position: Vector2(-15.0, 15.0), radius: 2.3, fuelAmount: 15.0));
    add(PlasmaOrb(position: Vector2(40.0, -45.0), radius: 2.3, fuelAmount: 15.0));
    add(PlasmaOrb(position: Vector2(90.0, -25.0), radius: 2.3, fuelAmount: 15.0));
    add(PlasmaOrb(position: Vector2(55.0, 50.0), radius: 2.3, fuelAmount: 15.0));
    
    // 9. Nexus Core Portal
    final portalPos = Vector2(115.0, 55.0);
    add(ExitPortal(
      position: portalPos, 
      onLevelComplete: game.onLevelComplete,
      size: Vector2(6.0, 6.0),
    ));
  }

  void _spawnDebrisCluster(Vector2 center, int count) {
    final random = math.Random();
    for (int i = 0; i < count; i++) {
        final offset = Vector2(
            (random.nextDouble() - 0.5) * 25,
            (random.nextDouble() - 0.5) * 25,
        );
        final velocity = Vector2(
            (random.nextDouble() - 0.5) * 350, // L10 chaos
            (random.nextDouble() - 0.5) * 350,
        );
        add(SpaceDebris(
            initialPosition: center + offset,
            initialVelocity: velocity,
            radius: 0.8 + random.nextDouble() * 0.8,
        ));
    }
  }
}
