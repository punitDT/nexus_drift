import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nexus_drift/game/controllers/game_controller.dart';
import 'package:nexus_drift/game/nexus_drift_game.dart';
import 'package:nexus_drift/screens/minimap.dart';

class GameHud extends GetView<GameController> {
  final NexusDriftGame game;
  
  const GameHud({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Stack(
        children: [
          // Fuel Bar - Top Left
          Positioned(
            top: 50.h,
            left: 50.w,
            child: Obx(() {
              final fuel = controller.fuel.value;
              final maxFuel = controller.maxFuel.value;
              final maxWidth = 500.w;
              final currentWidth = maxWidth * (fuel / maxFuel);
              
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.bolt, color: Colors.cyanAccent, size: 28.sp),
                      SizedBox(width: 10.w),
                      Text(
                        "CORE STABILITY",
                        style: GoogleFonts.orbitron(
                          color: Colors.cyanAccent,
                          fontSize: 22.sp,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 2.5,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15.h),
                  Container(
                    width: maxWidth,
                    height: 35.h,
                    padding: EdgeInsets.all(4.r),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(5.r),
                      border: Border.all(color: Colors.cyanAccent.withOpacity(0.4), width: 2.w),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.cyanAccent.withOpacity(0.15),
                          blurRadius: 20,
                          spreadRadius: 2,
                        )
                      ],
                    ),
                    child: Stack(
                      children: [
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 400),
                          width: currentWidth,
                          height: 35.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2.r),
                            gradient: LinearGradient(
                              colors: [
                                fuel > (maxFuel * 0.5) ? Colors.cyan : (fuel > (maxFuel * 0.2) ? Colors.orange : Colors.red),
                                fuel > (maxFuel * 0.5) ? Colors.cyanAccent : (fuel > (maxFuel * 0.2) ? Colors.orangeAccent : Colors.redAccent),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ).animate(target: fuel < (maxFuel * 0.2) ? 1 : 0)
                   .shake(hz: 8, curve: Curves.easeInOutCubic)
                   .tint(color: Colors.red, duration: const Duration(milliseconds: 500)),
                ],
              );
            }),
          ),

          // Health Bar - Below Fuel
          Positioned(
            top: 150.h,
            left: 50.w,
            child: Obx(() {
              final health = controller.health.value;
              if (health >= 100.0) return const SizedBox.shrink();

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "INTEGRITY CRITICAL",
                    style: GoogleFonts.orbitron(
                      color: Colors.redAccent,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Container(
                    width: 300.w,
                    height: 15.h,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(2.r),
                      border: Border.all(color: Colors.redAccent.withOpacity(0.5)),
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        width: 300.w * (health / 100.0),
                        color: Colors.redAccent,
                      ),
                    ),
                  ),
                ],
              ).animate().fadeIn().shake();
            }),
          ),
          
          // Sector / Minimap - Top Right
          Positioned(
            top: 50.h,
            right: 50.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Obx(() => Container(
                  padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 12.h),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(6.r),
                    border: Border.all(color: Colors.white12, width: 1.5.w),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                      )
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "SECTOR ${controller.currentLevel.value.toString().padLeft(2, '0')}",
                        style: GoogleFonts.orbitron(
                          fontSize: 32.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 2,
                        ),
                      ),
                      SizedBox(height: 5.h),
                      Text(
                        "NEURAL BITRATE: ${controller.score.value}",
                        style: GoogleFonts.rajdhani(
                          fontSize: 24.sp,
                          color: Colors.cyanAccent.withOpacity(0.9),
                          fontWeight: FontWeight.w700,
                          letterSpacing: 2,
                        ),
                      ),
                    ],
                  ),
                )),
                SizedBox(height: 30.h),
                // Minimap
                Minimap(game: game)
                  .animate()
                  .fadeIn(delay: const Duration(seconds: 1))
                  .slideX(begin: 0.5, end: 0),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
