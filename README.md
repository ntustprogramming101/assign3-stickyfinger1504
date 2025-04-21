# 🕹️ Assignment 3: Platform Jump Game - Code Breakdown

This assignment is divided into **3 stages**. Each stage contains multiple mini-practices to help you implement a working platformer game step by step.

---

## 📦 STAGE 01: Platform Initialization & Movement

### ✅ Practice 1-1  
**Goal:** Initialize platforms with random positions  
- Randomize horizontal position (`x`)
- Evenly distribute vertically (`y`)

### ✅ Practice 1-2  
**Goal:** Make the platforms **scroll upward**  
- Move platforms upward every frame
- Reset to the bottom and randomize position when they go off screen

---

## 🎮 STAGE 02: Basic Player Movement & Collision

### ✅ Practice 2-1  
**Goal:** Control player **horizontal movement**  
- Use `keyPressed()` and `keyReleased()` to change direction
- Move the player accordingly

### ✅ Practice 2-2  
**Goal:** Check for **platform collision using AABB function**  
- Write `isALandingOnB()` to detect landing
- Use this in `handlePlatformCollision()`

### ✅ Practice 2-3  
**Goal:** Define behavior when the player **hits the ceiling or falls below**  
- Handle ceiling collisions with bounce/damage
- Handle bottom collisions as game over

---

## 💥 STAGE 03: Damage System & Animation Control

### ✅ Practice 3-1  
**Goal:** Handle **invincibility and damage states**  
- Add flags and timers for invincibility and blinking effect

### ✅ Practice 3-2  
**Goal:** Prevent taking damage if the player is already invincible or damaged  
- Add condition checks before applying damage

### ✅ Practice 3-3  
**Goal:** Cycle through **animation frames** when moving  
- Animate the player’s sprite left/right using a timer
