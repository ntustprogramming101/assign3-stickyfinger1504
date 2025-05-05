// AABB function to check for collision between two AABBs
boolean AABB(float ax, float ay, float aw, float ah, float bx, float by, float bw, float bh) {
  return (ax < bx + bw && ax + aw > bx && ay < by + bh && ay + ah > by);
}

class Player {
  float x, y, w = 30, h = 60, xSpeed = 5, ySpeed = 0, gravity = 0.4; // Position, size, speed, and physics
  int health = PLAYER_HEALTH; // Player's health
  int moveDir = 0; // Movement direction, 0=idle, 1=right, -1=left
  int spriteIndex = 0; // sprite index: 0=idle, 1=left, 2=right
  int animatedFrameIndex = 0; // animated frame index for the sprite
  boolean invincible = false, damaged = false; // Flags for invincibility and damage states
  int invincibilityTimer = INVINCIBILITY_DURATION, damageTimer = 0; // Timers for invincibility and damage
  float feetOffset = 5; // Offset for feet collision detection
  int timeOnPlatform = 0; // Track the time player spends on a platform

  Player() {
    x = width / 2; // Start the player in the middle of the screen
    y = 0; // Start the player at the top of the screen
  }

  void update() {
    if (health <= 0) return; // Stop updating if the player is dead

    // Handle horizontal movement
    if (moveDir != 0) {
      x += moveDir * xSpeed; // Move the player horizontally
      x = constrain(x, 0, width - w); // Keep the player within the screen bounds
    }

    ySpeed += gravity; // Apply gravity to the player's vertical speed
    y += ySpeed; // Update the player's vertical position

    handlePlatformCollision(); // Check for collisions with platforms
    handleCeilingBottomCollision(); // Check for collisions with the ceiling and bottom of the screen
    handleInvincibleAndDamage(); // Handle invincibility and damage states
    updateAnimation(); // Update the player's animation
  }

  void handlePlatformCollision() {
    boolean onPlatform = false; // Track if the player is standing on a platform

    for (Platform platform : platforms) {
      // Check if the player is falling and intersects with the platform
      if (AABB(x, y + h, w, 1, platform.x, platform.y, platform.w, platform.h) && ySpeed >= 0) {
        ySpeed = 0; // Stop falling
        y = platform.y - h; // Position the player above the platform
        timeOnPlatform++; // Increase the time the player spends on the platform
        onPlatform = true; // Player is standing on a platform
        break; // Exit the loop once the player has collided with a platform
      }
    }

    // If the player is on a platform for too long and the platform reaches the top
    if (onPlatform && y < 0) {
      if (!damaged) {
        health--; // Reduce health if player hits the top
        damaged = true; // Enable damaged state for blinking
        damageTimer = DAMAGE_BLINK_DURATION; // Set damage timer
      }
      timeOnPlatform = 0; // Reset platform time
    }
  }

  void handleCeilingBottomCollision() {
    // Handle collision with the bottom of the screen
    if (y + h > height) {
      y = height - h; // Position the player at the bottom of the screen
      ySpeed = 0; // Stop downward movement
      resetPosition(); // Reset player to top of screen after falling
    }

    // Handle collision with the top of the screen (ceiling)
    if (y < 0) {
      y = 0; // Position the player at the top of the screen
      ySpeed = 0; // Stop upward movement
    }
  }

  void handleInvincibleAndDamage() {
    if (damaged) {
      damageTimer--; // Decrease damage timer
      if (damageTimer <= 0) {
        damaged = false; // Turn off damaged state when timer runs out
      }
    }
  }

  void updateAnimation() {
    if (moveDir != 0) {
      animatedFrameIndex = (frameCount / ANIMATION_INTERVAL) % playerSprites[spriteIndex].length; // Cycle through frames
    } else {
      animatedFrameIndex = 0; // If idle, show the first frame
    }
  }

  void display() {
    PImage currentImage = playerSprites[spriteIndex][animatedFrameIndex];
    if (damaged && frameCount % 10 < 5) {
      tint(255, 0, 0); // Blink red when damaged
    } else {
      noTint(); // Remove any tint when not damaged
    }
    image(currentImage, x, y, w, h);
    noTint(); // Make sure to reset tint
  }

  void setMovement(int dir) {
    moveDir = dir;
    spriteIndex = (moveDir < 0) ? 1 : (moveDir > 0) ? 2 : 0;
  }

  void forceDropToBottom() {
    ySpeed += gravity; // Apply gravity to the player's velocity
    y += ySpeed; // Update the player's vertical position
    if (y > height) {
      y = height;
    }
  }

  // Reset player to the top of the screen after falling
  void resetPosition() {
    y = 0;
    x = width / 2; // Reset to center horizontally
    timeOnPlatform = 0; // Reset platform time
  }
}
