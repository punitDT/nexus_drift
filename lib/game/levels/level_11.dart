import 'dart:math' as math;
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
import 'package:nexus_drift/game/components/vanishing_platform.dart';
import 'package:nexus_drift/game/components/wormhole.dart';
import 'package:nexus_drift/game/nexus_drift_game.dart';
import 'package:nexus_drift/game/controllers/game_controller.dart';
import 'package:get/get.dart';

class Level11 extends Component with HasGameReference<NexusDriftGame> {
  late final GameController _controller;
  final math.Random _random = math.Random();
  
  double _lastSegmentEndX = -120.0;
  final double _segmentWidth = 200.0;
  int _waveCount = 0;
  double _difficultyScale = 1.0;

  @override
  Future<void> onLoad() async {
    _controller = Get.find<GameController>();
    _controller.setStartingFuel(50.0);
    _controller.resetHealth();
    _controller.wavesSurvived.value = 0;
    _controller.distanceTravelled.value = 0;
    _controller.scoreMultiplier.value = 1.0;

    // 1. Spawn Initial Platform & Drone
    final startPos = Vector2(-110.0, 0.0);
    add(GamePlatform(position: startPos + Vector2(0, 4.5), size: Vector2(30, 4)));
    
    final drone = Drone(startPosition: startPos);
    game.drone = drone;
    add(drone);

    // Initial Segments
    _spawnNextSegment();
    _spawnNextSegment();
  }

  void _spawnNextSegment() {
    _waveCount++;
    _difficultyScale = 1.0 + (_waveCount * 0.08);
    
    final startX = _lastSegmentEndX;
    final endX = startX + _segmentWidth;
    
    // Choose a "theme" for this segment
    final theme = _random.nextInt(6);
    
    switch (theme) {
      case 0: // Magnetic Chaos
        _spawnMagneticSegment(startX, endX);
        break;
      case 1: // Wind & Radiation
        _spawnWindRadiationSegment(startX, endX);
        break;
      case 2: // The Void (Black Holes)
        _spawnVoidSegment(startX, endX);
        break;
      case 3: // Debris Field
        _spawnDebrisSegment(startX, endX);
        break;
      case 4: // Vanishing Maze
        _spawnVanishingSegment(startX, endX);
        break;
      case 5: // Platform Chain
        _spawnPlatformSegment(startX, endX);
        break;
    }

    // Rare Event: Wormhole (10% chance)
    if (_random.nextDouble() < 0.1) {
       add(Wormhole(
         position: Vector2(startX + _random.nextDouble() * _segmentWidth, (_random.nextDouble() - 0.5) * 60),
         radius: 4.0,
       ));
    }

    // Always spawn some Orbs for fuel
    _spawnOrbs(startX, endX);
    
    // Spawn transition portal at the end of segment
    add(ExitPortal(
      position: Vector2(endX - 10, (_random.nextDouble() - 0.5) * 80),
      onLevelComplete: _onWaveComplete,
      size: Vector2(7, 7) / (_difficultyScale * 0.5).clamp(1.0, 1.5),
    ));

    _lastSegmentEndX = endX;
  }

  void _onWaveComplete() {
    _controller.wavesSurvived.value++;
    _controller.addFuel(15.0); // Reward for segment
    _controller.addScore(500);
    
    // Scaling message or effect could go here
    _spawnNextSegment();
  }

  // --- Segment Generators ---

  void _spawnMagneticSegment(double startX, double endX) {
    for (int i = 0; i < 2; i++) {
      add(MagneticCoil(
        position: Vector2(startX + 50 + (i * 80), (_random.nextDouble() - 0.5) * 80),
        radius: 35.0,
        strength: 3500.0 * _difficultyScale,
        polarity: _random.nextBool() ? MagnetPolarity.north : MagnetPolarity.south,
      ));
    }
  }

  void _spawnWindRadiationSegment(double startX, double endX) {
    add(SolarWindZone(
      position: Vector2(startX + 100, 0),
      size: Vector2(100, 100),
      windForce: Vector2(_random.nextDouble() * 2000 * _difficultyScale * (_random.nextBool() ? 1 : -1), 
                         _random.nextDouble() * 1000 * _difficultyScale * (_random.nextBool() ? 1 : -1)),
    ));
    
    add(RadiationZone(
      position: Vector2(startX + 100, (_random.nextDouble() - 0.5) * 60),
      size: Vector2(60, 30),
      damageRate: 10.0 * _difficultyScale,
    ));
  }

  void _spawnVoidSegment(double startX, double endX) {
    add(BlackHole(
      position: Vector2(startX + 100, (_random.nextDouble() - 0.5) * 40),
      pullRadius: 50.0,
      horizonRadius: 6.0 * _difficultyScale.clamp(1.0, 1.5),
      maxPullForce: 6000.0 * _difficultyScale,
    ));
  }

  void _spawnDebrisSegment(double startX, double endX) {
    final center = Vector2(startX + 100, 0);
    final count = (10 * _difficultyScale).toInt();
    for (int i = 0; i < count; i++) {
        final offset = Vector2((_random.nextDouble() - 0.5) * 100, (_random.nextDouble() - 0.5) * 100);
        final vel = Vector2((_random.nextDouble() - 0.5) * 300 * _difficultyScale, (_random.nextDouble() - 0.5) * 300 * _difficultyScale);
        add(SpaceDebris(
            initialPosition: center + offset,
            initialVelocity: vel,
            radius: 1.0 + _random.nextDouble(),
        ));
    }
  }

  void _spawnVanishingSegment(double startX, double endX) {
    for (int i = 0; i < 3; i++) {
      add(VanishingPlatform(
        position: Vector2(startX + 40 + (i * 60), (_random.nextDouble() - 0.5) * 70),
        size: Vector2(25, 4),
        visibleDuration: (3.5 / _difficultyScale).clamp(1.5, 3.5),
        vanishDuration: 2.0,
      ));
    }
  }
  void _spawnPlatformSegment(double startX, double endX) {
    add(MovingPlatform(
      position: Vector2(startX + 50, -20),
      size: Vector2(25, 4),
      endPosition: Vector2(startX + 50, 20),
      speed: 100 * _difficultyScale,
    ));
    
    add(RotatingPlatform(
      position: Vector2(startX + 120, 0),
      size: Vector2(30, 4),
      angularSpeed: 2.0 * _difficultyScale,
    ));
    
    add(MovingPlatform(
      position: Vector2(startX + 180, 20),
      size: Vector2(25, 4),
      endPosition: Vector2(startX + 180, -20),
      speed: 120 * _difficultyScale,
    ));
  }

  void _spawnOrbs(double startX, double endX) {
    final count = 3 + _random.nextInt(3);
    for (int i = 0; i < count; i++) {
      add(PlasmaOrb(
        position: Vector2(startX + _random.nextDouble() * _segmentWidth, (_random.nextDouble() - 0.5) * 90),
        // Guide: 0.7-1.0x (1.75 - 2.5)
        radius: (2.5 / (_waveCount * 0.05 + 1)).clamp(1.75, 2.5),
        fuelAmount: 15.0,
      ));
    }
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (!game.drone.isMounted) return;
    
    // Update distance
    final droneX = game.drone.body.position.x;
    if (droneX + 110 > _controller.distanceTravelled.value) {
       _controller.distanceTravelled.value = droneX + 110;
    }

    // Cleanup: Remove components that are far behind the drone (e.g. 300 units)
    // Actually, in Forge2D, we should be careful about removing bodies during world step.
    // Flame handles this if we use removeFromParent().
    // But for a true endless mode, we'd need to prune components.
    // I'll skip pruning for now unless performance is an issue, to keep implementation simple.
  }
}
