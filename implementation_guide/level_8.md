```markdown
# Level 8 - "Void Drift"

## Level Description
Introduces black holes: inescapable gravitational pull zones (instant death if sucked in).  
Ultimate mid-game challenge — predict & counter all forces (wind, magnets, rotation, radiation) while avoiding black hole event horizons.

## Objective
Reach the Exit Portal using 6–11 thrusts max while collecting at least 3 Plasma Orbs.  
Master all forces to skirt black holes safely.

## Starting Fuel
60 units (extremely tight — perfect planning required)

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
║   ➤➤➤  ⚡ N  ███  ↺ [=====] ↻   🕳️   ⚡ S  ➤➤➤        ║
║         ████████████                                    ║
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

   <---[=====]--->   ➤➤➤  ⚡ N  ███  ↺ [=====] ↻   🕳️   ⚡ S  ➤➤➤
                                 * 
                      <---[=====]--->
```

**Thrust 1 → Wind + Magnet to A**
```
          *
============
           O →→→  (multi-curve)

      [=====]--->   ➤➤➤  ⚡ N  ███  ↺ [=====] ↻   🕳️
```

**Thrust 2 → Dodge Radiation + Skirt Black Hole to Rotating**
```
                    *
============
                     O → (precise skirt)

           ↺ [=====] ↻   🕳️
                        *
                   <---[=====]--->
```

**Thrust 3–4 → Rotation Boost + Forces to B + Orb 3**
```
                              *
============
                               O →→ (all forces)

                      ↺ [=====] ↻
                           <---[=====]--->
```

**Final Thrust 5–6 → Portal**
```
                                       []
                                      O →→→→
```

## Multiple Success Paths

**Path A (Recommended - 8 thrusts)**
- Multi-force to A → skirt black hole to rotating → full combo to B → portal + 3 orbs

**Path B (Elite - 6 thrusts)**
- God-tier drift: all forces aligned for single long path skirting black hole

**Path C (Desperate - 9–11 thrusts)**
- Frequent stops/corrections, orb-hunting for fuel survival

## Common Failure Scenarios & Recovery

1. **Sucked into black hole** → instant death  
   → Recovery: none (retry)

2. **Forces push toward event horizon**  
   → Recovery: desperate counter-thrust (often too late)

3. **Black hole pulls platforms off path**  
   → Recovery: predict altered timing

4. **Fuel gone from endless corrections**  
   → "Out of Fuel"

5. **Wind/magnet flings into void**  
   → "Lost in Space"

## Edge Cases to Handle

- Grazing black hole horizon → strong pull but escapable
- Thrust directly away from black hole (max power needed)
- Orb near horizon (risky reward)
- Stop near black hole (slow drag-in)
- Black hole + wind/magnet interactions (chaotic vectors)
- Multiple near-misses
- Visual distortion near horizon

## Step-by-Step Gameplay Flow

1. Level starts → All chaos active + black hole swirling (hint: "Skirt the black hole carefully!")
2. Hints (40s): curved path skirting void
3. Thrust chaining all forces to A
4. Precise skirt of black hole to rotating
5. Ride + thrust to B/orbs/portal
6. Collect 3 orbs (+15–19 fuel each)
7. Win → "Void Survivor!" message

## Win Condition
Drone physically overlaps with Exit Portal

## Lose Conditions
- Fuel ≤ 0
- Off-screen > 3.5 seconds
- Health ≤ 0 (radiation)
- Enter black hole horizon → "Sucked Into Void"
- (Optional) Time >260s

## Black Hole Mechanics (New!)
- Pull strength: 300–500 px/s² (increases closer)
- Event horizon: 40–60 px radius (instant death)
- Visual warp/distortion near edge
- Affects all drifts/particles

## Testing Checklist (Important!)

**Must Test These Scenarios:**
- [ ] 8-thrust full combo skirt
- [ ] 6-thrust elite path
- [ ] 9+ survival path
- [ ] Sucked into black hole
- [ ] Forces toward horizon
- [ ] Fuel from corrections
- [ ] Orbs near void
- [ ] Thrust near black hole
- [ ] Stop vs pull
- [ ] All-force chaos

## Iteration & Balancing Guidelines

**Key Tunable Parameters:**
- Distance: 90–100% screen width
- Black hole pull: 300–500 px/s²
- Horizon radius: 40–60 px
- Prior mechanics: intensified 10–20%
- Orbs: 3 in risky spots
- Fuel burst: 4-5 units
- Orb restore: 15–19 units
- Timeout: 3.5s
- Portal: 1.2× drone

**How to Iterate:**
1. Playtest post-L7
2. Track: % void deaths, final resources
3. If >85% void deaths → weaken pull/widen skirt gap
4. If unbeatable → extra orb/slower platforms
5. If too easy → stronger pull

**Success Target for Level 8:**
- First-try: 15–30%
- Avg attempts: 4.5–6.0
- Void avoidance: 45%+
- 3+ orbs: 45%+

## Visual Feedback Recommendations
- Black hole: swirling void + warp shader + particles sucked in
- Drone: danger shake/pull lines near horizon
- Preview: warped curve prediction
- Fuel: ultra-red at 5%
- Win: escape burst + "Void Survivor!"
- Tip: "Never enter the black hole!"

## Collectible & Portal Sizes (Progressive Difficulty)

**Plasma Orb size**  
- Visual: 1.0–1.2 × drone  
- Hitbox: 1.4 × drone  
- Reason: Void-edge risks

**Exit Portal size**  
- Visual: 1.2–1.4 × drone  
- Hitbox: 1.1 × drone  
- Reason: Post-chaos precision

Mastery of **all mechanics** tested here — gateway to endless mode.

## Game Over / Termination Logic

**Triggers:**
1. Fuel ≤ 0 → "Out of Fuel"
2. Health ≤ 0 → "Radiation Overload"
3. Black Hole → "Sucked Into Void"
4. Off-screen >3.5s → "Lost in Space"
5. Time >260s → "Time's Up"

**Overlay Rules:**
- Pause universe
- Dramatic message + buttons
- Tip: "Master the void next time!"
