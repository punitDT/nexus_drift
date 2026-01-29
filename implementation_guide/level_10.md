```markdown
# Level 10 - "Nexus Core"

## Level Description
The finale: ALL mechanics combined at maximum intensity — moving/rotating platforms, radiation, magnets, wind, black holes, debris fields, PLUS vanishing platforms that cycle disappear/reappear.  
Ultimate test of mastery — one flawless run unlocks endless mode.

## Objective
Reach the Nexus Core Portal using 7–14 thrusts max while collecting at least 5 Plasma Orbs.  
Perfect orchestration of every force, timing, and dodge.

## Starting Fuel
55 units (survival threshold — orbs essential, no room for error)

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
║      <---[=====]--->   ●●●  ➤➤  ⚡ N  🕳️  ↺ [ ] ↻       ║
║   ➤➤➤  ███  ●●●  ↺ [=====] ↻   ●●●  ████████████      ║
║         ████████████   ⚡ S  ➤➤➤                       ║
║                          *   ← Plasma Orb 2            ║
║                                                        ║
║             <---[=====]--->   ●●●  🕳️  []  Exit         ║
║                                                        ║
╚════════════════════════════════════════════════════════╝
```

## ASCII Storyboard - Main Success Path

**Start Position**
```
     *
============
      O

   <---[=====]--->   ●●●  ➤➤  ⚡ N  🕳️  ↺ [ ] ↻
➤➤➤  ███  ●●●  ↺ [=====] ↻   ●●●  ████████████
⚡ S                       * 
                      <---[=====]--->   ●●●  🕳️
```

**Thrust 1 → Ultimate Weave to A**
```
          *
============
           O →→→  (chaos dodge)

      [=====]--->   ●●●  ➤➤  ⚡ N  🕳️
```

**Thrust 2–4 → Vanishing + Forces Chain**
```
                    *
============
                     O → (timed vanish)

           ↺ [ ] ↻   ●●●  ████████████
```

**Thrust 5–7 → Full Apocalypse to Portal + Orbs**
```
                                       []
                                      O →→→→
```

**Final Precision**
```
(5 orbs collected)
```

## Multiple Success Paths

**Path A (Recommended - 10 thrusts)**
- Chaos weave to A → vanish-timing chain → all forces/orbs → core

**Path B (God-Tier - 7–8 thrusts)**
- Single epic drift exploiting every mechanic perfectly

**Path C (Endurance - 11–14 thrusts)**
- Methodical orb-farm + safe hops through mayhem

## Common Failure Scenarios & Recovery

1. **Debris/Black Hole/Vanish combo kill** → instant  
   → Recovery: none

2. **Vanishing platform gone on arrival**  
   → Recovery: mid-air correction (fuel killer)

3. **Force overload into hazards**  
   → Recovery: none viable

4. **Fuel critically low mid-chaos**  
   → "Out of Fuel"

5. **Timing fail on vanish cycle**  
   → "Lost in Space"

## Edge Cases to Handle

- Vanish mid-land (fall through)
- Debris bouncing into black hole (chain explosions?)
- Thrust on vanishing edge
- All forces + debris + vanish (inferno)
- 5th orb ultra-risky
- Stop during vanish cycle
- Perfect symmetry exploits

## Step-by-Step Gameplay Flow

1. Level starts → Armageddon: everything maxed + platforms blinking vanish (hint: "Master the Nexus!")
2. Hints (60s): god-path overlay
3. Thrust into frenzy to A
4. Chain: vanish-sync + forces + dodges
5. Collect 5 orbs en route
6. Win → "Nexus Legend!" + endless unlock

## Win Condition
Drone overlaps Nexus Core Portal

## Lose Conditions
- Fuel ≤ 0
- Off-screen > 3.0 seconds
- Health ≤ 0
- Black Hole
- Debris Hit
- Fall through vanished platform → "Platform Vanished"
- (Optional) Time >300s

## Vanishing Platforms (New!)
- Cycle: 3s visible → 2s gone (predictable)
- 2 platforms affected
- Visual: fade + warning pulse

## Testing Checklist (Important!)

**Must Test These Scenarios:**
- [ ] 10-thrust master chain
- [ ] 7-thrust god run
- [ ] 11+ endurance
- [ ] Vanish fall-through
- [ ] Total chaos death
- [ ] Fuel/orb dependency
- [ ] 5 orbs
- [ ] All lose types
- [ ] Symmetry exploits
- [ ] Inferno physics

## Iteration & Balancing Guidelines

**Key Tunable Parameters:**
- Distance: full screen epic
- All prior: 120% intensity
- Vanish cycle: 3s/2s
- Orbs: 5 ultra-placed
- Fuel burst: 4-5 units
- Orb restore: 13–17 units
- Timeout: 3.0s
- Portal: 1.1× drone

**How to Iterate:**
1. Playtest veterans only
2. Track: % unlocks, resources
3. If 0% clear → nerf 5–10%
4. If easy → buff chaos
5. Polish god-path

**Success Target for Level 10:**
- First-try: 5–15%
- Avg attempts: 6.0–8.0+
- Full clear rate: 30%+
- 5 orbs: 35%+

## Visual Feedback Recommendations
- Vanish: dramatic fade + audio cue
- Nexus: pulsating core + epic particles
- Drone: overload glow in inferno
- Preview: full-chaos simulation
- Fuel: seizure flash <2%
- Win: supernova + "Nexus Legend!"
- Tip: "You're the master now."

## Collectible & Portal Sizes (Progressive Difficulty)

**Plasma Orb size**  
- Visual: 0.8–1.0 × drone  
- Hitbox: 1.2 × drone  
- Reason: Impossible grabs

**Exit Portal size**  
- Visual: 1.1–1.3 × drone  
- Hitbox: 1.0 × drone (pixel-perfect?)

Ultimate triumph — endless awaits.

## Game Over / Termination Logic

**Triggers:**
1. Fuel ≤ 0 → "Out of Fuel"
2. Health ≤ 0 → "Radiation Overload"
3. Black Hole → "Sucked Into Void"
4. Debris → "Debris Collision"
5. Vanish Fall → "Platform Vanished"
6. Off-screen >3.0s → "Lost in Space"
7. Time >300s → "Time's Up"

**Overlay Rules:**
- Cataclysmic pause
- Themed explosion + message
- Retry | Ad (full revive) | Menu
- Tip: "One more try for legend!"
