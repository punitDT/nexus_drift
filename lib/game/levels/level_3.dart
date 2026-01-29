import 'package:flame/components.dart';
import 'package:nexus_drift/game/components/drone.dart';
import 'package:nexus_drift/game/components/exit_portal.dart';
import 'package:nexus_drift/game/components/platform.dart';
import 'package:nexus_drift/game/components/rotating_platform.dart';
import 'package:nexus_drift/game/components/plasma_orb.dart';
import 'package:nexus_drift/game/nexus_drift_game.dart';
import 'package:nexus_drift/game/controllers/game_controller.dart';
import 'package:get/get.dart';

class Level3 extends Component with HasGameReference<NexusDriftGame> {
  @override
  Future<void> onLoad() async {
    // Set Level 3 Fuel
    final controller = Get.find<GameController>();
    controller.setStartingFuel(75.0);

    // 1. Spawn Drone (Far Left)
    final startPos = Vector2(-100.0, 0); 
    final p1Size = Vector2(30, 4);
    add(GamePlatform(position: startPos + Vector2(0, 4.5), size: p1Size)); 
    
    final drone = Drone(startPosition: startPos);
    game.drone = drone;
    add(drone);
    
    // 2. Rotating Platform (Middle)
    // 60-90 degrees/sec -> approx 1.05 to 1.57 rad/sec
    add(RotatingPlatform(
      position: Vector2(-10.0, 25.0),
      size: Vector2(35, 4),
      angularSpeed: 1.25, // rad/sec
    ));
    
    // 3. Plasma Orbs
    // Orb 1: Near rotation edge
    add(PlasmaOrb(
      position: Vector2(-5.0, -10.0),
      radius: 4.0, // 1.6x drone radius
      fuelAmount: 25.0,
    ));
    // Orb 2: Opposite side/Near portal
    add(PlasmaOrb(
      position: Vector2(55.0, 10.0),
      radius: 4.0,
      fuelAmount: 28.0,
    ));
    
    // 4. Exit Portal (Far Right)
    final portalPos = Vector2(95.0, 35.0);
    add(ExitPortal(
      position: portalPos, 
      onLevelComplete: game.onLevelComplete,
      size: Vector2(8.0, 8.0), // 1.6x drone diameter
    ));
  }
}
