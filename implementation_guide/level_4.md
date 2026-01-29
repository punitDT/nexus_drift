

```markdown
# Level 4 - "Chain Drift"

## Level Description
First true combination level: two moving platforms + one rotating platform.  
Player must chain movements — use one platform to reach the next, timing everything to create a path to the exit.

## Objective
Reach the Exit Portal using 4–7 thrusts max while collecting at least 2 Plasma Orbs.  
Chain platform movements intelligently instead of brute-forcing with fuel.

## Starting Fuel
70 units (noticeably tighter — rewards planning over spamming thrusts)

## Screen Layout (Top-down view)

```
╔════════════════════════════════════════════════════════╗
║                  Deep Space Background                 ║
║                                                        ║
║             *          ← Plasma Orb 1                  ║
║                                                        ║
║   =============   ← Platform 1 (Start - Static)        ║
║         O         ← Player Drone starts here           ║
║                                                        ║
║      <---[=====]--->   ← Moving Platform A (horizontal)║
║                                                        ║
║                   ↺ [=====] ↻   ← Rotating Platform    ║
║                                                        ║
║                          *   ← Plasma Orb 2            ║
║                                                        ║
║             <---[=====]--->   ← Moving Platform B      ║
║                                                        ║
║                                       []  ← Exit Portal║
║                                                        ║
╚════════════════════════════════════════════════════════╝
```

## ASCII Storyboard - Main Success Path

**Start Position**
```
     *
============
      O

   <---[=====]--->     ↺ [=====] ↻
                           * 
                      <---[=====]--->
```

**Thrust 1 → Moving Platform A**
```
          *
============
           O →→→

      [=====]--->     ↺ [=====] ↻
```

**Thrust 2 → Rotating Platform (using A's momentum)**
```
                    *
============
                     O → (landed)

           ↺ [=====] ↻
                        *
                   <---[=====]--->
```

**Ride Rotation → Thrust 3 → Moving Platform B**
```
                              *
============
                               O →→ (boosted)

                      ↺ [=====] ↻
                           <---[=====]--->
```

**Final Thrust 4 → Portal**
```
                                       []
                                      O →→→→
```

## Multiple Success Paths

**Path A (Recommended - 5 thrusts)**
- Platform A → Rotating → collect Orb 2 → Platform B → portal (uses all three platforms)

**Path B (Aggressive - 3–4 thrusts)**
- Time strong thrust from start → skip A → land on rotating → slingshot to B or directly to portal

**Path C (Conservative - 6–7 thrusts)**
- Small hops collecting orbs → land on each platform separately → many corrections

## Common Failure Scenarios & Recovery

1. **Wrong sequencing** — miss second platform because first moved away  
   → Recovery: mid-drift micro-thrusts (expensive)

2. **Rotation flings you into wrong direction**  
   → Recovery: opposing thrust or emergency stop

3. **Platforms misaligned when you arrive**  
   → Recovery: wait on previous platform or adjust timing

4. **Fuel starvation from over-correction**  
   → "Out of Fuel"

5. **Wild overshoot from combined momentum + spin**  
   → "Lost in Space"

## Edge Cases to Handle

- Landing on rotating platform while it's moving underneath
- Thrust timing exactly when platforms are closest/farthest
- Collecting Orb 1 or 2 while transitioning platforms
- Double-tap stop while on rotating platform
- Multiple bounces between moving platforms
- Hold >2s capped to prevent catastrophic overshoots
- Drone sliding off edge of any platform due to combined velocity

## Step-by-Step Gameplay Flow

1. Level starts → Drone on Platform 1, all moving/rotating platforms in motion (hint: "Chain the platforms!")
2. Hint arrows (25s) suggest first target (Moving A) and sequence
3. Player plans → thrust to Moving A
4. From A → time jump to Rotating platform → gain spin boost
5. From Rotating → thrust to Moving B or directly toward portal
6. Collect orbs along path (+22–26 fuel each)
7. Final drift into Exit Portal → Level Complete + "Chain Master!" message

## Win Condition
Drone physically overlaps with Exit Portal (any part touches portal area)

## Lose Conditions
- Fuel ≤ 0
- Drone off-screen for > 4 seconds
- (Optional) Time limit 200 seconds (disabled in early playtests)

## Testing Checklist (Important!)

**Must Test These Scenarios:**
- [ ] 5-thrust chain path using all three platforms
- [ ] 3–4 thrust skip-one-platform path
- [ ] 6+ thrust safe path
- [ ] Wrong order / timing between platforms
- [ ] Overshoot from combined spin + movement
- [ ] Slide off during transition
- [ ] Fuel out after excessive corrections
- [ ] Collecting 2+ orbs vs fewer
- [ ] Thrust while on rotating + moving combo
- [ ] Emergency stop during chain

## Iteration & Balancing Guidelines

**Key Tunable Parameters:**
- Distance Platform 1 → Portal: 82–92% screen width
- Moving A speed: 90–130 px/sec (horizontal)
- Moving B speed: 70–110 px/sec (horizontal, opposite phase to A)
- Rotating angular speed: 70–100 deg/sec
- Plasma Orb positions: Orb1 near A (0.38w, 0.40h), Orb2 near rotating (0.55w, 0.48h)
- Fuel cost per small burst: 4-5 units
- Fuel restored per orb: 22–26 units
- Off-screen timeout: 4 seconds
- Portal size: 1.4× drone diameter (tighter)

**How to Iterate:**
1. Playtest 10+ players after L3
2. Track: % successfully chaining 2+ platforms, avg thrusts, completion rate
3. If >70% fail chain → slow platforms 10–15% or increase platform sizes
4. If fuel-outs dominant → increase orb rewards or lower burst cost
5. If too easy → desync platform phases more or increase speeds

**Success Target for Level 4:**
- First-try completion: 35–50%
- Average attempts: 2.8–4.0
- Successful chain (2+ platforms): 60%+
- Orb collection (at least 2): 65%+

## Visual Feedback Recommendations
- Each platform: unique color tint + motion/spin trails
- Chain hint: faint dotted line connecting platforms (appears for 30s)
- Thrust preview: shows approximate path considering current velocities
- Fuel bar: red warning at 30%
- Win animation: cascading confetti + "Chain Master!" text
- Overlay tip: "Connect the platforms next time!"

## Collectible & Portal Sizes (Progressive Difficulty)

**Plasma Orb size**  
- Visual radius: **1.4–1.6 × drone radius**  
- Collision hitbox: **1.8 × drone radius**  
- Reason: Harder to hit during transitions  
- Later levels: continue reducing

**Exit Portal size**  
- Visual width/height: **1.4–1.7 × drone diameter**  
- Collision hitbox: **1.3 × drone diameter**  
- Reason: Punishes poor final timing after chain  
- Later levels: reduce progressively

This level shifts focus from single-object interaction to **sequencing and planning** — core skill for later complex levels.

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

3. (Optional – disabled by default) Time limit 200 seconds exceeded  
   → Game over  
   → Show "Time's Up" overlay  
   → Same retry/ad/menu options

**Overlay / Termination Screen Rules:**
- Pause game physics & timers (all platforms freeze)
- Semi-transparent dark overlay
- Large centered text (e.g. "OUT OF FUEL", "LOST IN SPACE")
- Two or three large buttons:
  - "Retry" (primary, green)
  - "Watch Ad" (+fuel/revive – rewarded video)
  - "Menu" (secondary, gray)
- No auto-restart
- Reset fuel to 70 on retry
- Keep current level progress

**Additional Termination Notes for Level 4:**
- All platforms pause on game over
- Tip in overlay: "Plan your chain before thrusting!"
- Higher chance of wild trajectories → timeout still forgiving
```