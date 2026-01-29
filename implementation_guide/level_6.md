```markdown
# Level 6 - "Magnetic Drift"

## Level Description
Introduces magnetic coils that curve the drone's trajectory (attract or repel).  
Combined with moving/rotating platforms and radiation hazards — players must use magnets strategically for path correction or boosts while avoiding dangers.

## Objective
Reach the Exit Portal using 5–9 thrusts max while collecting at least 2 Plasma Orbs.  
Harness magnets to curve drifts precisely around hazards and platforms.

## Starting Fuel
65 units (tight — magnets help save fuel on corrections)

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
║   ⚡ N   ████████████   ↺ [=====] ↻   ← Rotating       ║
║            ████████████                                 ║
║                          *   ← Plasma Orb 2            ║
║                                                        ║
║             <---[=====]--->   ← Moving Platform B      ║
║                                                        ║
║                          ⚡ S              []  Exit     ║
║                                                        ║
╚════════════════════════════════════════════════════════╝
```

## ASCII Storyboard - Main Success Path

**Start Position**
```
     *
============
      O

   <---[=====]--->   ████████████   ↺ [=====] ↻
⚡ N                       * 
                      <---[=====]--->   ⚡ S
```

**Thrust 1 → Use North Magnet Curve to Moving A**
```
          *
============
           O →→→  (curves via ⚡ N)

      [=====]--->   ████████████   ↺ [=====] ↻
```

**Thrust 2 → Quick Radiation Pass + Rotate Land**
```
                    *
============
                     O → (curved safe)

           ↺ [=====] ↻
                        *
                   <---[=====]--->
```

**Thrust 3 → South Magnet Boost to B**
```
                              *
============
                               O →→ (magnet slingshot)

                      ↺ [=====] ↻
                           <---[=====]--->
```

**Final Thrust 4–5 → Portal**
```
                                       []
                                      O →→→→
```

## Multiple Success Paths

**Path A (Recommended - 6 thrusts)**
- Magnet curve to A → radiation dodge to rotating → magnet boost from B → portal

**Path B (Expert - 4–5 thrusts)**
- Long drift using dual magnets for S-curve directly over hazards to portal

**Path C (Fuel-Cautious - 7–9 thrusts)**
- Short hops, use magnets for micro-corrections, collect all orbs

## Common Failure Scenarios & Recovery

1. **Magnet pulls into radiation/hazard**  
   → Recovery: counter-thrust away (fuel cost)

2. **Wrong magnet polarity → repels off course**  
   → Recovery: switch to opposite magnet or emergency stop

3. **Platforms move out of magnet-assisted path**  
   → Recovery: time thrust with platform phase

4. **Fuel drain from fighting magnets**  
   → "Out of Fuel"

5. **Over-curved trajectory → off-screen**  
   → "Lost in Space"

## Edge Cases to Handle

- Drone enters/exits magnet field mid-drift (smooth curve transition)
- Thrust inside magnet field (instant + curved impulse)
- Collecting orb near magnet edge (pulled in/out)
- Double-tap stop in strong magnet (fights pull)
- Magnets affecting platform movement? (no — only drone)
- Multiple magnets overlapping (vector sum force)
- Grazing magnet → subtle curve only

## Step-by-Step Gameplay Flow

1. Level starts → Drone on Platform 1, platforms/magnets/hazards active (hint: "Use magnets to curve your path!")
2. Hint arrows (30s) show magnet-curved path to first platform
3. Player aims → thrust curves via North magnet to Moving A
4. From A → timed thrust dodging radiation to rotating
5. Ride rotation → magnet-boosted thrust to B or portal
6. Collect orbs (+18–22 fuel each)
7. Drift into Exit Portal → Level Complete + "Magnetic Master!" message

## Win Condition
Drone physically overlaps with Exit Portal (any part touches portal area)

## Lose Conditions
- Fuel ≤ 0
- Drone off-screen for > 4 seconds
- Health ≤ 0 (radiation)
- (Optional) Time limit 220 seconds (disabled in early playtests)

## Radiation Damage Mechanics
- Damage rate: 9–13 hp/s inside zone
- Starting health: 100

## Testing Checklist (Important!)

**Must Test These Scenarios:**
- [ ] 6-thrust magnet-assisted path
- [ ] 4–5 thrust dual-magnet S-curve
- [ ] 7+ thrust correction-heavy path
- [ ] Pulled into radiation by magnet
- [ ] Repelled off platforms
- [ ] Fuel out fighting magnets
- [ ] Collecting orbs in magnet fields
- [ ] Thrust inside magnet
- [ ] Emergency stop vs magnet pull
- [ ] Overlapping magnet effects

## Iteration & Balancing Guidelines

**Key Tunable Parameters:**
- Distance Platform 1 → Portal: 87–97% screen width
- Magnet strength: 150–250 px/s² (curve radius 200–400 px)
- North/South polarity range: 12–20% screen width each
- Radiation zones: 16–26% screen width
- Moving/Rotating speeds: slightly faster than L5
- Plasma Orb positions: Orb1 safe curve path, Orb2 magnet-adjacent
- Fuel cost per small burst: 4-5 units
- Fuel restored per orb: 18–22 units
- Off-screen timeout: 4 seconds
- Portal size: 1.3× drone diameter

**How to Iterate:**
1. Playtest 10+ players after L5
2. Track: % using magnets effectively, avg health/fuel on win
3. If >75% ignore magnets → stronger pull or better hints
4. If deaths from magnet+radiation >30% → weaken magnets or widen safe gaps
5. If too punishing → lower damage/fuel costs

**Success Target for Level 6:**
- First-try completion: 25–40%
- Average attempts: 3.5–5.0
- Magnet usage (intentional curves): 55%+
- Orb collection (at least 2): 55%+

## Visual Feedback Recommendations
- Magnets: ⚡ icons pulsing blue/red + field lines curving example paths
- Drone: magnet trail lines when affected
- Thrust preview: animated curved prediction line through magnets
- Fuel bar: critical red at 15%
- Win: magnetic spark confetti + "Magnetic Master!"
- Overlay tip: "Let magnets guide your drifts!"

## Collectible & Portal Sizes (Progressive Difficulty)

**Plasma Orb size**  
- Visual radius: **1.2–1.4 × drone radius**  
- Collision hitbox: **1.6 × drone radius**  
- Reason: Tricky grabs during curved drifts  
- Later levels: smaller

**Exit Portal size**  
- Visual width/height: **1.3–1.5 × drone diameter**  
- Collision hitbox: **1.2 × drone diameter**  
- Reason: Precision after magnet boosts  
- Later levels: reduce

This level emphasizes **environmental tools** (magnets) for advanced pathing amid growing complexity.

## Game Over / Termination Logic

**Triggers (in order of priority check):**

1. Fuel ≤ 0 → "Out of Fuel"
2. Health ≤ 0 → "Radiation Overload"
3. Off-screen > 4s → "Lost in Space"
4. (Optional) Time >220s → "Time's Up"

**Overlay Rules:**
- Pause everything (platforms, magnets, hazards)
- Dark overlay + specific message
- Retry (reset fuel/health) | Ad Revive | Menu
- Tip: "Use magnets to curve safely!"
