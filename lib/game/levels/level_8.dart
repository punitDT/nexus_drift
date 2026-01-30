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
    
    // 2. Black Hole (The Void) - Right Center
    add(BlackHole(
      position: Vector2(75.0, 5.0), // Shifted left to fit sequence
      pullRadius: 50.0,
      horizonRadius: 9.0,
      maxPullForce: 8500.0,
    ));

    // 3. Solar Wind Zones
    // Early wind pushing RIGHT (Start)
    add(SolarWindZone(
      position: Vector2(-60.0, -10.0),
      size: Vector2(45, 20),
      // Force 1500 px/s / mass 20 = 75 px/s?? No, windForce is force. 
      // Guide says 100-180 px/s push. 
      // If mass=20, force needs to be 2000-3600.
      windForce: Vector2(3000.0, 0),
    ));
    // Late wind pushing RIGHT (End, per ➤➤➤)
    add(SolarWindZone(
      position: Vector2(110.0, 35.0), // Far right
      size: Vector2(30, 25),
      windForce: Vector2(3000.0, 0),
    ));

    // 4. Magnets
    // Magnet N (Attract) - Left Side
    add(MagneticCoil(
      position: Vector2(-15.0, 10.0),
      radius: 35.0,
      strength: 4200.0,
      polarity: MagnetPolarity.north,
    ));
    
    // Magnet S (Repel) - Right Side (Before Exit)
    add(MagneticCoil(
      position: Vector2(95.0, -5.0),
      radius: 38.0,
      strength: 4800.0,
      polarity: MagnetPolarity.south,
    ));

    // 5. Platforms & Hazards
    add(MovingPlatform(
      position: Vector2(-45.0, -15.0),
      size: Vector2(25, 4),
      endPosition: Vector2(-5.0, -15.0),
      speed: 150.0,
    ));
    
    // Radiation Zone (Middle Corridor)
    add(RadiationZone(
      position: Vector2(15.0, -25.0),
      size: Vector2(50, 12),
      damageRate: 15.0,
    ));
    
    // Rotating Platform (Center Right)
    add(RotatingPlatform(
      position: Vector2(40.0, -5.0), // Before Black Hole
      size: Vector2(28, 4),
      angularSpeed: 2.3,
    ));
    
    // Moving Platform B (Bottom)
    add(MovingPlatform(
      position: Vector2(35.0, 35.0),
      size: Vector2(25, 4),
      endPosition: Vector2(-15.0, 35.0),
      speed: 120.0,
    ));
    
    // 6. Plasma Orbs
    // Orb 1: High Left (per ASCII *)
    add(PlasmaOrb(
      position: Vector2(-90.0, -45.0),
      radius: 3.5,
      fuelAmount: 18.0,
    ));
    // Orb 2: Below Radiation/Rotating (per ASCII *)
    add(PlasmaOrb(
      position: Vector2(30.0, 20.0),
      radius: 3.5,
      fuelAmount: 18.0,
    ));
    // Orb 3: Risky near Black Hole (The 3rd orb)
    add(PlasmaOrb(
      position: Vector2(75.0, 35.0), // Directly under BH
      radius: 3.5,
      fuelAmount: 18.0,
    ));
    
    // 7. Exit Portal (Far Right)
    final portalPos = Vector2(120.0, 45.0);
    add(ExitPortal(
      position: portalPos, 
      onLevelComplete: game.onLevelComplete,
      size: Vector2(6.0, 6.0), // 1.2x drone diameter (5.0)
    ));
  }
}
