import 'package:flame/components.dart';
import 'package:nexus_drift/game/components/drone.dart';
import 'package:nexus_drift/game/components/exit_portal.dart';
import 'package:nexus_drift/game/components/moving_platform.dart';
import 'package:nexus_drift/game/components/platform.dart';
import 'package:nexus_drift/game/components/rotating_platform.dart';
import 'package:nexus_drift/game/components/plasma_orb.dart';
import 'package:nexus_drift/game/components/radiation_zone.dart';
import 'package:nexus_drift/game/components/magnetic_coil.dart';
import 'package:nexus_drift/game/nexus_drift_game.dart';
import 'package:nexus_drift/game/controllers/game_controller.dart';
import 'package:get/get.dart';

class Level6 extends Component with HasGameReference<NexusDriftGame> {
  @override
  Future<void> onLoad() async {
    // Set Level 6 Fuel
    final controller = Get.find<GameController>();
    controller.setStartingFuel(65.0);
    controller.resetHealth();

    // 1. Spawn Drone (Top Left)
    final startPos = Vector2(-110.0, -40.0); 
    final p1Size = Vector2(25, 4);
    add(GamePlatform(position: startPos + Vector2(0, 4.5), size: p1Size)); 
    
    final drone = Drone(startPosition: startPos);
    game.drone = drone;
    add(drone);
    
    // 2. Magnets
    // Magnet N (Attracts drone)
    add(MagneticCoil(
      position: Vector2(-80.0, -10.0),
      radius: 40.0,
      strength: 4000.0, // 4000 / 20 mass = 200 acc (Matches guide)
      polarity: MagnetPolarity.north,
    ));
    
    // Magnet S (Repels drone)
    add(MagneticCoil(
      position: Vector2(70.0, 50.0),
      radius: 45.0,
      strength: 5000.0,
      polarity: MagnetPolarity.south,
    ));

    // 3. Platforms & Hazards
    
    // Moving Platform A (Horizontal, High)
    add(MovingPlatform(
      position: Vector2(-50.0, -20.0),
      size: Vector2(25, 4),
      endPosition: Vector2(-10.0, -20.0),
      speed: 130.0,
    ));
    
    // Radiation Zone (Middle)
    add(RadiationZone(
      position: Vector2(10.0, 10.0),
      size: Vector2(45, 25),
      damageRate: 11.0,
    ));
    
    // Rotating Platform (Middle Right)
    add(RotatingPlatform(
      position: Vector2(50.0, 15.0),
      size: Vector2(30, 4),
      angularSpeed: 1.8,
    ));
    
    // Moving Platform B (Horizontal, Low)
    add(MovingPlatform(
      position: Vector2(80.0, 40.0),
      size: Vector2(25, 4),
      endPosition: Vector2(35.0, 40.0),
      speed: 100.0,
    ));
    
    // 4. Plasma Orbs
    // Orb 1: Safe curve path (High, per ASCII)
    add(PlasmaOrb(
      position: Vector2(-80.0, -50.0),
      radius: 3.5, // 1.4x drone radius (2.5) -> 3.5
      fuelAmount: 20.0,
    ));
    // Orb 2: Risky path near rotating (Magnet-adjacent)
    add(PlasmaOrb(
      position: Vector2(70.0, 30.0),
      radius: 3.5,
      fuelAmount: 20.0,
    ));
    
    // 5. Exit Portal (Far Right)
    final portalPos = Vector2(110.0, 55.0);
    add(ExitPortal(
      position: portalPos, 
      onLevelComplete: game.onLevelComplete,
      size: Vector2(7.5, 7.5),
    ));
  }
}
