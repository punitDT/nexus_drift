import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexus_drift/app/routes/app_pages.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF0F0F1A),
              Color(0xFF1A1A2E),
              Color(0xFF0F0F1A),
            ],
          ),
        ),
        child: Stack(
          children: [
            // Background Decorative Elements
            Positioned(
              top: -100,
              right: -100,
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.cyanAccent.withValues(alpha: 0.05),
                ),
              ),
            ),
            Positioned(
              bottom: -50,
              left: -50,
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.deepPurpleAccent.withValues(alpha: 0.05),
                ),
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo / Title
                  ShaderMask(
                    shaderCallback: (bounds) => const LinearGradient(
                      colors: [Colors.cyanAccent, Colors.blueAccent, Colors.purpleAccent],
                    ).createShader(bounds),
                    child: const Text(
                      "NEXUS DRIFT",
                      style: TextStyle(
                        fontSize: 80,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 8,
                        color: Colors.white,
                        fontFamily: 'Orbitron', // Assuming a sci-fi font if available, else default
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "CHART YOUR PATH THROUGH THE VOID",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white.withValues(alpha: 0.6),
                      letterSpacing: 4,
                    ),
                  ),
                  const SizedBox(height: 60),
                  // Start Button
                  _buildMenuButton(
                    onTap: () => Get.toNamed(Routes.LEVEL_SELECT),
                    text: "ENTER NEXUS",
                    isPrimary: true,
                  ),
                  const SizedBox(height: 20),
                  _buildMenuButton(
                    onTap: () {
                      // Settings or something
                    },
                    text: "SYSTEMS",
                    isPrimary: false,
                  ),
                ],
              ),
            ),
            // Footer
            Positioned(
              bottom: 30,
              left: 0,
              right: 0,
              child: Center(
                child: Text(
                  "V 1.0.0",
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.3),
                    fontSize: 12,
                    letterSpacing: 2,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuButton({
    required VoidCallback onTap,
    required String text,
    bool isPrimary = false,
  }) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 300,
          padding: const EdgeInsets.symmetric(vertical: 18),
          decoration: BoxDecoration(
            color: isPrimary ? Colors.cyanAccent.withValues(alpha: 0.1) : Colors.transparent,
            border: Border.all(
              color: isPrimary ? Colors.cyanAccent : Colors.white.withValues(alpha: 0.3),
              width: 2,
            ),
            borderRadius: BorderRadius.circular(4),
            boxShadow: isPrimary
                ? [
                    BoxShadow(
                      color: Colors.cyanAccent.withValues(alpha: 0.2),
                      blurRadius: 15,
                      spreadRadius: 2,
                    )
                  ]
                : [],
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: isPrimary ? Colors.cyanAccent : Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
