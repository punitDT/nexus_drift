import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nexus_drift/game/nexus_drift_game.dart';
import 'package:flame/components.dart';
import 'package:nexus_drift/game/components/drone.dart';
import 'package:nexus_drift/game/components/platform.dart';
import 'package:nexus_drift/game/components/moving_platform.dart';
import 'package:nexus_drift/game/components/plasma_orb.dart';
import 'package:nexus_drift/game/components/exit_portal.dart';
import 'package:nexus_drift/game/components/rotating_platform.dart';
import 'package:nexus_drift/game/components/radiation_zone.dart';
import 'dart:math' as math;

class Minimap extends StatefulWidget {
  final NexusDriftGame game;
  const Minimap({super.key, required this.game});

  @override
  State<Minimap> createState() => _MinimapState();
}

class _MinimapState extends State<Minimap> with SingleTickerProviderStateMixin {
  late final AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _pulseController,
      builder: (context, child) {
        return Container(
          width: 120.r,
          height: 120.r,
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.6),
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.cyanAccent.withOpacity(0.3),
              width: 2.r,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.cyanAccent.withOpacity(0.1),
                blurRadius: 10.r,
                spreadRadius: 2.r,
              ),
            ],
          ),
          child: ClipOval(
            child: CustomPaint(
              painter: MinimapPainter(
                game: widget.game,
                pulseValue: _pulseController.value,
              ),
            ),
          ),
        );
      },
    );
  }
}

class MinimapPainter extends CustomPainter {
  final NexusDriftGame game;
  final double pulseValue;

  MinimapPainter({required this.game, required this.pulseValue});

  @override
  void paint(Canvas canvas, Size size) {
    if (!game.isLoaded || !game.drone.isMounted) return;

    final center = Offset(size.width / 2, size.height / 2);
    final dronePos = game.drone.body.position;
    
    // Scale factor: 120dp for approx 250 units width?
    // Let's say the minimap shows a range of 200 units.
    final double scale = size.width / 200.0;

    void drawObject(Vector2 worldPos, Color color, {double radius = 3.0, bool isSquare = false, double? width, double? height}) {
      final relativePos = worldPos - dronePos;
      final offset = center + Offset(relativePos.x * scale, relativePos.y * scale);

      // Clip if outside minimap circular bounds
      if ((offset - center).distance > size.width / 2) return;

      final paint = Paint()..color = color;
      if (isSquare && width != null && height != null) {
        canvas.drawRect(
          Rect.fromCenter(center: offset, width: width * scale, height: height * scale),
          paint,
        );
      } else {
        canvas.drawCircle(offset, radius.r, paint);
      }
    }

    // 1. Draw Platforms
    final platforms = game.world.children.whereType<GamePlatform>();
    for (final p in platforms) {
      Color color = Colors.grey;
      if (p is MovingPlatform) {
        color = Colors.grey.withOpacity(0.5 + 0.3 * pulseValue);
      } else if (p is RotatingPlatform) {
        color = Colors.cyanAccent.withOpacity(0.4 + 0.2 * pulseValue); // Pulsing cyan for rotation
      }
      
      drawObject(
        p.body.position, 
        color, 
        isSquare: true, 
        width: p.size.x, 
        height: p.size.y,
      );
    }

    // 2. Draw Orbs
    final orbs = game.world.children.whereType<PlasmaOrb>();
    for (final orb in orbs) {
      drawObject(orb.position, Colors.blueAccent, radius: 2.5);
    }

    // 3. Draw Exit Portal
    final portals = game.world.children.whereType<ExitPortal>();
    for (final portal in portals) {
      drawObject(
        portal.position, 
        Colors.greenAccent, 
        isSquare: true, 
        width: 10, 
        height: 15,
      );
    }

    // 4. Draw Radiation Zones
    final hazards = game.world.children.whereType<RadiationZone>();
    for (final hazard in hazards) {
      drawObject(
        hazard.position, 
        Colors.red.withOpacity(0.3 + 0.2 * pulseValue), 
        isSquare: true, 
        width: hazard.size.x, 
        height: hazard.size.y,
      );
    }

    // 5. Draw Direction Hint (Yellow Arrow)
    // Find nearest portal
    if (portals.isNotEmpty) {
      final target = portals.first.position;
      final dir = (target - dronePos).normalized();
      final arrowScale = 20.r;
      final arrowPaint = Paint()
        ..color = Colors.yellowAccent.withOpacity(0.6)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.r;
      
      final arrowEnd = center + Offset(dir.x * arrowScale, dir.y * arrowScale);
      canvas.drawLine(center, arrowEnd, arrowPaint);
      
      // Draw arrowhead
      final angle = math.atan2(dir.y, dir.x);
      const headAngle = math.pi / 6;
      const headLen = 6.0;
      canvas.drawLine(
        arrowEnd,
        arrowEnd - Offset(math.cos(angle - headAngle), math.sin(angle - headAngle)) * headLen.r,
        arrowPaint,
      );
      canvas.drawLine(
        arrowEnd,
        arrowEnd - Offset(math.cos(angle + headAngle), math.sin(angle + headAngle)) * headLen.r,
        arrowPaint,
      );
    }

    // 5. Draw Drone (Center)
    canvas.drawCircle(
      center, 
      4.r, 
      Paint()
        ..color = Colors.orangeAccent
        ..maskFilter = MaskFilter.blur(BlurStyle.solid, 2.r),
    );
  }

  @override
  bool shouldRepaint(covariant MinimapPainter oldDelegate) => true;
}
