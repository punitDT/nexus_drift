import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexus_drift/game/controllers/game_controller.dart';
import 'package:nexus_drift/game/nexus_drift_game.dart';
import 'package:flame/game.dart';

class GameControls extends StatelessWidget {
  final NexusDriftGame game;

  const GameControls({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<GameController>();

    return Obx(() {
      if (controller.controlType.value != 'buttons') return const SizedBox.shrink();

      return Stack(
        children: [
          // Left Side Controls (DOWN + LEFT)
          Positioned(
            bottom: 40,
            left: 40,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _buildModernButton(
                  icon: Icons.keyboard_arrow_left,
                  label: "LEFT",
                  onTap: () => game.applyDirectionalThrust(Vector2(-1, 0)),
                ),
                const SizedBox(width: 20),
                Padding(
                  padding: const EdgeInsets.only(bottom: 50), // Staggered Up
                  child: _buildModernButton(
                    icon: Icons.keyboard_arrow_down,
                    label: "DOWN",
                    onTap: () => game.applyDirectionalThrust(Vector2(0, 1)),
                  ),
                ),
              ],
            ),
          ),

          // Right Side Controls (UP + RIGHT)
          Positioned(
            bottom: 40,
            right: 40,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 50), // Staggered Up
                  child: _buildModernButton(
                    icon: Icons.keyboard_arrow_up,
                    label: "UP",
                    onTap: () => game.applyDirectionalThrust(Vector2(0, -1)),
                  ),
                ),
                const SizedBox(width: 20),
                _buildModernButton(
                  icon: Icons.keyboard_arrow_right,
                  label: "RIGHT",
                  onTap: () => game.applyDirectionalThrust(Vector2(1, 0)),
                ),
              ],
            ),
          ),
          
          // Emergency Stop (Center Bottom?) or maybe dedicated button
          // Let's put Stop in center bottom
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: _buildModernButton(
                icon: Icons.stop,
                label: "STOP",
                color: Colors.redAccent,
                onTap: () => game.emergencyStop(),
                size: 70,
                isCircular: true,
              ),
            ),
          ),
        ],
      );
    });
  }

  Widget _buildModernButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    Color color = Colors.cyanAccent,
    double size = 80,
    bool isCircular = false,
  }) {
    return GestureDetector(
      onTapDown: (_) => onTap(),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          shape: isCircular ? BoxShape.circle : BoxShape.rectangle,
          borderRadius: isCircular ? null : BorderRadius.circular(20),
          border: Border.all(
            color: color.withValues(alpha: 0.5),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.2),
              blurRadius: 15,
              spreadRadius: 2,
            ),
          ],
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              color.withValues(alpha: 0.2),
              color.withValues(alpha: 0.05),
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: color,
              size: size * 0.5,
            ),
            if (!isCircular)
              Text(
                label,
                style: TextStyle(
                  color: color.withValues(alpha: 0.8),
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
