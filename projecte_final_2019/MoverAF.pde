class MoverAF {
  PVector position;
  PVector velocity;
  PVector acceleration;
  float mass;
  int radius;

  MoverAF() {
    position = new PVector(400, 50);
    velocity = new PVector(1, 0);
    acceleration = new PVector(0, 0);
    mass = 1;
  }

  void applyForce(PVector force) {
    PVector f = PVector.div(force, mass);
    acceleration.add(f);
  }

  void update() {
    velocity.add(acceleration);
    position.add(velocity);
    acceleration.mult(0);
  }
  void display() {
    noStroke();
    float h = knob[5]+50;
    fill(h, 90, 80, knob[6]);
    ellipse(position.x, position.y, 50, 50);
  }

  void checkEdges() {

    if (position.x > width) {
      position.x = 0;
    } else if (position.x < 0) {
      position.x = width;
    }

    if (position.y > height) {
      velocity.y *= -1;
      position.y = height;
    }
  }
}
