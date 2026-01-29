
Level 3 introduces **rotation** for the first time (a spinning platform), forcing the player to think about angular momentum, timing entry/exit, and using rotation for slingshot-like boosts.

```markdown
# Level 3 - "Spin Drift"

## Level Description
Introduces a rotating platform to teach angular momentum, timing entry/exit, and using spin for velocity boosts (gravity-assist style). Still beginner-friendly but adds a new layer of planning.

## Objective
Reach the Exit Portal using 3–6 thrusts max while collecting at least 1 Plasma Orb. Use the rotating platform to gain speed or change direction cleverly.

## Starting Fuel
75 units (tighter to reward efficient use of rotation momentum)

## Screen Layout (Top-down view)

```
╔════════════════════════════════════════════════════════╗
║                  Deep Space Background                 ║
║                                                        ║
║                 *   ← Plasma Orb 1                     ║
║                                                        ║
║   =============   ← Platform 1 (Start - Static)        ║
║         O         ← Player Drone starts here           ║
║                                                        ║
║                   ↺ [=====] ↻   ← Rotating Platform   ║
║                                                        ║
║                          *   ← Plasma Orb 2 (opt)      ║
║                                                        ║
║                                   []  ← Exit Portal    ║
║                                                        ║
╚════════════════════════════════════════════════════════╝
```

## ASCII Storyboard - Main Success Path

**Start Position**
```
     *
============
      O

       ↺ [=====] ↻
```

**First Thrust (Aim for Rotating Platform Edge)**
```
          *
============
           O →→→

         ↺ [=====] ↻
```

**Land on Rotating Platform + Gain Spin Boost**
```
               *
============
                O  (riding spin)

          ↺ [=====] ↻
```

**Exit with Boosted Velocity → Success**
```
                       []
                      O →→→→→ (faster drift)
```

## Multiple Success Paths

**Path A (Recommended - 4 thrusts)**
- Thrust to rotating platform → ride spin to gain speed → collect Orb 1 → exit thrust toward portal

**Path B (Skillful - 2–3 thrusts)**
- Time entry so rotation flings you directly toward portal (minimal correction needed)

**Path C (Safe - 5–6 thrusts)**
- Small thrust to Orb 1 → land on rotating platform → wait for good angle → small thrust to static zone → final correction to portal

## Common Failure Scenarios & Recovery

1. **Wrong entry timing → bounce off or miss platform**  
   → Recovery: Micro-adjust mid-drift

2. **Exit thrust in wrong direction → spin flings you away**  
   → Recovery: Emergency opposing thrust (costs fuel)

3. **Get spun too fast → overshoot portal wildly**  
   → Recovery: Counter-thrust to slow rotation effect

4. **Slide off rotating platform edge**  
   → Recovery: Quick thrust back on or toward portal

5. **Fuel depletion from too many corrections**  
   → "Out of Fuel"

## Edge Cases to Handle

- Landing exactly at rotation center (minimal speed gain)
- Thrusting while on rotating platform (adds to angular velocity)
- Collecting Orb 2 while being spun fast
- Double-tap emergency stop while on spinning platform
- Hold >2s → capped power to avoid over-spinning
- Drone barely touches rotating platform → still sticks/lands
- Platform rotation direction changes mid-level? (no — constant in L3)

## Step-by-Step Gameplay Flow

1. Level starts → Drone on Platform 1, rotating platform spins visibly (hint: "Use the spin to go faster!")
2. Hint arrows (20s) suggest aiming at the approaching edge of rotating platform
3. Player observes rotation → times thrust to land on it
4. Lands → rides spin → collects Orb 1 (+25 fuel) if timed right
5. Chooses exit moment → thrusts with boosted direction/speed toward portal
6. Drift into Exit Portal → Level Complete + "Spin Master!" message

## Win Condition
Drone physically overlaps with Exit Portal (any part touches portal area)

## Lose Conditions
- Fuel ≤ 0
- Drone off-screen for > 4 seconds
- (Optional) Time limit 180 seconds (disabled in early playtests)

## Testing Checklist (Important!)

**Must Test These Scenarios:**
- [ ] 4-thrust path using rotation boost + Orb 1
- [ ] 2–3 thrust slingshot direct to portal
- [ ] 5+ thrust conservative path
- [ ] Wrong timing → miss/bounce off rotating platform
- [ ] Over-spun → fly way past portal
- [ ] Slide off edge mid-rotation
- [ ] Fuel out after many corrections
- [ ] Collecting both orbs vs one/none
- [ ] Thrust while on rotating platform (adds spin)
- [ ] Emergency stop during spin ride

## Iteration & Balancing Guidelines

**Key Tunable Parameters:**
- Distance Platform 1 → Portal: 80–90% screen width
- Rotating platform angular speed: 60–90 degrees/sec (1 full rotation every 4–6s)
- Platform radius: 80–120 px (wide enough to land on)
- Plasma Orb positions: Orb1 near rotation edge (0.48w, 0.38h), Orb2 opposite side (0.68w, 0.50h)
- Fuel cost per small burst: 4-5 units
- Fuel restored per orb: 22–28 units
- Off-screen timeout: 4 seconds
- Portal size: 1.5× drone diameter (tighter than L2)

**How to Iterate:**
1. Playtest 10+ players after L2
2. Track: % using rotation boost, avg thrusts, completion rate
3. If >65% miss rotation entry → slow spin 10–15% or enlarge platform
4. If too many fuel-outs → increase orb reward or lower burst cost
5. If feels too easy → increase spin speed 10–20% or reduce starting fuel to 70

**Success Target for Level 3:**
- First-try completion: 40–55%
- Average attempts: 2.5–3.5
- Rotation boost used successfully: 65%+
- Orb collection (at least 1): 70%+

## Visual Feedback Recommendations
- Rotating platform: visible rotation arrows + speed-blur trail
- On-platform: subtle spin indicator (drone gently rotates with platform)
- Thrust preview: shows predicted arc considering current spin
- Fuel bar: orange warning at 35%
- Win animation: spinning confetti + "Spin Master!" text
- Overlay tips: "Time your exit to use the spin!"

## Collectible & Portal Sizes (Progressive Difficulty)

**Plasma Orb size**  
- Visual radius: **1.5–1.7 × drone radius** (smaller than L2)  
- Collision hitbox: **1.9 × drone radius**  
- Reason: Requires better timing/aim while spinning  
- Later levels: continue shrinking

**Exit Portal size**  
- Visual width/height: **1.5–1.8 × drone diameter**  
- Collision hitbox: **1.4 × drone diameter**  
- Reason: Rewards using spin for speed but punishes poor exit timing  
- Later levels: reduce further

This level teaches players to **use the environment** (rotation) as a tool rather than fighting against it.

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

3. (Optional – disabled by default) Time limit 180 seconds exceeded  
   → Game over  
   → Show "Time's Up" overlay  
   → Same retry/ad/menu options

**Overlay / Termination Screen Rules:**
- Pause game physics & timers (including rotation)
- Semi-transparent dark overlay
- Large centered text (e.g. "OUT OF FUEL", "LOST IN SPACE")
- Two or three large buttons:
  - "Retry" (primary, green)
  - "Watch Ad" (+fuel/revive – rewarded video)
  - "Menu" (secondary, gray)
- No auto-restart
- Reset fuel to 75 on retry
- Keep current level progress

**Additional Termination Notes for Level 3:**
- Rotation freezes on game over
- Tip in overlay: "Use the spin to gain speed next time!"
- Slightly higher risk of wild overshoots → forgiving timeout still kept
```