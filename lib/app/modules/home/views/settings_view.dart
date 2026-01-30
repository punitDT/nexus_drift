import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:nexus_drift/game/controllers/game_controller.dart';

class SettingsView extends GetView<GameController> {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0B15),
      body: Stack(
        children: [
          // Background (reused or simplified)
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment.center,
                  radius: 1.5,
                  colors: [Colors.blueAccent.withOpacity(0.1), Colors.black],
                ),
              ),
            ),
          ),
          
          SafeArea(
            child: Padding(
              padding: EdgeInsets.all(40.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Row(
                    children: [
                      IconButton(
                        onPressed: () => Get.back(),
                        icon: const Icon(Icons.arrow_back_ios_new, color: Colors.cyanAccent),
                      ),
                      SizedBox(width: 20.w),
                      Text(
                        "SYSTEM CONFIGURATION",
                        style: GoogleFonts.orbitron(
                          fontSize: 32.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 4,
                        ),
                      ),
                    ],
                  ).animate().slideX(begin: -0.1, end: 0, duration: const Duration(milliseconds: 300)),
                  
                  SizedBox(height: 60.h),
                  
                  // Controls Section
                  _buildSectionTitle("FLIGHT CONTROLS"),
                  SizedBox(height: 20.h),
                  
                  Obx(() => Row(
                    children: [
                      _buildOptionCard(
                        title: "DRAG & FLING",
                        description: "Pull back and release to thrust. Intuitive and precise.",
                        icon: Icons.gesture,
                        isSelected: controller.controlType.value == 'drag',
                        onTap: () => controller.setControlType('drag'),
                      ),
                      SizedBox(width: 30.w),
                      _buildOptionCard(
                        title: "D-PAD MANUAL",
                        description: "Tap directional buttons for quick maneuvers.",
                        icon: Icons.gamepad,
                        isSelected: controller.controlType.value == 'buttons',
                        onTap: () => controller.setControlType('buttons'),
                      ),
                    ],
                  )),
                  
                  SizedBox(height: 40.h),
                  
                  // Audio Section (Placeholder)
                  _buildSectionTitle("AUDIO SYSTEMS"),
                  SizedBox(height: 20.h),
                  Row(
                    children: [
                       _buildToggle("SFX VOLUME", true, (val) {}),
                       SizedBox(width: 40.w),
                       _buildToggle("MUSIC VOLUME", true, (val) {}),
                    ],
                  ),
                  
                  const Spacer(),
                  
                  // Reset Data
                   Center(
                    child: TextButton(
                      onPressed: () {
                        // TODO: Confirm reset
                      },
                      child: Text(
                        "RESET ALL PROGRESS",
                        style: GoogleFonts.rajdhani(
                          color: Colors.redAccent,
                          fontSize: 18.sp,
                          letterSpacing: 2,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.rajdhani(
        fontSize: 24.sp,
        fontWeight: FontWeight.bold,
        color: Colors.cyanAccent,
        letterSpacing: 2,
      ),
    ).animate().fadeIn(duration: const Duration(milliseconds: 500));
  }

  Widget _buildOptionCard({
    required String title,
    required String description,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.all(25.w),
          decoration: BoxDecoration(
            color: isSelected ? Colors.cyanAccent.withOpacity(0.15) : Colors.white.withOpacity(0.05),
            border: Border.all(
              color: isSelected ? Colors.cyanAccent : Colors.white12,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(10.r),
            boxShadow: isSelected ? [BoxShadow(color: Colors.cyanAccent.withOpacity(0.2), blurRadius: 15)] : [],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, color: isSelected ? Colors.cyanAccent : Colors.white54, size: 36.sp),
              SizedBox(height: 15.h),
              Text(
                title,
                style: GoogleFonts.orbitron(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: isSelected ? Colors.white : Colors.white70,
                ),
              ),
              SizedBox(height: 10.h),
              Text(
                description,
                style: GoogleFonts.rajdhani(
                  fontSize: 16.sp,
                  color: Colors.white54,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildToggle(String label, bool value, Function(bool) onChanged) {
    return Row(
      children: [
        Transform.scale(
          scale: 0.8,
          child: Switch(
            value: value, 
            onChanged: onChanged,
            activeColor: Colors.cyanAccent,
            activeTrackColor: Colors.cyanAccent.withOpacity(0.3),
          ),
        ),
        SizedBox(width: 10.w),
        Text(
          label,
          style: GoogleFonts.rajdhani(color: Colors.white70, fontSize: 18.sp),
        ),
      ],
    );
  }
}
