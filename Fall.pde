class Fall {

  float x;
  float y;
  float speed;
  float gravity;
  float w;
  float life = 255;
  PImage inFinger;
  float r, g, b;

  Fall(float tempX, float tempY, float tempW ) {
    x = tempX;
    y = tempY;
    w = tempW;
    speed = 0;
    gravity = 0.1;
    inFinger = fall;

    r = random(0, 255);
    g = random(0, 255);
    b = random(0, 255);
  }

  void move() 
  {
    // Add gravity to speed
    speed = speed + gravity;
    // Add speed to y location
    y = y + speed;
    // If square reaches the bottom
  }

  boolean finished() {
    // Falls fade out
    life--;
    if (life < 0) {
      return true;
    } else {
      return false;
    }
  }

  void display() {
    // Display the circle
    fill(0, life);
    //stroke(0,life);
    //tint(r,g,b);
    image(inFinger, x, y);
    //inFinger.resize(100, 100);
    //ellipse(x,y,w,w);
  }
}  