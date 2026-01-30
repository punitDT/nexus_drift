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
    
    // 2. Black Hole (The Void) - Top Right End of Top Lane
    add(BlackHole(
      position: Vector2(90.0, -15.0), 
      pullRadius: 45.0,
      horizonRadius: 6.0,
      maxPullForce: 7500.0,
    ));

    // 3. Solar Wind Zones
    // Top Lane Wind (Push Right)
    add(SolarWindZone(
      position: Vector2(10.0, -15.0),
      size: Vector2(30, 15),
      windForce: Vector2(2000.0, 0),
    ));
    // Middle/Bottom Lane Wind (Start Left, Push Right)
    add(SolarWindZone(
      position: Vector2(-70.0, 20.0),
      size: Vector2(30, 20),
      windForce: Vector2(2000.0, 0), 
    ));

    // 4. Magnets
    // Magnet N (Top Lane)
    add(MagneticCoil(
      position: Vector2(50.0, -25.0),
      radius: 30.0,
      strength: 4000.0,
      polarity: MagnetPolarity.north,
    ));
    // Magnet S (Bottom Lane, below Rad/Rot)
    add(MagneticCoil(
      position: Vector2(-30.0, 45.0),
      radius: 35.0,
      strength: 4500.0,
      polarity: MagnetPolarity.south,
    ));

    // 5. Debris Clusters
    _spawnDebrisCluster(Vector2(-20.0, -15.0), 8); // Top Lane Debris
    _spawnDebrisCluster(Vector2(40.0, 25.0), 10);  // Middle Lane Debris
    _spawnDebrisCluster(Vector2(60.0, 45.0), 8);   // Bottom/Exit Debris

    // 6. Platforms & Hazards
    // Moving A (Top Lane Start)
    add(MovingPlatform(
      position: Vector2(-50.0, -15.0),
      size: Vector2(25, 4),
      endPosition: Vector2(-30.0, -15.0),
      speed: 150.0,
    ));
    
    // Radiation Zone 1 (Middle Lane)
    add(RadiationZone(
      position: Vector2(-30.0, 20.0),
      size: Vector2(35, 12),
      damageRate: 14.0,
    ));
    
    // Rotating Platform (Middle Lane)
    add(RotatingPlatform(
      position: Vector2(10.0, 20.0),
      size: Vector2(30, 4),
      angularSpeed: 2.5,
    ));

    // Radiation Zone 2 (Middle/Right Lane)
    add(RadiationZone(
      position: Vector2(80.0, 25.0),
      size: Vector2(40, 15),
      damageRate: 14.0,
    ));
    
    // Moving B (Bottom Lane)
    add(MovingPlatform(
      position: Vector2(20.0, 40.0),
      size: Vector2(25, 4),
      endPosition: Vector2(50.0, 40.0),
      speed: 130.0,
    ));
    
    // 7. Plasma Orbs (Must collect 4)
    // Guide: 0.9-1.1x drone radius (2.5) -> ~2.3 - 2.75
    add(PlasmaOrb(position: Vector2(-55.0, -35.0), radius: 2.6, fuelAmount: 16.0)); // Top Left Safe
    add(PlasmaOrb(position: Vector2(0.0, 40.0), radius: 2.6, fuelAmount: 16.0));    // Bottom/Mag S
    add(PlasmaOrb(position: Vector2(30.0, -5.0), radius: 2.6, fuelAmount: 16.0));   // Between Top/Mid
    add(PlasmaOrb(position: Vector2(95.0, -10.0), radius: 2.6, fuelAmount: 16.0));  // Near Hole
    
    // 8. Exit Portal
    // Distance -110 to 120 = 230 (92% of 250). Guide: 92-100%
    final portalPos = Vector2(120.0, 55.0);
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
            (random.nextDouble() - 0.5) * 300, // Range -150 to 150. Mag avg ~100-200.
            (random.nextDouble() - 0.5) * 300,
        );
        add(SpaceDebris(
            initialPosition: center + offset,
            initialVelocity: velocity,
            radius: 1.0 + random.nextDouble() * 0.8,
        ));
    }
  }
}
