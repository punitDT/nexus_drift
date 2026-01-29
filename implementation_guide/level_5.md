

```markdown
# Level 5 - "Hazard Drift"

## Level Description
Introduces the first environmental hazard: radiation zones (damaging over time if drone stays inside).  
Player must combine previous mechanics (moving + rotating platforms) while actively avoiding or minimizing time in hazardous areas.

## Objective
Reach the Exit Portal using 4–8 thrusts max while collecting at least 2 Plasma Orbs.  
Navigate around / through radiation zones with minimal damage (or zero if skilled).

## Starting Fuel
68 units (tight — forces careful path planning to avoid wasting fuel on escapes)

## Screen Layout (Top-down view)

```
╔════════════════════════════════════════════════════════╗
║                  Deep Space Background                 ║
║                                                        ║
║             *                                          ║
║                                                        ║
║   =============   ← Platform 1 (Start - Static)        ║
║         O         ← Player Drone starts here           ║
║                                                        ║
║      <---[=====]--->   ← Moving Platform A             ║
║                                                        ║
║   ████████████   ← Radiation Zone (damaging)           ║
║                   ↺ [=====] ↻   ← Rotating Platform    ║
║   ████████████                                         ║
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

   <---[=====]--->   ████████████   ↺ [=====] ↻   ████████████
                           * 
                      <---[=====]--->
```

**Thrust 1 → Moving A (avoid radiation)**
```
          *
============
           O →→→

      [=====]--->   ████████████   ↺ [=====] ↻   ████████████
```

**Thrust 2 → Rotating (minimal time in radiation)**
```
                    *
============
                     O → (quick pass)

           ↺ [=====] ↻   ████████████
                        *
                   <---[=====]--->
```

**Ride Rotation → Thrust 3 → Moving B**
```
                              *
============
                               O →→ (boosted)

                      ↺ [=====] ↻
                           <---[=====]--->
```

**Final Thrust 4 → Portal (clean exit)**
```
                                       []
                                      O →→→→
```

## Multiple Success Paths

**Path A (Recommended - 5–6 thrusts)**
- Platform A → quick pass through/around radiation to rotating → collect Orb 2 → Platform B → portal

**Path B (Risky - 3–4 thrusts)**
- Strong arc over radiation → land on rotating → slingshot past second zone to portal

**Path C (Safe but fuel-heavy - 7–8 thrusts)**
- Very small hops, collect orbs, avoid zones entirely with many corrections

## Common Failure Scenarios & Recovery

1. **Stay too long in radiation** → health/fuel drains fast  
   → Recovery: immediate thrust out (costs fuel)

2. **Get flung into radiation by rotation/movement**  
   → Recovery: opposing thrust or emergency stop

3. **Platforms move into radiation zones** → blocks safe landing  
   → Recovery: wait or find alternative path

4. **Fuel out from escaping radiation repeatedly**  
   → "Out of Fuel"

5. **Overshoot into second radiation zone**  
   → "Lost in Space" or heavy damage

## Edge Cases to Handle

- Drone enters radiation for <0.5s → minimal/no damage
- Collecting orb inside/near radiation edge
- Thrust while in radiation (still possible, but risky)
- Double-tap stop inside radiation (quick escape)
- Radiation zones pulsing/fading slightly for visual cue
- Multiple short touches to radiation vs one long stay
- Platform moving partially into radiation (dynamic danger)

## Step-by-Step Gameplay Flow

1. Level starts → Drone on Platform 1, platforms moving/rotating, radiation zones pulsing red (hint: "Avoid the radiation!")
2. Hint arrows (25s) suggest safe paths around zones
3. Player plans → thrust to Moving A, avoiding first zone
4. From A → quick jump to rotating (minimize zone time)
5. Ride rotation → thrust to Moving B or portal
6. Collect orbs (+20–24 fuel each) if path allows
7. Final drift into Exit Portal → Level Complete + "Hazard Avoided!" message

## Win Condition
Drone physically overlaps with Exit Portal (any part touches portal area)

## Lose Conditions
- Fuel ≤ 0
- Drone off-screen for > 4 seconds
- Drone health ≤ 0 (from prolonged radiation exposure)
- (Optional) Time limit 210 seconds (disabled in early playtests)

## Radiation Damage Mechanics (New!)
- Damage rate: 8–12 health per second inside zone
- Starting health: 100
- Visual: drone glow turns red + pulsing warning when inside
- Health bar appears temporarily when damaged
- Full heal on level retry
- Short touches (<0.5s) = 4–8 damage only

## Testing Checklist (Important!)

**Must Test These Scenarios:**
- [ ] 5–6 thrust path minimizing radiation time
- [ ] 3–4 thrust high-risk arc over zones
- [ ] 7+ thrust zero-damage path
- [ ] Staying in radiation → health drain → game over
- [ ] Rotation flings into zone
- [ ] Fuel out from repeated escapes
- [ ] Collecting orbs near/inside zone
- [ ] Thrust while damaged
- [ ] Emergency stop inside radiation
- [ ] Platform moving into zone → blocks path

## Iteration & Balancing Guidelines

**Key Tunable Parameters:**
- Distance Platform 1 → Portal: 85–95% screen width
- Radiation zone size: 15–25% screen width each
- Damage rate: 8–12 hp/s (tune so 2–3s inside = death)
- Moving A/B speeds: 80–140 px/sec
- Rotating angular speed: 75–110 deg/sec
- Plasma Orb positions: Orb1 safe near A, Orb2 risky near rotating
- Fuel cost per small burst: 4-5 units
- Fuel restored per orb: 20–24 units
- Off-screen timeout: 4 seconds
- Portal size: 1.35× drone diameter

**How to Iterate:**
1. Playtest 10+ players after L4
2. Track: % completing with zero damage, avg thrusts, health left on win
3. If >70% die to radiation → reduce damage rate or enlarge safe gaps
4. If too easy → increase damage or add second zone overlap
5. If fuel-outs dominant → increase orb reward slightly

**Success Target for Level 5:**
- First-try completion: 30–45%
- Average attempts: 3.0–4.5
- Zero-damage completions: 40%+
- Orb collection (at least 2): 60%+

## Visual Feedback Recommendations
- Radiation zones: pulsing red semi-transparent rectangles + particle haze
- Drone: red glow + health bar popup when damaged
- Thrust preview: turns orange/red if path enters zone
- Fuel bar: critical red at 20%
- Win animation: green flash + "Hazard Avoided!" text
- Overlay tip: "Stay out of the red zones!"

## Collectible & Portal Sizes (Progressive Difficulty)

**Plasma Orb size**  
- Visual radius: **1.3–1.5 × drone radius**  
- Collision hitbox: **1.7 × drone radius**  
- Reason: Risky placement near hazards  
- Later levels: smaller & more dangerous

**Exit Portal size**  
- Visual width/height: **1.35–1.6 × drone diameter**  
- Collision hitbox: **1.25 × drone diameter**  
- Reason: Precision needed after hazard navigation  
- Later levels: reduce further

This level marks the shift to **hazard management** alongside momentum & timing — core for mid-to-late game challenge.

## Game Over / Termination Logic

**Triggers (in order of priority check):**

1. Fuel ≤ 0  
   → Immediate game over  
   → Show "Out of Fuel" overlay  

2. Health ≤ 0 (radiation)  
   → Immediate game over  
   → Show "Radiation Overload" overlay  

3. Drone off-screen > timeout (default 4 seconds)  
   → Game over  
   → Show "Lost in Space" overlay  

4. (Optional) Time limit 210 seconds exceeded  
   → Game over  
   → Show "Time's Up" overlay  

**Overlay / Termination Screen Rules:**
- Pause game physics & timers (all platforms & hazards freeze)
- Semi-transparent dark overlay
- Large centered text (e.g. "OUT OF FUEL", "RADIATION OVERLOAD", "LOST IN SPACE")
- Two or three large buttons:
  - "Retry" (primary, green)
  - "Watch Ad" (+fuel/revive – rewarded video)
  - "Menu" (secondary, gray)
- No auto-restart
- Reset fuel to 68 & health to 100 on retry
- Keep current level progress

**Additional Termination Notes for Level 5:**
- All moving/rotating elements & radiation effects pause on game over
- Tip in overlay: "Avoid red zones or escape quickly!"
- New lose reason (health) introduced — make message clear
```