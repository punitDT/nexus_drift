import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/input.dart';
import 'package:flame/experimental.dart'; // Added for Rectangle/Bounds
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';
import 'package:nexus_drift/game/components/drone.dart';
import 'package:nexus_drift/game/components/thrust_helper.dart';
import 'package:nexus_drift/game/levels/level_1.dart';
import 'package:nexus_drift/game/levels/level_2.dart';
import 'package:nexus_drift/game/levels/level_3.dart';
import 'package:nexus_drift/game/levels/level_4.dart';
import 'package:nexus_drift/game/levels/level_5.dart';
import 'package:nexus_drift/game/levels/level_6.dart';
import 'package:nexus_drift/game/levels/level_7.dart';
import 'package:nexus_drift/game/levels/level_8.dart';
import 'package:nexus_drift/game/levels/level_9.dart';
import 'package:nexus_drift/game/levels/level_10.dart';
import 'package:nexus_drift/game/levels/level_11.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nexus_drift/game/components/hint_arrow.dart';
import 'package:nexus_drift/game/controllers/game_controller.dart';
import 'package:nexus_drift/game/components/win_particles.dart';

class NexusDriftGame extends Forge2DGame with PanDetector {
  NexusDriftGame() : super(gravity: Vector2.zero());

  late final Drone drone;
  double elapsedTime = 0;
  
  // Drag State
  Vector2? _dragStart;
  Vector2? _currentDragPos;
  DateTime? _dragStartTime;
  
  Vector2? get dragStart => _dragStart;
  Vector2? get currentDragPos => _currentDragPos;
  DateTime? get dragStartTime => _dragStartTime;

  @override
  Color backgroundColor() => const Color(0xFF0F0F1A);

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    
    // Initialize Camera and Level
    _setupCamera();
    
    // Reset State
    final controller = Get.find<GameController>();
    
    // Add Selected Level to WORLD
    final level = controller.currentLevel.value;
    if (level == 1) {
      await world.add(Level1());
    } else if (level == 2) {
      await world.add(Level2());
    } else if (level == 3) {
      await world.add(Level3());
    } else if (level == 4) {
      await world.add(Level4());
    } else if (level == 5) {
      await world.add(Level5());
    } else if (level == 6) {
      await world.add(Level6());
    } else if (level == 7) {
      await world.add(Level7());
    } else if (level == 8) {
      await world.add(Level8());
    } else if (level == 9) {
      await world.add(Level9());
    } else if (level == 10) {
      await world.add(Level10());
    } else if (level == 11) {
      await world.add(Level11());
    } else {
      // Fallback or next levels
      await world.add(Level1());
    }
    
    // Reset Health
    controller.resetHealth();
    
    // Add Helpers
    world.add(ThrustHelper());
    world.add(HintArrow());

    // Camera following
    camera.follow(drone, maxSpeed: 100);
    if (controller.currentLevel.value != 11) {
      camera.setBounds(Rectangle.fromLTWH(-125, -60, 250, 120));
    }

    // HUD is now an Overlay (GameHud)
  }

  void _setupCamera() {
    // Level Bounds: 250 units wide, 120 units high.
    final double minWorldWidth = 250;
    final double minWorldHeight = 120;

    final double aspectRatio = ScreenUtil().screenWidth / ScreenUtil().screenHeight;
    
    // Determine visible size ensuring BOTH dimensions fit correctly
    double visibleWidth = minWorldWidth;
    double visibleHeight = visibleWidth / aspectRatio;
    
    if (visibleHeight < minWorldHeight) {
      visibleHeight = minWorldHeight;
      visibleWidth = visibleHeight * aspectRatio;
    }
    
    camera.viewfinder.visibleGameSize = Vector2(visibleWidth, visibleHeight);
    camera.viewfinder.position = Vector2.zero();
    camera.viewfinder.anchor = Anchor.center;
  }
  
  DateTime? _lastTapTime;
  
  @override
  void onPanDown(DragDownInfo info) {
    final controller = Get.find<GameController>();
    // If using buttons, ignore drag for thrust, but maybe allow other interactions?
    // For now, completely disable drag thrusts if buttons selected
    if (controller.controlType.value == 'buttons') return;

    if (drone.isMounted) {
      final now = DateTime.now();
      
      // Emergency Stop (Double Tap)
      if (_lastTapTime != null && now.difference(_lastTapTime!).inMilliseconds < 300) {
        if (controller.fuel.value > 0) { 
          drone.body.linearVelocity = Vector2.zero();
          controller.consumeFuel(5); 
        }
        _dragStart = null;
        return;
      }
      
      _lastTapTime = now;
      final worldPos = screenToWorld(info.eventPosition.widget);
      _dragStart = worldPos;
      _currentDragPos = worldPos;
      _dragStartTime = now;
    }
  }

  @override
  void onPanUpdate(DragUpdateInfo info) {
    final controller = Get.find<GameController>();
    if (controller.controlType.value == 'buttons') return;

    if (_dragStart != null) {
       final worldPos = screenToWorld(info.eventPosition.widget);
       _currentDragPos = worldPos;
    }
  }

  @override
  void onPanEnd(DragEndInfo info) {
    final controller = Get.find<GameController>();
    if (controller.controlType.value == 'buttons') return;

    if (_dragStart != null && _dragStartTime != null && drone.isMounted) {
      final targetPos = _currentDragPos ?? _dragStart!;
      final level = controller.currentLevel.value;
      
      final dragEnd = targetPos;
      final duration = DateTime.now().difference(_dragStartTime!).inMilliseconds / 1000.0;
      
      final direction = (dragEnd - drone.body.position).normalized();
      final clampedDuration = duration.clamp(0.1, 2.0); // Capped at 2 seconds
      
      // Power tuning: Fixed base power, scaled by duration
      final power = clampedDuration.clamp(0.1, 1.0) * 8000.0; 
      
      // Cost scaling: 
      final baseCost = level == 1 ? 4.0 : 8.0;
      final multiplier = level == 1 ? 20.0 : 25.0;
      final cost = baseCost + (clampedDuration.clamp(0.1, 1.0) - 0.1) * multiplier; 
      
      drone.applyThrust(direction * power, cost);
      
      _dragStart = null;
      _currentDragPos = null;
      _dragStartTime = null;
    }
  }

  // Called by UI Buttons
  void applyDirectionalThrust(Vector2 direction) {
    if (!drone.isMounted) return;
    
    // Fixed power for button taps (simulates a quick flick)
    // Reduced power for better control
    const double power = 1500.0; 
    const double cost = 5.0; 
    
    drone.applyThrust(direction * power, cost);
  }

  void emergencyStop() {
    final controller = Get.find<GameController>();
    if (controller.fuel.value > 0 && drone.isMounted) {
      drone.body.linearVelocity = Vector2.zero();
      controller.consumeFuel(5);
    }
  }
  
  String lossMessage = "Unknown Error";
  bool isGameOver = false;
  double _offScreenTime = 0;

  @override
  void update(double dt) {
    super.update(dt);
    elapsedTime += dt;
    if (isGameOver) return;

    final controller = Get.find<GameController>();
    
    // 1. Check Out of Fuel (Immediate as per guide)
    if (controller.fuel.value <= 0) {
       failLevel("OUT OF FUEL");
    }

    // 2. Check Radiation Damage
    if (controller.health.value <= 0) {
      failLevel("RADIATION OVERLOAD");
    }

    // 3. Check Lost in Space (Off-screen)
    final pos = drone.body.position;
    bool isOffScreen = false;
    
    if (controller.currentLevel.value == 11) {
       // In endless mode, only die if off-screen vertically or too far behind/ahead of camera
       // For now, let's just use vertical bounds and extreme horizontal relative to camera
       final camX = camera.viewfinder.position.x;
       if (pos.y < -75 || pos.y > 75 || (pos.x - camX).abs() > 200) {
         isOffScreen = true;
       }
    } else {
       if (pos.x < -140 || pos.x > 140 || pos.y < -75 || pos.y > 75) {
         isOffScreen = true;
       }
    }

    if (isOffScreen) {
      _offScreenTime += dt;
      if (_offScreenTime > (controller.currentLevel.value == 11 ? 2.8 : 4.0)) {
        failLevel("LOST IN SPACE");
      }
    } else {
      _offScreenTime = 0;
    }
  }

  void onLevelComplete() {
    if (isGameOver) return;
    // print("Level Complete!");
    isGameOver = true;
    
    final level = Get.find<GameController>().currentLevel.value;
    switch (level) {
      case 1:
        lossMessage = "Great First Drift!";
        break;
      case 2:
        lossMessage = "Perfect Timing!";
        break;
      case 3:
        lossMessage = "Orb Master!";
        break;
      case 4:
        lossMessage = "Chain Master!";
        break;
      case 5:
        lossMessage = "Hazard Avoided!";
        break;
      case 6:
        lossMessage = "Magnetic Master!";
        break;
      case 7:
        lossMessage = "Wind Rider!";
        break;
      case 8:
        lossMessage = "Void Survivor!";
        break;
      case 9:
        lossMessage = "Debris Dancer!";
        break;
      case 10:
        lossMessage = "Nexus Legend!";
        break;
      case 11:
        lossMessage = "Endless Legend!";
        break;
      default:
        lossMessage = "Sector Cleared!";
    }
    
    // Add Win Effects
    world.add(WinParticles(position: drone.body.position));
    
    Get.find<GameController>().nextLevel();
    overlays.add('win');
  }

  void failLevel(String message) {
    if (isGameOver) return;
    isGameOver = true;
    lossMessage = message;
    overlays.add('loss');
  }
}
