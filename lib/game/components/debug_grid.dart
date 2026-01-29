import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class DebugGrid extends PositionComponent {
  @override
  void render(Canvas canvas) {
    final paint = Paint()..color = Colors.white.withOpacity(0.1)..strokeWidth = 0.05;
    final axisPaint = Paint()..color = Colors.red.withOpacity(0.5)..strokeWidth = 0.1;
    
    // Draw Grid lines every 1 unit
    for (double x = -20; x <= 20; x += 1) {
      canvas.drawLine(Offset(x, -20), Offset(x, 20), x == 0 ? axisPaint : paint);
    }
    for (double y = -20; y <= 20; y += 1) {
      canvas.drawLine(Offset(-20, y), Offset(20, y), y == 0 ? axisPaint : paint);
    }
    
    // Draw Origin
    canvas.drawCircle(Offset.zero, 0.2, axisPaint);
  }
}
