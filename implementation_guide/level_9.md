```markdown
# Level 9 - "Debris Drift"

## Level Description
Introduces debris fields: clusters of small, fast-moving obstacles that bounce off drone/platforms and can destroy on direct collision.  
Full chaos mode — all prior mechanics + debris requires split-second timing and path prediction.

## Objective
Reach the Exit Portal using 6–12 thrusts max while collecting at least 4 Plasma Orbs.  
Weave through debris while mastering force chains.

## Starting Fuel
58 units (critically low — debris collection mandatory for survival)

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
║      <---[=====]--->   ●●●●●  ➤➤➤  ⚡ N  🕳️             ║
║   ➤➤➤  ███  ↺ [=====] ↻   ●●●●●   ████████████        ║
║         ████████████   ⚡ S                             ║
║                          *   ← Plasma Orb 2            ║
║                                                        ║
║             <---[=====]--->   ●●●●●   []  Exit          ║
║                                                        ║
╚════════════════════════════════════════════════════════╝
```

## ASCII Storyboard - Main Success Path

**Start Position**
```
     *
============
      O

   <---[=====]--->   ●●●●●  ➤➤➤  ⚡ N  🕳️
➤➤➤  ███  ↺ [=====] ↻   ●●●●●   ████████████
⚡ S                       * 
                      <---[=====]--->   ●●●●●
```

**Thrust 1 → Dodge Debris to A + Wind**
```
          *
============
           O →→→  (weave ●●●)

      [=====]--->   ●●●●●  ➤➤➤  ⚡ N  🕳️
```

**Thrust 2 → Debris + Radiation Skirt to Rotating**
```
                    *
============
                     O → (precise weave)

           ↺ [=====] ↻   ●●●●●   ████████████
```

**Thrust 3–5 → Full Chaos Chain to B + Orbs**
```
                              *
============
                               O →→ (master weave)

                      ↺ [=====] ↻
                           <---[=====]--->   ●●●●●
```

**Final Thrust 6 → Portal**
```
                                       []
                                      O →→→→
```

## Multiple Success Paths

**Path A (Recommended - 9 thrusts)**
- Debris-weave to A → skirt void/radiation to rotating → chaos chain to B + 4 orbs → portal

**Path B (Legend - 7 thrusts)**
- Flawless multi-force weave through all debris directly to portal

**Path C (Grind - 10–12 thrusts)**
- Stop-start through debris, orb-farm for fuel

## Common Failure Scenarios & Recovery

1. **Debris collision** → instant destruction  
   → Recovery: none (retry)

2. **Debris blocks force-assisted path**  
   → Recovery: micro-timing thrust around cluster

3. **Debris bounces into black hole/hazards**  
   → Recovery: predict chain reactions

4. **Fuel starved by debris dodges**  
   → "Out of Fuel"

5. **Pushed into debris by forces**  
   → "Lost in Space"

## Edge Cases to Handle

- Debris bouncing off platforms/drone (physics chain)
- Thrust through debris cluster (risky)
- Orb behind debris wall
- Stop in debris field (surround danger)
- Debris + all forces (unpredictable)
- Fast debris grazing (scrape damage?)
- Cluster density varying

## Step-by-Step Gameplay Flow

1. Level starts → Total mayhem: debris flying + all forces/hazards (hint: "Weave through the debris!")
2. Hints (45s): weave path through clusters
3. Thrust dodging debris to A
4. Chain weave: A → rotating → B/orbs
5. Collect 4 orbs (+14–18 fuel each)
6. Win → "Debris Dancer!" message

## Win Condition
Drone physically overlaps with Exit Portal

## Lose Conditions
- Fuel ≤ 0
- Off-screen > 3.2 seconds
- Health ≤ 0 (radiation)
- Black Hole entry
- Debris collision → "Debris Collision"
- (Optional) Time >280s

## Debris Mechanics (New!)
- Speed: 120–220 px/s random directions
- Size: 0.4–0.8 × drone
- Collision: destroy drone (bounce off platforms)
- Density: 8–15 pieces per field

## Testing Checklist (Important!)

**Must Test These Scenarios:**
- [ ] 9-thrust weave chain
- [ ] 7-thrust flawless path
- [ ] 10+ grind path
- [ ] Debris direct hit
- [ ] Bounced into hazards
- [ ] Fuel from dodges
- [ ] Orbs in debris
- [ ] Thrust thru debris
- [ ] Stop in field
- [ ] Full chaos physics

## Iteration & Balancing Guidelines

**Key Tunable Parameters:**
- Distance: 92–100% screen width
- Debris speed/density: 120–220 px/s, 8–15 pcs
- Prior mechanics: max intensity
- Orbs: 4 in debris paths
- Fuel burst: 4-5 units
- Orb restore: 14–18 units
- Timeout: 3.2s
- Portal: 1.15× drone

**How to Iterate:**
1. Playtest post-L8
2. Track: % debris deaths, resources on win
3. If >90% debris deaths → lower density/speed
4. If impossible → safe gaps/orb buffs
5. If survivable → add debris

**Success Target for Level 9:**
- First-try: 10–25%
- Avg attempts: 5.0–7.0
- Debris avoidance: 35%+
- 4+ orbs: 40%+

## Visual Feedback Recommendations
- Debris: metallic chunks + trails + collision sparks
- Drone: danger proximity glow/shake near debris
- Preview: debris-aware prediction (dotted obstacles)
- Fuel: panic flash at 3%
- Win: explosive clear + "Debris Dancer!"
- Tip: "Time your weaves perfectly!"

## Collectible & Portal Sizes (Progressive Difficulty)

**Plasma Orb size**  
- Visual: 0.9–1.1 × drone  
- Hitbox: 1.3 × drone  
- Reason: Debris-blocked grabs

**Exit Portal size**  
- Visual: 1.15–1.35 × drone  
- Hitbox: 1.05 × drone  
- Reason: End-game precision

Near-endgame pinnacle — tests **total mastery**.

## Game Over / Termination Logic

**Triggers:**
1. Fuel ≤ 0 → "Out of Fuel"
2. Health ≤ 0 → "Radiation Overload"
3. Black Hole → "Sucked Into Void"
4. Debris Hit → "Debris Collision"
5. Off-screen >3.2s → "Lost in Space"
6. Time >280s → "Time's Up"

**Overlay Rules:**
- Pause apocalypse
- Explosive message + buttons
- Tip: "Predict debris bounces!"

