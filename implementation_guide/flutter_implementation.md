

```markdown
# flutter_implementations.md
Nexus Drift – Flutter Implementation Architecture & Guidelines

## Project Goal
Mobile-first casual physics-based drifting game using Flutter + Flame + Forge2D.  
Zero-gravity momentum gameplay, intuitive tap-and-hold thrust controls, endless potential for levels.

## Core Technology Stack

### Flutter Version
- Flutter 3.24+ (stable channel recommended)
- Dart 3.5+

### Game Engine & Physics
- Flame 1.18+ (game loop, components, rendering)
- flame_forge2d 0.15+ (Box2D physics integration for realistic inertia / collisions)

### State Management
- GetX 4.6+ (full replacement for Provider / Riverpod in this project)
  - Used for: 
    - Global app state (fuel, score, level progress)
    - Navigation (menus → game → pause → shop)
    - Reactive UI updates (fuel bar, thrust preview visibility)
    - Simple dependency injection (controllers, services)

### UI & Layout
- flutter_screenutil 5.9+ → for adaptive sizing across all device resolutions
- google_fonts 6.2+ → cyberpunk/neon font family (e.g. Orbitron, Rajdhani)
- flutter_animate 4.5+ → smooth animations (fuel bar pulse, thrust preview fade, confetti on win)

### Other Essential Packages
| Package                  | Purpose                                      | Version (approx) |
|--------------------------|----------------------------------------------|------------------|
| get                      | State, route, snackbar, dialogs              | 4.6+            |
| flame                    | Game widget, components, gestures            | 1.18+           |
| flame_forge2d            | Realistic Newtonian physics                  | 0.15+           |
| flutter_screenutil       | dp → responsive scaling                      | 5.9+            |
| audioplayers             | Sound effects (thrust, collect, win, lose)   | 6.1+            |
| shared_preferences       | Save unlocked levels, high score, settings   | 2.3+            |
| flutter_launcher_icons   | App icon generation                          | 0.13+           |
| flutter_native_splash    | Custom splash screen                         | 2.4+            |
| url_launcher             | Optional: open privacy policy / rate us      | 6.3+            |

### Optional / Future Packages
- in_app_purchase / revenuecat → monetization
- google_mobile_ads → rewarded ads for extra fuel / revive
- firebase_analytics / crashlytics → tracking progression & crashes
- flame_isolate → performance (if levels become very complex)

## Screen Adaptability & Responsiveness Strategy

All game elements must look good on phones from 4" to 7" (iPhone SE → iPad Mini in phone mode).

### Primary Technique: flutter_screenutil
- Set design size to common reference: 375 × 812 (iPhone 13 / 14 logical resolution)
- Usage pattern (in widgets & Flame components):
  - .w  → width units
  - .h  → height units
  - .sp → font size
  - .r  → radius / border
  - Example: drone radius = 32.r, platform width = 300.w

### Layout Rules
- Game world: uses relative positioning (Vector2 percentages of screen size)
  - Example: start platform y = screenHeight * 0.78.h
  - Exit portal x = screenWidth * 0.82.w
- HUD (fuel bar, pause button, hints): positioned with MediaQuery / Get.width / Get.height
- Menus (main, level select, shop): Column + Expanded + Spacer + SafeArea
- Orientation: **portrait only** (lock in main.dart)

### Breakpoints & Scaling Behavior
| Device Type          | Screen Width | Scaling Behavior                              |
|----------------------|--------------|-----------------------------------------------|
| Small phones (SE)    | ~320–360dp   | Slightly larger elements (min scale 1.0)      |
| Normal phones        | 360–420dp    | Standard 1.0 scale                            |
| Large phones / fold  | 420–600dp    | Cap max scale at 1.15–1.2 to avoid huge UI    |
| Tablets (phone mode) | 600+ dp      | Center game area + black bars or letterbox    |

### Safe Area & Notch Handling
- Use SafeArea widget for all menus & overlays
- Flame game: respect viewInsets.bottom for virtual keyboard (rare)
- Avoid hard-coded margins — use .h / .w everywhere

## Folder Structure (Recommended)

```
lib/
├── main.dart
├── app/
│   ├── app.dart                  # GetMaterialApp wrapper
│   ├── routes/                   # GetPage routes
│   └── bindings/                 # GetX bindings
├── game/
│   ├── nexus_drift_game.dart     # Main Flame Game class
│   ├── levels/
│   │   ├── level_1.dart          # Level-specific spawn & logic
│   │   └── level_base.dart
│   ├── components/
│   │   ├── player_drone.dart
│   │   ├── platform.dart
│   │   ├── plasma_orb.dart
│   │   ├── exit_portal.dart
│   │   └── thrust_preview.dart
│   └── controllers/
│       └── game_controller.dart  # GetX controller for fuel, score, etc.
├── screens/
│   ├── main_menu.dart
│   ├── level_select.dart
│   ├── pause_overlay.dart
│   └── shop_screen.dart
├── services/
│   ├── audio_service.dart
│   ├── storage_service.dart
│   └── ad_service.dart           # future
└── utils/
    ├── constants.dart            # colors, sizes, strings
    └── extensions.dart           # vector2 helpers, etc.
```

## Performance Guidelines
- Keep component count low (< 150 active bodies in early levels)
- Use SpriteBatch / SpriteAnimation for repeated effects if needed
- Disable unnecessary Flame updates (pause when overlay visible)
- Test on low-end devices (Android Go, older iPhones)

## Monetization & Analytics Notes
- Free + rewarded ads (extra fuel, continue after out-of-fuel)
- No forced interstitials during gameplay
- Optional battle pass / cosmetics (drone skins, thrust trails)
- Track: level completion rate, average attempts per level, fuel collection %

This document should be updated whenever major architectural decisions are made.
```