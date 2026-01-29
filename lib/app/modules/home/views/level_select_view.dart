import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexus_drift/app/routes/app_pages.dart';
import 'package:nexus_drift/game/controllers/game_controller.dart';

class LevelSelectView extends StatelessWidget {
  const LevelSelectView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<GameController>();

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF0F0F1A),
              Color(0xFF1A1A2E),
            ],
          ),
        ),
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(40, 60, 40, 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back_ios, color: Colors.cyanAccent),
                        onPressed: () => Get.back(),
                      ),
                      const SizedBox(width: 20),
                      const Text(
                        "SECTOR SELECT",
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 4,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  // Settings Button
                  IconButton(
                    icon: const Icon(Icons.settings, color: Colors.cyanAccent, size: 32),
                    onPressed: () => _showSettingsDialog(context, controller),
                  ),
                ],
              ),
            ),
            // Level Grid
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 100),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 30,
                  crossAxisSpacing: 30,
                  childAspectRatio: 1.5,
                ),
                itemCount: 11, // Show 11 levels (incl. Endless)
                itemBuilder: (context, index) {
                  final levelNum = index + 1;
                  final isUnlocked = levelNum <= controller.unlockedLevel.value;
                  
                  return _buildLevelCard(
                    context,
                    levelNum,
                    isUnlocked,
                    () {
                      if (isUnlocked) {
                        controller.currentLevel.value = levelNum;
                        Get.toNamed(Routes.GAME);
                      }
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showSettingsDialog(BuildContext context, GameController controller) {
    Get.dialog(
      Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          width: 400,
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: const Color(0xFF1E2633),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.cyanAccent.withValues(alpha: 0.5), width: 2),
            boxShadow: [
              BoxShadow(
                color: Colors.cyanAccent.withValues(alpha: 0.2),
                blurRadius: 20,
                spreadRadius: 5,
              ),
            ],
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "SETTINGS",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 3,
                  ),
                ),
                const SizedBox(height: 32),
                const Text(
                  "CONTROLS",
                  style: TextStyle(
                    color: Colors.cyanAccent,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.5,
                  ),
                ),
                const SizedBox(height: 16),
                Obx(() => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildControlOption(
                      context,
                      label: "DRAG",
                      icon: Icons.swipe,
                      isSelected: controller.controlType.value == 'drag',
                      onTap: () => controller.setControlType('drag'),
                    ),
                    const SizedBox(width: 20),
                    _buildControlOption(
                      context,
                      label: "BUTTONS",
                      icon: Icons.gamepad,
                      isSelected: controller.controlType.value == 'buttons',
                      onTap: () => controller.setControlType('buttons'),
                    ),
                  ],
                )),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: () => Get.back(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.cyanAccent,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  ),
                  child: const Text("CLOSE", style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildControlOption(BuildContext context, {required String label, required IconData icon, required bool isSelected, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? Colors.cyanAccent.withValues(alpha: 0.2) : Colors.white.withValues(alpha: 0.05),
          border: Border.all(
            color: isSelected ? Colors.cyanAccent : Colors.white24,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Icon(icon, color: isSelected ? Colors.cyanAccent : Colors.white54, size: 32),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.cyanAccent : Colors.white54,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLevelCard(BuildContext context, int level, bool isUnlocked, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: isUnlocked 
              ? Colors.cyanAccent.withValues(alpha: 0.05) 
              : Colors.white.withValues(alpha: 0.02),
          border: Border.all(
            color: isUnlocked ? Colors.cyanAccent : Colors.white.withValues(alpha: 0.1),
            width: 2,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    level == 11 ? "MODE" : "LEVEL",
                    style: TextStyle(
                      color: isUnlocked ? Colors.cyanAccent : Colors.white.withValues(alpha: 0.3),
                      fontSize: 14,
                      letterSpacing: 2,
                    ),
                  ),
                  Text(
                    level == 11 ? "ENDLESS" : "$level",
                    style: TextStyle(
                      color: isUnlocked ? Colors.white : Colors.white.withValues(alpha: 0.1),
                      fontSize: level == 11 ? 24 : 48,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            if (!isUnlocked)
              const Positioned(
                top: 10,
                right: 10,
                child: Icon(Icons.lock, color: Colors.white24, size: 20),
              ),
            if (isUnlocked)
               Positioned(
                bottom: 10,
                right: 10,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: level == 11 ? Colors.purpleAccent : Colors.cyanAccent,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    level == 11 ? "SURVIVE" : "READY",
                    style: const TextStyle(color: Colors.black, fontSize: 10, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
