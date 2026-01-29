import 'package:flame/components.dart';
import 'package:nexus_drift/game/components/drone.dart';
import 'package:nexus_drift/game/components/exit_portal.dart';
import 'package:nexus_drift/game/components/platform.dart';
import 'package:nexus_drift/game/components/plasma_orb.dart';
import 'package:nexus_drift/game/nexus_drift_game.dart';
import 'package:nexus_drift/game/controllers/game_controller.dart';
import 'package:get/get.dart';

class Level1 extends Component with HasGameReference<NexusDriftGame> {
  @override
  Future<void> onLoad() async {
    // Set Level 1 Fuel
    Get.find<GameController>().setStartingFuel(100.0);
    // World Bounds (Conceptual):
    // Width: -125 to 125 (250 units)
    // Height: -60 to 60 (120 units)
    
    final levelLeft = -125.0;
    final levelRight = 125.0;
    final levelTop = -60.0;
    final levelBottom = 60.0;
    final width = levelRight - levelLeft;
    final height = levelBottom - levelTop;
    
    // 1. Spawn Drone (Far Left)
    // 10% from left: -125 + 25 = -100
    final startPos = Vector2(-100.0, 0); 
    final p1Size = Vector2(30, 4);
    add(GamePlatform(position: startPos + Vector2(0, 4.5), size: p1Size)); // Platform touches drone bottom
    
    final drone = Drone(startPosition: startPos);
    game.drone = drone;
    add(drone);
    
    // 2. Plasma Orb
    // Position: (screen_width * 0.38, screen_height * 0.42) from top-left
    // x = -125 + 0.38 * 250 = -125 + 95 = -30
    // y = -60 + 0.42 * 120 = -60 + 50.4 = -9.6
    add(PlasmaOrb(
      position: Vector2(-30.0, -10.0),
      radius: 5.0, // 2.0x drone radius
      fuelAmount: 35.0,
    ));
    
    // 3. Platform 2 (Middle)
    // Around 60% from left, slightly lower
    // x = -125 + 0.6 * 250 = -125 + 150 = 25
    // y = 20
    add(GamePlatform(position: Vector2(25.0, 20.0), size: Vector2(30, 4)));
    
    // 4. Exit Portal (Far Right)
    // 85% from left: -125 + 0.85 * 250 = -125 + 212.5 = 87.5
    final portalPos = Vector2(90.0, 30.0);
    add(ExitPortal(
      position: portalPos, 
      onLevelComplete: game.onLevelComplete,
      size: Vector2(10.0, 10.0), // 2.0x drone diameter
    ));
    
    // 5. REMOVED BOUNDARY WALLS
    // In Level 1, we want the player to be able to drift off-screen to test the "Lost in Space" failure.
    // The previous walls were preventing this.
  }
}
