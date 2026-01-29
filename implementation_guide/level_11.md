```markdown
# Level 11 - "Endless Drift"

## Level Description
Post-game endless mode: procedural hybrid levels with hand-crafted "waves" every 60–120 seconds.  
All mechanics scale infinitely — platforms speed up, hazards intensify, new rare elements spawn (e.g. wormholes).  
Goal: achieve highest score (distance + orbs + waves survived) for global leaderboards.

## Objective
Survive indefinitely, chaining procedural segments. Collect Plasma Orbs for fuel/multipliers.  
Beat your high score or climb leaderboards.

## Starting Fuel
50 units (base — orbs + wave bonuses restore)

## Screen Layout (Top-down view) - Example Wave 1

```
╔════════════════════════════════════════════════════════╗
║                  Infinite Space (procedural scroll)    ║
║                                                        ║
║             *                                          ║
║                                                        ║
║   =============   ← Spawn Point (respawn safe)         ║
║         O         ← Player Drone                       ║
║                                                        ║
║      <---[=====]--->   ●●●  ➤➤  ⚡  🕳️  ↺ [ ] ↻         ║
║   ➤➤  ███  ●●●  ↺ [=====] ↻   ●●●  ███  [WAVE END]    ║
║         ███   ⚡  ➤➤➤                                 ║
║                          *                             ║
║                                                        ║
║             <---[=====]--->   ●●●  🕳️  []  (next seg)  ║
║                                                        ║
╚════════════════════════════════════════════════════════╝
```

## ASCII Storyboard - Sample Endless Chain

**Wave 1 Start**
```
     *
============
      O

   <---[=====]--->   ●●●  ➤➤  ⚡  🕳️
```

**Mid-Wave Chaos Weave**
```
                    *
============
                     O → (scale-up dodge)

           ↺ [ ] ↻   ●●●  ███
```

**Wave Transition (Boss Segment)**
```
[WAVE 2]  (faster everything + mega black hole)
               []
              O →→→→→
```

**High Score Drift**
```
... endless repeat with scaling ...
```

## Multiple Success Paths

**Path A (Survival - Adaptive thrusts)**
- Weave current wave → collect orbs → survive transition → adapt to next procedural segment

**Path B (Aggressive - Speedrun waves)**
- Risky god-drifts through waves for multipliers (3x score if zero-death wave)

**Path C (Orb-Farm - Conservative)**
- Safe hops, max orbs for fuel buffer against scaling

## Common Failure Scenarios & Recovery

1. **Scaling overwhelms (speed/density too high)**  
   → Recovery: orb farm earlier waves for buffer

2. **Wave transition trap (mega-hazard spike)**  
   → Recovery: none — prepare with full fuel

3. **Proce-gen unlucky spawn**  
   → Recovery: restart run (daily seeds mitigate)

4. **Fuel starve in late waves**  
   → "Out of Fuel"

5. **Chain death from debris/void**  
   → "Lost in Void"

## Edge Cases to Handle

- Procedural spawn fairness (no instant-death starts)
- Wave boss: temporary mega black hole or debris storm
- Wormhole rare spawn: teleport to random safe/unsafe spot
- Score multipliers: 5x orbs = 2x points
- Run pause/resume (offline progress)
- Leaderboard sync
- Daily challenge seeds

## Step-by-Step Gameplay Flow

1. Start → Wave 1 procedural (hints fade after 90s)
2. Survive segments → collect orbs → wave complete (bonus fuel/score)
3. Transition: 10s safe zone + boss hazard
4. Wave N: all mechanics +10% intensity per wave
5. Death → high score screen + leaderboard
6. Replay with same seed or random

## Win Condition
Endless — high score = distance (px traveled) + orbs * 100 + waves * 500 + multipliers

## Lose Conditions
- Fuel ≤ 0
- Off-screen > 2.8 seconds
- Health ≤ 0
- Black Hole / Debris / Vanish Fall
- Wave boss kill → "Wave Overload"

## Procedural Mechanics (New!)
- Hybrid: 70% procedural, 30% hand-crafted wave templates
- Scaling: +8% speed/density per wave
- Rare (1/10 waves): wormholes (teleport + fuel bonus/risk)
- Seeds: daily global + personal random

## Testing Checklist (Important!)

**Must Test These Scenarios:**
- [ ] 5+ waves survival
- [ ] Wave transition boss
- [ ] Procedural fairness (100 seeds)
- [ ] Late-wave scaling (wave 20+)
- [ ] Orb multiplier exploits
- [ ] Wormhole teleports
- [ ] Offline pause/resume
- [ ] Leaderboard edge cases
- [ ] Daily seed sync
- [ ] High-score overflow

## Iteration & Balancing Guidelines

**Key Tunable Parameters:**
- Wave scale: +8% intensity/wave
- Boss hazard: 150% normal
- Wormhole rarity: 10%
- Orb spawn: 4–6/wave
- Fuel burst: 4-5 units
- Orb restore: 12–16 units (+ scaling bonus)
- Timeout: 2.8s
- Portal (wave end): 1.05× drone

**How to Iterate:**
1. Playtest long runs (top 1%)
2. Track: avg waves survived, quit rate per wave
3. If drop-off wave 3+ → nerf early scaling
4. If stale → more rare events
5. Balance seeds for 10–30 min avg runs

**Success Target for Level 11:**
- Avg player: 3–5 waves
- Top 10%: 10+ waves
- Global #1: 25+ waves
- Retention: 40% return daily

## Visual Feedback Recommendations
- Wave counter + score HUD
- Procedural gen preview (next wave silhouette)
- Scaling: screen shake + intensity ramp
- Wormhole: portal swirl + teleport FX
- High score: fireworks + rank badge
- Leaderboard: real-time ghosts (top runs)

## Collectible & Portal Sizes (Scaling Difficulty)

**Plasma Orb size**  
- Visual: 0.7–1.0 × drone (shrinks per wave)  
- Hitbox: 1.1 × drone  
- Reason: Late-wave needle-in-haystack

**Wave Portal size**  
- Visual: 1.05–1.25 × drone  
- Hitbox: 0.95 × drone (wave-scaled)  
- Reason: Reward mastery

Endless pinnacle — infinite replayability.

## Game Over / Termination Logic

**Triggers:**
1. Fuel ≤ 0 → "Fuel Exhausted"
2. Health ≤ 0 → "Radiation Fatal"
3. Black Hole → "Void Consumed"
4. Debris → "Shattered"
5. Vanish → "Fallen"
6. Wave Boss → "Overwhelmed"
7. Off-screen >2.8s → "Drifted Away"

**Overlay Rules:**
- Epic recap: waves/orbs/score
- Replay | Leaderboard | Daily Challenge | Menu
- Tip: "Beat your best tomorrow!"
