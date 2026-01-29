# Nexus Drift - Implementation Guide

## Game Overview
Nexus Drift is a momentum-based zero-gravity drifting game. The player controls a small scout drone that moves only through short thruster bursts. There is no friction or gravity — once the drone gains velocity, it continues drifting until the player applies another thrust.

## Core Mechanics (Logic Only)

### 1. Thrust System
- Player taps and holds on screen → thrust direction is calculated from drone position to tap position.
- Hold duration determines thrust power (0.1s = weak micro-burst, 0.8s = strong burst).
- Each thrust consumes fuel proportional to power.
- Thrust applies instant velocity change in the chosen direction.

### 2. Inertia & Momentum
- Drone keeps current velocity indefinitely (no damping).
- Player must plan trajectories and use micro-corrections.
- Rotation is optional: drone can face thrust direction or remain fixed.

### 3. Collision Logic
- Drone collides with platforms, debris, and walls.
- On collision: velocity is reflected or reduced based on platform type.
  - Normal platforms → elastic bounce (keep most momentum)
  - Soft debris → velocity dampened
  - Spinning objects → possible momentum transfer

### 4. Fuel System
- Starting fuel: 100 units
- Small burst: 8-12 fuel
- Medium burst: 15-25 fuel
- Large burst: 35+ fuel
- Plasma Orbs restore 20–40 fuel when collected.

### 5. Win Condition
- Drone must physically touch the Exit Portal.
- Portal activates only when all required objectives are met (optional).

### 6. Lose Conditions
- Fuel reaches 0
- Drone drifts off-screen for more than 4 seconds
- Hits deadly hazard (radiation, spikes, black hole)

### 7. General Level Structure
- Background: static or slowly moving deep space
- Platforms: static, moving, rotating
- Collectibles: Plasma Orbs (fuel)
- Hazards: optional in early levels
- Exit Portal: glowing rectangular gate

## Controls Logic
- Single tap & hold → aim + charge thrust
- Release → apply thrust instantly
- Double tap → emergency stop (strong opposing thrust, high fuel cost)

## Recommended Progression Curve
Level 1–10 → Teach basics (thrust, inertia, collection)
Level 11–30 → Introduce moving/rotating platforms
Level 31+ → Complex momentum puzzles, tight fuel management