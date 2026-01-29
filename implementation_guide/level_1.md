# Level 1 - "First Drift" (Tutorial Level)

## Level Description
The very first level designed to teach thrust control, momentum, and basic navigation in a forgiving environment.

## Objective
Reach the Exit Portal using as few thrusts as possible while optionally collecting the Plasma Orb.

## Starting Fuel
100 units (very generous for learning)

## Screen Layout (Top-down view)
╔════════════════════════════════════════════════════════╗
║                  Deep Space Background                 ║
║                                                        ║
║               *   ← Plasma Orb (collectible)           ║
║                                                        ║
║   =============   ← Platform 1 (Start)                 ║
║         O         ← Player Drone starts here           ║
║                                                        ║
║               =============   ← Platform 2             ║
║                                                        ║
║                              []   ← Exit Portal        ║
║                                                        ║
╚════════════════════════════════════════════════════════╝
text## ASCII Storyboard - Main Success Path

**Start Position**



============
O
text**After First Thrust (Right + slight up)**



============
O →→→
text**Collecting Orb + Second Small Thrust**



============
O →
text**Final Drift → Success**
[]
O →→→
text## Multiple Success Paths

**Path A (Recommended - 2 thrusts)**
- Strong right thrust → collect orb → small correction thrust → drift into portal

**Path B (Minimal Thrust - 1 thrust only)**
- One perfectly aimed medium thrust from start directly toward portal (harder, but possible)

**Path C (Safe Path - 3 thrusts)**
- Small right thrust → land on Platform 2 → small right thrust → drift to portal

## Map Indicator / Direction Guide

A small, semi-transparent minimap or directional compass appears in the **top-right corner** (or bottom-right if HUD crowded) to help new players understand the overall level layout and suggested direction of travel.

**Purpose**
- Show relative positions of key elements (start, moving/static platforms, plasma orbs, exit portal)
- Give a subtle "big picture" view so players don't feel lost in open space
- Especially helpful in early levels when learning momentum & timing

**Visual Style**
- Size: 120×120 dp (scales with flutter_screenutil .r)
- Semi-transparent dark circle/rounded square (opacity 0.6–0.7)
- Background: faint nebula texture or grid lines
- Elements shown as colored icons:
  - Player drone: small glowing orange dot (always centered)
  - Platforms: gray rectangles (static) or pulsing gray (moving)
  - Plasma Orbs: small blue stars/glow dots
  - Exit Portal: green rectangle/gate icon
  - Current direction hint: thin yellow arrow from drone toward suggested next target
- Border: subtle neon glow (cyan/orange)

**Behavior**
- Always visible during gameplay (can be toggled in settings later)
- Updates in real-time: drone dot moves, moving platform icon oscillates
- When player holds finger to aim: preview thrust direction shown as dotted yellow line on minimap too
- Fades slightly (opacity 0.4) when not holding finger → re-brightens on touch
- Disappears temporarily during pause/game over overlays

**Level-Specific Tuning**
- Level 1: Very prominent (opacity 0.8), large arrow always pointing right-up for first 30s
- Level 2: Slightly smaller, arrow only shows after 10s or when near moving platform
- Future levels: Make optional / toggleable, reduce size as player skill increases

**Why include it?**
- Prevents frustration from "where am I going?" in zero-gravity open space
- Teaches level layout without hand-holding text
- Encourages planning long drifts instead of spamming thrusts

## Common Failure Scenarios & Recovery

1. **Overshoot the portal**  
   → Drone flies past the portal  
   → Recovery: Player can do a left thrust to slow down or turn back

2. **Undershoot / Stop too early**  
   → Drone drifts slowly and stops midway  
   → Recovery: One more small thrust

3. **Go too high or too low**  
   → Drone drifts off-screen top/bottom  
   → After 4 seconds off-screen → "Lost in Space" failure

4. **Waste too much fuel**  
   → Multiple random big bursts  
   → Fuel reaches 0 → "Out of Fuel" failure

5. **Hit the wall/edge**  
   → Slight bounce back, velocity reduced

## Edge Cases to Handle

- Tap duration exactly 0.1s (micro burst) vs 1.0s (very strong burst)
- Tapping directly behind the drone (thrust backward)
- Holding tap for more than 2 seconds (should cap maximum thrust power)
- Very fast double-tap (emergency stop)
- Drone lands on Platform 2 and stops completely
- Drone barely grazes the Plasma Orb → should still collect it

## Step-by-Step Gameplay Flow

1. Level starts → Drone resting on Platform 1, velocity = (0,0)
2. Gentle hint arrow appears for 15 seconds pointing right-up
3. Player taps & holds → thrust direction + power preview shown (arrow length)
4. Release → thrust applied, fuel consumed
5. Plasma Orb collection → +30 fuel, particle effect, sound
6. Drone touches Exit Portal → Level Complete + "Great First Drift!" message

## Win Condition
Drone physically overlaps with Exit Portal (any part of drone touches portal area)

## Lose Conditions
- Fuel ≤ 0
- Drone off-screen for > 4 seconds
- (Optional) Time limit 120 seconds (can be disabled for tutorial)

## Testing Checklist (Important!)

**Must Test These Scenarios:**
- [ ] Minimum 1-thrust completion (aiming skill test)
- [ ] 2-thrust path with orb collection
- [ ] 3+ thrust path (new player behavior)
- [ ] Overshooting portal by large margin
- [ ] Going off-screen top, bottom, left, right
- [ ] Fuel reaching exactly 0 while drifting
- [ ] Collecting orb vs ignoring orb
- [ ] Extremely short tap (0.05s) vs long hold (1.5s)
- [ ] Tapping on left side (backward thrust)
- [ ] Drone stopping completely on Platform 2

## Iteration & Balancing Guidelines

**Key Tunable Parameters:**
- Distance between Platform 1 → Portal: 75–85% of screen width
- Plasma Orb position: (screen_width * 0.38, screen_height * 0.42)
- Fuel cost per small burst: 4-5 units
- Fuel restored by orb: 30–35 units
- Off-screen timeout: 3.5 – 5 seconds
- Portal size: 1.5× drone size (forgiving hitbox)
- Map indicator opacity: 0.6–0.8 (higher = more guidance for beginners)
- Map update frequency: every 0.1–0.2s (smooth but not performance heavy)
- Initial hint duration on minimap arrow: 20–40 seconds (Level 1 longer, Level 2 shorter)

**How to Iterate:**
1. Playtest with 10+ new players
2. Track: % who complete in first try, average attempts, % who collect orb
3. If >70% fail on first try → make thrust cheaper or portal larger
4. If everyone ignores orb → move orb more into the natural path
5. If players finish too easily → increase distance or reduce starting fuel to 100

**Success Target for Level 1:**
- First-try completion rate: 55–70%
- Average attempts: 1.8–2.5
- Orb collection rate: 65%+
- % of players who look at/use minimap (track via analytics or heatmaps if implemented)
- If first-try completion low despite generous fuel → increase minimap opacity or arrow visibility

## Visual Feedback Recommendations
- Thrust preview: dotted arrow showing direction + length
- Fuel bar with color change (green → yellow → red)
- "Out of Fuel" or "Lost in Space" screen with Retry button
- Confetti + "Level Complete" animation on win
- Map indicator: small top-right minimap showing drone + key objects + suggested direction (see Map Indicator section)

## Collectible & Portal Sizes (Deliberately Forgiving in Level 1)

**Plasma Orb size**  
- Visual radius: **1.8–2.0 × drone radius** (e.g. if drone radius = 16–20 dp → orb radius = 32–40 dp)  
- Collision hitbox: **slightly larger than visual** (≈ 2.2 × drone radius)  
- Reason: Makes early collection feel easy and rewarding → encourages players to try collecting instead of skipping  
- Later levels plan: gradually reduce orb size (down to 1.0–1.3× drone) as difficulty increases

**Exit Portal size**  
- Visual width/height: **1.8–2.2 × drone diameter** (very generous hit area)  
- Collision hitbox: **1.6–2.0 × drone diameter** (center area is most reliable)  
- Reason: Level 1 should almost never feel "unfairly hard to hit" → teaches momentum without punishing small aiming errors  
- Later levels plan: reduce portal size progressively (down to ~1.1–1.4× drone) to increase precision demand

This level should feel **very easy and encouraging** for complete beginners while still teaching the core momentum mechanic.

## Game Over / Termination Logic

**Triggers (in order of priority check):**

1. Fuel ≤ 0  
   → Immediate game over  
   → Show "Out of Fuel" overlay  
   → Options: Retry level | Watch rewarded ad for +50 fuel | Return to menu

2. Drone off-screen > timeout (default 4 seconds in Level 1)  
   → Game over  
   → Show "Lost in Space" overlay  
   → Same options as above

3. (Optional – disabled by default in tutorial) Time limit 120 seconds exceeded  
   → Game over  
   → Show "Time's Up" overlay  
   → Same retry/ad/menu options

**Overlay / Termination Screen Rules:**
- Pause game physics & timers
- Semi-transparent dark overlay
- Large centered text (e.g. "OUT OF FUEL", "LOST IN SPACE")
- Two or three large buttons:
  - "Retry" (primary, green)
  - "Watch Ad" (+fuel/revive – rewarded video)
  - "Menu" (secondary, gray)
- No auto-restart
- Reset fuel to 100 on retry
- Keep current level progress (don't lose unlocked levels)

**Additional Termination Notes for Level 1:**
- Very forgiving timeout (4–5 seconds) to avoid frustration during learning
- No sudden death hazards (radiation, spikes, etc.) in Level 1
- Goal: player should almost always lose due to fuel or off-screen drift — never feel "killed" by environment