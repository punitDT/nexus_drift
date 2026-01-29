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
import 'package:nexus_drift/game/nexus_drift_game.dart';
import 'package:nexus_drift/game/controllers/game_controller.dart';
import 'package:get/get.dart';

class Level8 extends Component with HasGameReference<NexusDriftGame> {
  @override
  Future<void> onLoad() async {
    final controller = Get.find<GameController>();
    controller.setStartingFuel(60.0);
    controller.resetHealth();

    // 1. Spawn Drone (Top Left)
    final startPos = Vector2(-110.0, -35.0); 
    final p1Size = Vector2(25, 4);
    add(GamePlatform(position: startPos + Vector2(0, 4.5), size: p1Size)); 
    
    final drone = Drone(startPosition: startPos);
    game.drone = drone;
    add(drone);
    
    // 2. Black Hole (The Void) - Central
    add(BlackHole(
      position: Vector2(30.0, 10.0),
      pullRadius: 55.0,
      horizonRadius: 7.0,
      maxPullForce: 8000.0,
    ));

    // 3. Solar Wind Zones
    // Early wind pushing RIGHT
    add(SolarWindZone(
      position: Vector2(-60.0, -15.0),
      size: Vector2(40, 20),
      windForce: Vector2(2500.0, 0),
    ));
    // Late wind pushing UP/RIGHT near exit
    add(SolarWindZone(
      position: Vector2(90.0, 30.0),
      size: Vector2(30, 30),
      windForce: Vector2(2000.0, -1000.0),
    ));

    // 4. Magnets
    // Magnet N (Attract) near Rotating
    add(MagneticCoil(
      position: Vector2(-20.0, 15.0),
      radius: 35.0,
      strength: 4000.0,
      polarity: MagnetPolarity.north,
    ));
    
    // Magnet S (Repel) near Exit
    add(MagneticCoil(
      position: Vector2(100.0, 0.0),
      radius: 40.0,
      strength: 5000.0,
      polarity: MagnetPolarity.south,
    ));

    // 5. Platforms & Hazards
    
    // Moving Platform A (Top-ish)
    add(MovingPlatform(
      position: Vector2(-50.0, -10.0),
      size: Vector2(25, 4),
      endPosition: Vector2(-10.0, -10.0),
      speed: 150.0,
    ));
    
    // Radiation Zone (Narrow corridor above Black Hole)
    add(RadiationZone(
      position: Vector2(20.0, -20.0),
      size: Vector2(60, 10),
      damageRate: 15.0,
    ));
    
    // Rotating Platform (Middle Right)
    add(RotatingPlatform(
      position: Vector2(70.0, -5.0),
      size: Vector2(30, 4),
      angularSpeed: 2.2,
    ));
    
    // Moving Platform B (Bottom)
    add(MovingPlatform(
      position: Vector2(20.0, 40.0),
      size: Vector2(25, 4),
      endPosition: Vector2(-30.0, 40.0),
      speed: 120.0,
    ));
    
    // 6. Plasma Orbs (Must collect 3)
    // Orb 1: Risky near start wind
    add(PlasmaOrb(
      position: Vector2(-45.0, -30.0),
      radius: 3.5,
      fuelAmount: 18.0,
    ));
    // Orb 2: Risky near Black Hole influence
    add(PlasmaOrb(
      position: Vector2(50.0, 25.0),
      radius: 3.5,
      fuelAmount: 18.0,
    ));
    // Orb 3: Near Rotating / Radiation
    add(PlasmaOrb(
      position: Vector2(80.0, -25.0),
      radius: 3.5,
      fuelAmount: 18.0,
    ));
    
    // 7. Exit Portal (Far Right Bottom)
    final portalPos = Vector2(115.0, 45.0);
    add(ExitPortal(
      position: portalPos, 
      onLevelComplete: game.onLevelComplete,
      size: Vector2(7.0, 7.0),
    ));
  }
}
