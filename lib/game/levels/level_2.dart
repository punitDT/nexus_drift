import 'package:flame/components.dart';
import 'package:nexus_drift/game/components/drone.dart';
import 'package:nexus_drift/game/components/exit_portal.dart';
import 'package:nexus_drift/game/components/platform.dart';
import 'package:nexus_drift/game/components/moving_platform.dart';
import 'package:nexus_drift/game/components/plasma_orb.dart';
import 'package:nexus_drift/game/nexus_drift_game.dart';
import 'package:nexus_drift/game/controllers/game_controller.dart';
import 'package:get/get.dart';

class Level2 extends Component with HasGameReference<NexusDriftGame> {
  @override
  Future<void> onLoad() async {
    // World Bounds: Width: 250, Height: 120
    
    // Set Level 2 Fuel
    final controller = Get.find<GameController>();
    controller.setStartingFuel(85.0);

    // 1. Spawn Drone (Far Left)
    final startPos = Vector2(-100.0, 0); 
    final p1Size = Vector2(30, 4);
    add(GamePlatform(position: startPos + Vector2(0, 4.5), size: p1Size)); 
    
    final drone = Drone(startPosition: startPos);
    game.drone = drone;
    add(drone);
    
    // 2. Moving Platform (Middle)
    // Oscillates between x=-30 and x=40 at y=20
    add(MovingPlatform(
      position: Vector2(-30.0, 20.0),
      size: Vector2(25, 4),
      endPosition: Vector2(40.0, 20.0),
      speed: 25.0, // px/sec
    ));
    
    // 3. Plasma Orbs
    // Orb 1: Predictive path
    add(PlasmaOrb(
      position: Vector2(-20.0, -15.0),
      radius: 4.5, // 1.8x drone radius
      fuelAmount: 25.0,
    ));
    // Orb 2: Near the end
    add(PlasmaOrb(
      position: Vector2(50.0, -5.0),
      radius: 4.5,
      fuelAmount: 25.0,
    ));
    
    // 4. Exit Portal (Far Right)
    final portalPos = Vector2(95.0, 35.0);
    add(ExitPortal(
      position: portalPos, 
      onLevelComplete: game.onLevelComplete,
      size: Vector2(9.0, 9.0), // 1.8x drone diameter
    ));
  }
}
