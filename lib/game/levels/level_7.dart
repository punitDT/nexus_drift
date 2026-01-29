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
import 'package:nexus_drift/game/nexus_drift_game.dart';
import 'package:nexus_drift/game/controllers/game_controller.dart';
import 'package:get/get.dart';

class Level7 extends Component with HasGameReference<NexusDriftGame> {
  @override
  Future<void> onLoad() async {
    final controller = Get.find<GameController>();
    controller.setStartingFuel(62.0);
    controller.resetHealth();

    // 1. Spawn Drone (Top Left)
    final startPos = Vector2(-110.0, -35.0); 
    final p1Size = Vector2(25, 4);
    add(GamePlatform(position: startPos + Vector2(0, 4.5), size: p1Size)); 
    
    final drone = Drone(startPosition: startPos);
    game.drone = drone;
    add(drone);
    
    // 2. Solar Wind Zones (➤➤➤➤➤)
    // Zone 1: Early boost
    add(SolarWindZone(
      position: Vector2(-70.0, -10.0),
      size: Vector2(40, 20),
      windForce: Vector2(3000.0, 0), // Pushing right
    ));

    // Zone 2: Near Exit
    add(SolarWindZone(
      position: Vector2(80.0, 40.0),
      size: Vector2(40, 20),
      windForce: Vector2(3500.0, 0), // Pushing right
    ));

    // 3. Magnets
    // Magnet N (Attracts drone) - Top Right area
    add(MagneticCoil(
      position: Vector2(85.0, -15.0),
      radius: 40.0,
      strength: 4500.0,
      polarity: MagnetPolarity.north,
    ));
    
    // Magnet S (Repels drone) - Bottom Left area
    add(MagneticCoil(
      position: Vector2(-80.0, 40.0),
      radius: 45.0,
      strength: 5500.0,
      polarity: MagnetPolarity.south,
    ));

    // 4. Platforms & Hazards
    
    // Moving Platform A (Horizontal, High)
    add(MovingPlatform(
      position: Vector2(-50.0, -15.0),
      size: Vector2(25, 4),
      endPosition: Vector2(-10.0, -15.0),
      speed: 140.0,
    ));
    
    // Radiation Zone (Middle Corridor)
    add(RadiationZone(
      position: Vector2(15.0, 5.0),
      size: Vector2(50, 20),
      damageRate: 13.0,
    ));
    
    // Rotating Platform (Right Middle)
    add(RotatingPlatform(
      position: Vector2(60.0, 10.0),
      size: Vector2(30, 4),
      angularSpeed: 2.0,
    ));
    
    // Moving Platform B (Horizontal, Low)
    add(MovingPlatform(
      position: Vector2(75.0, 35.0),
      size: Vector2(25, 4),
      endPosition: Vector2(30.0, 35.0),
      speed: 110.0,
    ));
    
    // 5. Plasma Orbs (Must collect at least 3)
    // Orb 1: Near Start (Safe-ish)
    add(PlasmaOrb(
      position: Vector2(-40.0, -38.0),
      radius: 3.8,
      fuelAmount: 18.0,
    ));
    // Orb 2: risky, near radiation
    add(PlasmaOrb(
      position: Vector2(15.0, -15.0),
      radius: 3.8,
      fuelAmount: 18.0,
    ));
    // Orb 3: Near wind zone 2 / magnet
    add(PlasmaOrb(
      position: Vector2(90.0, 20.0),
      radius: 3.8,
      fuelAmount: 18.0,
    ));
    
    // 6. Exit Portal (Far Right Bottom)
    final portalPos = Vector2(115.0, 50.0);
    add(ExitPortal(
      position: portalPos, 
      onLevelComplete: game.onLevelComplete,
      size: Vector2(7.2, 7.2),
    ));
  }
}
