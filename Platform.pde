class Platform {
  float x, y, w = 80, h = 20; // Position and size of the platform
  
  Platform(float _x, float _y) {
    x = _x; // Set the initial x position
    y = _y; // Set the initial y position
  }

  void update() {
    // Stage 1-2: Move the platform upward with the scrolling background
    y -= SCROLL_SPEED; // Move the platform upwards with the background scroll speed

    // If the platform goes off the screen (above the top), reset it to the bottom
    if (y < -h) {
      y = height; // Reset platform to the bottom of the screen
      x = random(0, width - w); // Set a new random horizontal position
    }
  }

  void display() {
    image(platformImage, x, y, w, h); // Draw the platform image at its position
  }
}
