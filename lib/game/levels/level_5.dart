import 'package:flame/components.dart';
import 'package:nexus_drift/game/components/drone.dart';
import 'package:nexus_drift/game/components/exit_portal.dart';
import 'package:nexus_drift/game/components/moving_platform.dart';
import 'package:nexus_drift/game/components/platform.dart';
import 'package:nexus_drift/game/components/rotating_platform.dart';
import 'package:nexus_drift/game/components/plasma_orb.dart';
import 'package:nexus_drift/game/components/radiation_zone.dart';
import 'package:nexus_drift/game/nexus_drift_game.dart';
import 'package:nexus_drift/game/controllers/game_controller.dart';
import 'package:get/get.dart';

class Level5 extends Component with HasGameReference<NexusDriftGame> {
  @override
  Future<void> onLoad() async {
    // Set Level 5 Fuel
    final controller = Get.find<GameController>();
    controller.setStartingFuel(68.0);
    controller.resetHealth();

    // 1. Spawn Drone (Top Left)
    final startPos = Vector2(-110.0, -25.0); 
    final p1Size = Vector2(25, 4);
    add(GamePlatform(position: startPos + Vector2(0, 4.5), size: p1Size)); 
    
    final drone = Drone(startPosition: startPos);
    game.drone = drone;
    add(drone);
    
    // 2. Platforms & Hazards
    
    // Moving Platform A (Horizontal, High)
    add(MovingPlatform(
      position: Vector2(-50.0, -10.0),
      size: Vector2(25, 4),
      endPosition: Vector2(-10.0, -10.0),
      speed: 120.0,
    ));
    
    // Radiation Zone 1 (Between A and Rotating)
    add(RadiationZone(
      position: Vector2(0.0, 5.0),
      size: Vector2(40, 20),
      damageRate: 12.0,
    ));
    
    // Rotating Platform (Middle)
    add(RotatingPlatform(
      position: Vector2(40.0, 15.0),
      size: Vector2(30, 4),
      angularSpeed: 1.5, // rad/sec
    ));
    
    // Radiation Zone 2 (Near Moving B)
    add(RadiationZone(
      position: Vector2(60.0, 25.0),
      size: Vector2(30, 15),
      damageRate: 10.0,
    ));
    
    // Moving Platform B (Horizontal, Low)
    add(MovingPlatform(
      position: Vector2(70.0, 35.0),
      size: Vector2(25, 4),
      endPosition: Vector2(30.0, 35.0),
      speed: 90.0,
    ));
    
    // 3. Plasma Orbs
    // Orb 1: Safe near Start/A
    add(PlasmaOrb(
      position: Vector2(-30.0, -20.0),
      radius: 3.5, // 1.4x drone radius
      fuelAmount: 22.0,
    ));
    // Orb 2: Risky near Rotating / Hazard
    add(PlasmaOrb(
      position: Vector2(45.0, -5.0),
      radius: 3.5,
      fuelAmount: 22.0,
    ));
    
    // 4. Exit Portal (Far Right)
    final portalPos = Vector2(105.0, 45.0);
    add(ExitPortal(
      position: portalPos, 
      onLevelComplete: game.onLevelComplete,
      size: Vector2(6.75, 6.75), // 1.35x drone diameter
    ));
  }
}
