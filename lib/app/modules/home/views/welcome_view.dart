import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:nexus_drift/app/routes/app_pages.dart';
import 'dart:math' as math;

class WelcomeView extends StatelessWidget {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0B15),
      body: Stack(
        children: [
          // 1. Dynamic Background
          const _SpaceBackground(),
          
          // 2. Decorative overlay (Grid/Vignette)
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment.center,
                  radius: 1.5,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.8),
                  ],
                ),
              ),
            ),
          ),

          // 3. Content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo Section
                _buildLogo(),
                SizedBox(height: 60.h),
                
                // Menu Buttons
                _buildMenuButton(
                  label: "ENTER SECTOR",
                  icon: Icons.play_arrow_rounded,
                  onTap: () => Get.toNamed(Routes.LEVEL_SELECT),
                  isPrimary: true,
                  delay: 200,
                ),
                SizedBox(height: 20.h),
                _buildMenuButton(
                  label: "ENDLESS VOID",
                  icon: Icons.all_inclusive_rounded,
                  onTap: () {
                    // Check if unlocked? For now just show toast or let them try
                    Get.snackbar("LOCKED", "Clear Sector 10 to unlock Endless Mode", 
                      colorText: Colors.white, backgroundColor: Colors.redAccent.withOpacity(0.5));
                  },
                  isPrimary: false,
                  delay: 300,
                ),
                SizedBox(height: 20.h),
                _buildMenuButton(
                  label: "SYSTEMS",
                  icon: Icons.settings,
                  onTap: () => Get.toNamed(Routes.SETTINGS), 
                  isPrimary: false,
                  delay: 400,
                ),
              ],
            ),
          ),

          // 4. Footer
          Positioned(
            bottom: 30.h,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                "NEXUS OS v1.0.0 // ONLINE",
                style: GoogleFonts.shareTechMono(
                  color: Colors.cyanAccent.withOpacity(0.3),
                  fontSize: 14.sp,
                  letterSpacing: 2,
                ),
              ).animate().fade(duration: const Duration(seconds: 2)).shimmer(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLogo() {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            // Glow
            Container(
              width: 500.w,
              height: 100.h,
              decoration: BoxDecoration(
                color: Colors.cyanAccent.withOpacity(0.1),
                borderRadius: BorderRadius.circular(100),
                boxShadow: [
                  BoxShadow(
                    color: Colors.cyanAccent.withOpacity(0.1),
                    blurRadius: 50,
                    spreadRadius: 10,
                  )
                ],
              ),
            ).animate(onPlay: (c) => c.repeat(reverse: true))
             .scale(begin: const Offset(1, 1), end: const Offset(1.1, 1.1), duration: const Duration(seconds: 2)),
             
            // Text
            Text(
              "NEXUS DRIFT",
              style: GoogleFonts.orbitron(
                fontSize: 80.sp,
                fontWeight: FontWeight.w900,
                color: Colors.white,
                letterSpacing: 8,
                shadows: [
                  BoxShadow(color: Colors.cyanAccent.withOpacity(0.6), blurRadius: 20, spreadRadius: 0),
                  BoxShadow(color: Colors.blueAccent.withOpacity(0.6), blurRadius: 40, spreadRadius: 0),
                ],
              ),
            ),
          ],
        ).animate().scale(duration: const Duration(milliseconds: 800), curve: Curves.easeOutBack),
        
        SizedBox(height: 10.h),
        
        Text(
          "PRECISION MANEUVERING PROTOCOL",
          style: GoogleFonts.rajdhani(
            fontSize: 20.sp,
            color: Colors.white70,
            letterSpacing: 6,
            fontWeight: FontWeight.w500,
          ),
        ).animate().fadeIn(delay: const Duration(milliseconds: 500)).slideY(begin: 0.5, end: 0),
      ],
    );
  }

  Widget _buildMenuButton({
    required String label,
    required IconData icon,
    required VoidCallback onTap,
    required bool isPrimary,
    required int delay,
  }) {
    final color = isPrimary ? Colors.cyanAccent : Colors.white70;
    
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 400.w,
          padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 30.w),
          decoration: BoxDecoration(
            color: isPrimary ? color.withOpacity(0.1) : Colors.transparent,
            border: Border.all(
              color: isPrimary ? color : Colors.white12,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(5.r),
            boxShadow: isPrimary ? [BoxShadow(color: color.withOpacity(0.2), blurRadius: 20)] : [],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: color, size: 24.sp),
              SizedBox(width: 15.w),
              Text(
                label,
                style: GoogleFonts.orbitron(
                  color: isPrimary ? Colors.white : Colors.white70,
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
            ],
          ),
        ),
      ),
    ).animate()
     .fadeIn(delay: Duration(milliseconds: delay))
     .slideX(begin: -0.2, end: 0, curve: Curves.easeOutCubic);
  }
}

class _SpaceBackground extends StatelessWidget {
  const _SpaceBackground();

  @override
  Widget build(BuildContext context) {
    // Generate some random stars
    return Stack(
      children: List.generate(50, (index) {
        final random = math.Random(index); // seed for consistency
        final size = random.nextDouble() * 3 + 1;
        final top = random.nextDouble() * 1.0; // aligned pct
        final left = random.nextDouble() * 1.0;
        final duration = random.nextInt(3000) + 2000;
        
        return Positioned(
          top: MediaQuery.of(context).size.height * top,
          left: MediaQuery.of(context).size.width * left,
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                 BoxShadow(color: Colors.white, blurRadius: size * 2),
              ],
            ),
          ).animate(onPlay: (c) => c.repeat(reverse: true))
           .scale(begin: const Offset(0.5, 0.5), end: const Offset(1.5, 1.5), duration: Duration(milliseconds: duration))
           .fade(begin: 0.2, end: 0.8),
        );
      }),
    );
  }
}
