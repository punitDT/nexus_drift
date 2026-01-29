import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ResultOverlay extends StatelessWidget {
  final bool isWin;
  final String title;
  final String message;
  final VoidCallback onAction; // Next or Retry
  final VoidCallback onMenu;

  const ResultOverlay({
    required this.isWin,
    required this.title,
    required this.message,
    required this.onAction,
    required this.onMenu,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final themeColor = isWin ? Colors.cyanAccent : Colors.orangeAccent;

    return Center(
      child: Container(
        width: 700.w,
        padding: EdgeInsets.all(40.w),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.9),
          borderRadius: BorderRadius.circular(15.r),
          border: Border.all(color: themeColor.withOpacity(0.5), width: 2.w),
          boxShadow: [
            BoxShadow(
              color: themeColor.withOpacity(0.2),
              blurRadius: 30,
              spreadRadius: 5,
            )
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: GoogleFonts.orbitron(
                fontSize: 48.sp,
                color: themeColor,
                fontWeight: FontWeight.bold,
                letterSpacing: 4,
              ),
            ).animate().slideY(begin: 0.2, end: 0, curve: Curves.easeOutCubic),
            SizedBox(height: 20.h),
            Text(
              message,
              textAlign: TextAlign.center,
              style: GoogleFonts.rajdhani(
                fontSize: 26.sp,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ).animate().fadeIn(delay: const Duration(milliseconds: 300)),
            SizedBox(height: 40.h),
            
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildButton(
                  label: "MENU",
                  onPressed: onMenu,
                  color: Colors.grey[800]!,
                  textColor: Colors.white70,
                ),
                SizedBox(width: 20.w),
                _buildButton(
                  label: isWin ? "NEXT SECTOR" : "RETRY MISSION",
                  onPressed: onAction,
                  color: themeColor,
                  textColor: Colors.black,
                  isPrimary: true,
                ),
              ],
            ).animate().scale(delay: const Duration(milliseconds: 500), curve: Curves.elasticOut),

            if (!isWin) ...[
              SizedBox(height: 20.h),
              TextButton.icon(
                onPressed: () {
                  // Mock Watch Ad for +50 fuel
                  onAction(); // For now just retry
                },
                icon: Icon(Icons.slow_motion_video, color: Colors.cyanAccent, size: 20.sp),
                label: Text(
                  "WATCH AD FOR +50 FUEL",
                  style: GoogleFonts.rajdhani(
                    color: Colors.cyanAccent,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ).animate().fadeIn(delay: const Duration(milliseconds: 800)),
            ],
          ],
        ),
      ).animate().fadeIn(duration: const Duration(milliseconds: 400)),
    );
  }

  Widget _buildButton({
    required String label,
    required VoidCallback onPressed,
    required Color color,
    required Color textColor,
    bool isPrimary = false,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: textColor,
        padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 20.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.r),
        ),
        elevation: isPrimary ? 10 : 0,
      ),
      child: Text(
        label,
        style: GoogleFonts.orbitron(
          fontSize: 18.sp,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }
}
