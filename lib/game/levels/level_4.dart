import 'package:flame/components.dart';
import 'package:nexus_drift/game/components/drone.dart';
import 'package:nexus_drift/game/components/exit_portal.dart';
import 'package:nexus_drift/game/components/moving_platform.dart';
import 'package:nexus_drift/game/components/platform.dart';
import 'package:nexus_drift/game/components/rotating_platform.dart';
import 'package:nexus_drift/game/components/plasma_orb.dart';
import 'package:nexus_drift/game/nexus_drift_game.dart';
import 'package:nexus_drift/game/controllers/game_controller.dart';
import 'package:get/get.dart';

class Level4 extends Component with HasGameReference<NexusDriftGame> {
  @override
  Future<void> onLoad() async {
    // Set Level 4 Fuel
    final controller = Get.find<GameController>();
    controller.setStartingFuel(70.0);

    // 1. Spawn Drone (Top Left)
    final startPos = Vector2(-110.0, -30.0); 
    final p1Size = Vector2(25, 4);
    add(GamePlatform(position: startPos + Vector2(0, 4.5), size: p1Size)); 
    
    final drone = Drone(startPosition: startPos);
    game.drone = drone;
    add(drone);
    
    // 2. Chained Platforms
    
    // Moving Platform A (Horizontal, High)
    add(MovingPlatform(
      position: Vector2(-60.0, -10.0),
      size: Vector2(25, 4),
      endPosition: Vector2(-20.0, -10.0),
      speed: 100.0,
    ));
    
    // Rotating Platform (Middle)
    add(RotatingPlatform(
      position: Vector2(20.0, 10.0),
      size: Vector2(30, 4),
      angularSpeed: 1.4, // rad/sec
    ));
    
    // Moving Platform B (Horizontal, Low, Opposite phase)
    add(MovingPlatform(
      position: Vector2(60.0, 30.0),
      size: Vector2(25, 4),
      endPosition: Vector2(20.0, 30.0),
      speed: 80.0,
    ));
    
    // 3. Plasma Orbs
    // Orb 1: Near Moving A
    add(PlasmaOrb(
      position: Vector2(-40.0, -25.0),
      radius: 3.8, // 1.5x drone radius
      fuelAmount: 24.0,
    ));
    // Orb 2: Near Rotating
    add(PlasmaOrb(
      position: Vector2(25.0, -5.0),
      radius: 3.8,
      fuelAmount: 24.0,
    ));
    // Orb 3: Near Moving B
    add(PlasmaOrb(
      position: Vector2(70.0, 15.0),
      radius: 3.8,
      fuelAmount: 25.0,
    ));
    
    // 4. Exit Portal (Far Right)
    final portalPos = Vector2(100.0, 40.0);
    add(ExitPortal(
      position: portalPos, 
      onLevelComplete: game.onLevelComplete,
      size: Vector2(7.5, 7.5), // 1.5x drone diameter
    ));
  }
}
