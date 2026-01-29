```markdown
# Level 2 - "Moving Drift"

## Level Description
Introduces a single slowly moving platform to teach timing thrusts with moving targets. Still forgiving, but requires observing platform motion before thrusting.

## Objective
Reach the Exit Portal using 3–5 thrusts max while collecting at least 1 Plasma Orb. Time your drifts to land on the moving platform.

## Starting Fuel
85 units (slightly tighter than Level 1 to encourage efficiency)

## Screen Layout (Top-down view)

```
╔════════════════════════════════════════════════════════╗
║                  Deep Space Background                 ║
║                                                        ║
║                    *    ← Plasma Orb 1                 ║
║                                                        ║
║   =============   ← Platform 1 (Start - Static)        ║
║         O         ← Player Drone starts here           ║
║                                                        ║
║          <---[=====]--->   ← Moving Platform           ║
║                                                        ║
║                          *  ← Plasma Orb 2 (opt)       ║
║                                                        ║
║                                   []  ← Exit Portal    ║
║                                                        ║
╚════════════════════════════════════════════════════════╝
```

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

## ASCII Storyboard - Main Success Path

**Start Position**
```
     *
============
      O

   <---[=====]--->
```

**First Thrust (Time for Moving Platform Approach)**
```
          *
============
           O →→→

      [=====]--->
```

**Land on Moving Platform + Second Thrust (with Orb 1)**
```
               *
============
                O → (landed)

   <---[=====]-->
```

**Final Thrust from Moving Platform → Success**
```
                       []
                      O →→→
```

## Multiple Success Paths

**Path A (Recommended - 3 thrusts)**
- Observe moving platform → thrust to land on it → collect Orb 1 → thrust toward portal (Orb 2 optional)

**Path B (Advanced - 2 thrusts)**
- Perfect timing: strong thrust arcs over moving platform directly to portal (risky)

**Path C (Safe - 4-5 thrusts)**
- Small thrust to Orb 1 → land on moving platform → wait for position → small thrust to static area near portal → final drift

## Common Failure Scenarios & Recovery

1. **Miss moving platform timing**  
   → Drone drifts past/under it  
   → Recovery: Micro-thrust up/down to adjust trajectory mid-drift

2. **Thrust too early/late on moving platform**  
   → Overshoot portal or fall short  
   → Recovery: Use remaining fuel for correction burst

3. **Go too high/low off moving platform**  
   → Off-screen drift  
   → "Lost in Space" after 4s

4. **Fuel inefficiency on multiple small thrusts**  
   → Run out before portal  
   → "Out of Fuel"

5. **Get stuck bouncing on start platform**  
   → Recovery: Stronger thrust to clear it

## Edge Cases to Handle

- Moving platform at edge positions during thrust (player must predict)
- Thrust exactly as platform reverses direction
- Collecting Orb 2 while drifting fast (grazing collision)
- Double-tap emergency stop mid-drift toward moving platform
- Hold >2s on moving platform (capped power to prevent overshoot)
- Drone lands on moving platform but slides off edge due to momentum

## Step-by-Step Gameplay Flow

1. Level starts → Drone on Platform 1, moving platform oscillates visibly (hint: "Watch the moving platform!")
2. Hint arrows (15s) show timing for first thrust
3. Player observes → taps/holds toward predicted moving platform position
4. Release → drift + land → collect Orb 1 (+25 fuel)
5. From moving platform → thrust toward portal (collect Orb 2 optional)
6. Drift into Exit Portal → Level Complete + "Perfect Timing!" message

## Win Condition
Drone physically overlaps with Exit Portal (any part touches portal area)

## Lose Conditions
- Fuel ≤ 0
- Drone off-screen for > 4 seconds
- (Optional) Time limit 150 seconds (disabled in early playtests)

## Testing Checklist (Important!)

**Must Test These Scenarios:**
- [ ] 3-thrust path with moving platform land + Orb 1
- [ ] 2-thrust direct arc (no moving platform land)
- [ ] 4+ thrust safe path
- [ ] Missing moving platform (wrong timing)
- [ ] Off-screen from moving platform bounce
- [ ] Fuel out after 5+ micro-thrusts
- [ ] Collecting both orbs vs one/none
- [ ] Short tap vs long hold on moving platform
- [ ] Backward thrust from moving platform
- [ ] Emergency stop to wait for platform reposition

## Iteration & Balancing Guidelines

**Key Tunable Parameters:**
- Distance Platform 1 → Portal: 78–88% screen width
- Moving platform speed: 80–120 px/sec (slow, full cycle 5–7s)
- Moving platform patrol range: 25–35% screen width
- Plasma Orb positions: Orb1 (0.42w, 0.35h), Orb2 (0.65w, 0.45h)
- Fuel cost per small burst: 4-5 units
- Fuel restored per orb: 25 units
- Off-screen timeout: 4 seconds
- Portal size: 1.6× drone diameter (slightly less forgiving than L1)
- Map indicator opacity: 0.6–0.8 (higher = more guidance for beginners)
- Map update frequency: every 0.1–0.2s (smooth but not performance heavy)
- Initial hint duration on minimap arrow: 20–40 seconds (Level 1 longer, Level 2 shorter)

**How to Iterate:**
1. Playtest 10+ players post-L1
2. Track: % using moving platform, avg thrusts, completion rate
3. If >60% miss moving platform → slow it down / shorten patrol
4. If fuel-outs >20% → add Orb 2 reward +10 or reduce small burst cost
5. If too easy → speed up moving platform 10% or start fuel 80

**Success Target for Level 2:**
- First-try completion: 45–60%
- Average attempts: 2.2–3.0
- Moving platform land rate: 70%+
- Orb collection (at least 1): 75%+
- % of players who look at/use minimap (track via analytics or heatmaps if implemented)
- If first-try completion low despite generous fuel → increase minimap opacity or arrow visibility

## Visual Feedback Recommendations
- Moving platform: subtle glow pulse + motion trail
- Thrust preview: predict moving platform position (dotted future path?)
- Fuel bar: yellow warning earlier (at 40%)
- "Out of Fuel" / "Lost in Space" with level-specific tips (e.g. "Time your thrusts!")
- Win confetti + "Timing Master!" animation
- Map indicator: small top-right minimap showing drone + key objects + suggested direction (see Map Indicator section)

## Collectible & Portal Sizes (Progressive Difficulty)

**Plasma Orb size**  
- Visual radius: **1.6–1.8 × drone radius** (slightly smaller than L1)  
- Collision hitbox: **2.0 × drone radius**  
- Reason: Still easy to grab while moving, but requires better aim than L1  
- Later levels: reduce further

**Exit Portal size**  
- Visual width/height: **1.6–2.0 × drone diameter**  
- Collision hitbox: **1.5 × drone diameter**  
- Reason: Rewards precise drifts from moving platform  
- Later levels: reduce progressively

This level builds confidence in timing while keeping momentum core intact.

## Game Over / Termination Logic

**Triggers (in order of priority check):**

1. Fuel ≤ 0  
   → Immediate game over  
   → Show "Out of Fuel" overlay  
   → Options: Retry level | Watch rewarded ad for +50 fuel | Return to menu

2. Drone off-screen > timeout (default 4 seconds)  
   → Game over  
   → Show "Lost in Space" overlay  
   → Same options as above

3. (Optional – disabled by default in tutorial) Time limit 150 seconds exceeded  
   → Game over  
   → Show "Time's Up" overlay  
   → Same retry/ad/menu options

**Overlay / Termination Screen Rules:**
- Pause game physics & timers (including moving platform)
- Semi-transparent dark overlay
- Large centered text (e.g. "OUT OF FUEL", "LOST IN SPACE")
- Two or three large buttons:
  - "Retry" (primary, green)
  - "Watch Ad" (+fuel/revive – rewarded video)
  - "Menu" (secondary, gray)
- No auto-restart
- Reset fuel to 85 on retry
- Keep current level progress (don't lose unlocked levels)

**Additional Termination Notes for Level 2:**
- Moving platform pauses on game over
- Slightly shorter timeout tolerance if players abuse waiting on platform
- Tips in overlay: "Watch platform motion next time!"
```