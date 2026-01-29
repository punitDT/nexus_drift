```markdown
# Level 7 - "Wind Drift"

## Level Description
Introduces solar wind zones that apply constant directional force (push/boost).  
Players must predict wind effects on drifts, combining with magnets, rotation, radiation, and moving platforms for precise navigation.

## Objective
Reach the Exit Portal using 5–10 thrusts max while collecting at least 3 Plasma Orbs.  
Use wind for boosts but avoid being pushed into hazards.

## Starting Fuel
62 units (very tight — wind can save or waste fuel dramatically)

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
║   ➤➤➤➤➤  ████████████   ↺ [=====] ↻   ⚡ N           ║
║            ████████████                                ║
║                          *   ← Plasma Orb 2            ║
║                                                        ║
║             <---[=====]--->   ← Moving Platform B      ║
║                                                        ║
║                          ⚡ S     ➤➤➤➤➤   []  Exit    ║
║                                                        ║
╚════════════════════════════════════════════════════════╝
```

## ASCII Storyboard - Main Success Path

**Start Position**
```
     *
============
      O

   <---[=====]--->   ➤➤➤➤➤  ████████████   ↺ [=====] ↻   ⚡ N
⚡ S                       * 
                      <---[=====]--->   ➤➤➤➤➤
```

**Thrust 1 → Wind Boost to Moving A**
```
          *
============
           O →→→  (wind ➤ pushes right)

      [=====]--->   ➤➤➤➤➤  ████████████   ↺ [=====] ↻
```

**Thrust 2 → Wind + Magnet Dodge Radiation**
```
                    *
============
                     O → (wind ➤ + ⚡ curve)

           ↺ [=====] ↻
                        *
                   <---[=====]--->
```

**Thrust 3 → Rotation + Wind to B + Orb 3**
```
                              *
============
                               O →→ (multi-boost)

                      ↺ [=====] ↻
                           <---[=====]--->
```

**Final Thrust 4–5 → Portal**
```
                                       []
                                      O →→→→
```

## Multiple Success Paths

**Path A (Recommended - 7 thrusts)**
- Wind to A → magnet/wind dodge to rotating → wind boost to B → collect 3 orbs → portal

**Path B (Master - 5 thrusts)**
- Expert multi-force drift: wind + magnets curve over all hazards directly to portal

**Path C (Survival - 8–10 thrusts)**
- Frequent corrections against wind, micro-hops for orbs/safety

## Common Failure Scenarios & Recovery

1. **Wind pushes into radiation/magnet wrong-way**  
   → Recovery: fight with thrust (high fuel cost)

2. **Over-boosted by wind → uncontrollable overshoot**  
   → Recovery: emergency counter-thrust

3. **Wind shifts platforms out of reach**  
   → Recovery: predict wind + platform phase

4. **Fuel depleted fighting wind constantly**  
   → "Out of Fuel"

5. **Pushed off-screen by wind**  
   → "Lost in Space"

## Edge Cases to Handle

- Entering/exiting wind zone mid-drift (smooth acceleration)
- Thrust countering wind (reduced effective power)
- Orb collection in wind (pushed toward/away)
- Double-tap stop in strong wind (slow deceleration)
- Wind interacting with magnets (combined forces)
- Multiple wind zones (directional variety)
- Wind affecting visual trails/preview

## Step-by-Step Gameplay Flow

1. Level starts → Drone on Platform 1, all elements active incl. wind streams (hint: "Ride the solar wind!")
2. Hint arrows (35s) show wind-boosted paths
3. Player aims → thrust + wind to Moving A
4. Chain: A → wind/magnet to rotating → wind to B
5. Collect 3 orbs (+16–20 fuel each)
6. Final wind-assisted drift to portal → Level Complete + "Wind Rider!" message

## Win Condition
Drone physically overlaps with Exit Portal (any part touches portal area)

## Lose Conditions
- Fuel ≤ 0
- Drone off-screen for > 4 seconds
- Health ≤ 0 (radiation)
- (Optional) Time limit 240 seconds (disabled in early playtests)

## Mechanics Recap
- Radiation: 10–14 hp/s
- Magnets: 160–260 px/s²
- Solar Wind: constant 100–180 px/s push in zone direction

## Testing Checklist (Important!)

**Must Test These Scenarios:**
- [ ] 7-thrust wind-boosted chain
- [ ] 5-thrust multi-force expert path
- [ ] 8+ thrust wind-fighting path
- [ ] Pushed into hazards by wind
- [ ] Over-boosted overshoots
- [ ] Fuel out vs wind
- [ ] Orbs in wind zones
- [ ] Thrust in wind
- [ ] Stop vs wind
- [ ] Wind + magnet + rotation combos

## Iteration & Balancing Guidelines

**Key Tunable Parameters:**
- Distance Platform 1 → Portal: 88–98% screen width
- Wind speed: 100–180 px/s per zone
- Wind zone size: 18–28% screen width
- Radiation/Magnet strengths: slightly up from L6
- Platforms faster/phased oppositely
- Plasma Orb positions: 3 orbs in wind paths
- Fuel cost per small burst: 4-5 units
- Fuel restored per orb: 16–20 units
- Off-screen timeout: 3.8 seconds (tighter)
- Portal size: 1.25× drone diameter

**How to Iterate:**
1. Playtest 10+ after L6
2. Track: % using wind boosts, final fuel/health
3. If >80% fight wind → weaken or add more favorable zones
4. If chaos from combos → reduce strengths 10%
5. If too hard → more orbs or hints

**Success Target for Level 7:**
- First-try: 20–35%
- Avg attempts: 4.0–5.5
- Wind boost usage: 50%+
- Orb collection (3+): 50%+

## Visual Feedback Recommendations
- Wind zones: ➤ arrow streams + particle flow + color tint (yellow/orange)
- Drone: wind trail lines + speedometer glow when boosted
- Thrust preview: animated with wind curve prediction
- Fuel bar: flashing red at 10%
- Win: windy confetti burst + "Wind Rider!"
- Tip: "Let wind carry you!"

## Collectible & Portal Sizes (Progressive Difficulty)

**Plasma Orb size**  
- Visual radius: **1.1–1.3 × drone radius**  
- Collision hitbox: **1.5 × drone radius**  
- Reason: Hard grabs in windy drifts

**Exit Portal size**  
- Visual width/height: **1.25–1.45 × drone diameter**  
- Collision hitbox: **1.15 × drone diameter**  
- Reason: Nail wind-boosted precision

This level demands **force prediction** across all mechanics — peak mid-game puzzle.

## Game Over / Termination Logic

**Triggers:**
1. Fuel ≤ 0 → "Out of Fuel"
2. Health ≤ 0 → "Radiation Overload"
3. Off-screen > 3.8s → "Lost in Space"
4. Time >240s → "Time's Up"

**Overlay Rules:**
- Pause all (wind, platforms, etc.)
- Specific message + buttons: Retry | Ad | Menu
- Tip: "Predict the wind next time!"
