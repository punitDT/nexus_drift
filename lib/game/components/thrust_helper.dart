import 'package:flame/components.dart';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:nexus_drift/game/nexus_drift_game.dart';

class ThrustHelper extends Component with HasGameReference<NexusDriftGame> {
  @override
  void render(Canvas canvas) {
    final drone = game.drone;
    // Check if dragging
    final startPos = game.dragStart;
    final endPos = game.currentDragPos;
    
    if (startPos != null && endPos != null && drone.isMounted) {
       final start = drone.body.position.toOffset();
       final end = endPos.toOffset(); 
       
       final paint = Paint()
         ..color = Colors.white.withValues(alpha: 0.8)
         ..strokeWidth = 0.3
         ..style = PaintingStyle.stroke
         ..strokeCap = StrokeCap.round;
         
       // 1. Draw Dotted Line
       final diff = end - start;
       final distance = diff.distance;
       final direction = diff / distance;
       const dashLength = 0.6;
       const dashSpace = 0.4;
       
       double currentDist = 0;
       while (currentDist < distance) {
         final dashEnd = currentDist + dashLength > distance ? distance : currentDist + dashLength;
         canvas.drawLine(
           start + direction * currentDist,
           start + direction * dashEnd,
           paint,
         );
         currentDist += dashLength + dashSpace;
       }
       
       // 2. Draw Arrow Head at 'end'
       if (distance > 0.1) {
         final angle = diff.direction; // Radians
         const arrowSize = 1.0;
         final path = Path();
         path.moveTo(end.dx, end.dy);
         path.lineTo(end.dx - arrowSize * math.cos(angle - 0.4), end.dy - arrowSize * math.sin(angle - 0.4));
         path.lineTo(end.dx - arrowSize * math.cos(angle + 0.4), end.dy - arrowSize * math.sin(angle + 0.4));
         path.close();
         
         canvas.drawPath(path, Paint()..color = Colors.white.withValues(alpha: 0.8)..style = PaintingStyle.fill);
       }
       
       // 3. Draw Charge Indicator...
       final startTime = game.dragStartTime;
       if (startTime != null) {
          final duration = DateTime.now().difference(startTime).inMilliseconds / 1000.0;
          final progress = duration.clamp(0.0, 1.0);
          final chargeColor = Color.lerp(Colors.white, Colors.cyanAccent, progress) ?? Colors.white;
          
          canvas.drawCircle(start, 3.0 + (progress * 1.5), Paint()
            ..color = chargeColor.withValues(alpha: 0.3)
            ..style = PaintingStyle.stroke
            ..strokeWidth = 0.3);
            
          canvas.drawCircle(start, 1.0 + (progress * 1.0), Paint()..color = chargeColor.withValues(alpha: 0.7));
       }
    }
  }
}
