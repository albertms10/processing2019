class AttractorAF {
  float mass;    // Mass, tied to size
  float G;       // Gravitational Constant
  PVector position;   // position
  int radius;

  AttractorAF() {
    position = new PVector(width/2, height/2);
    mass = 100;
    G = 10;
    radius=(slider[1])*4;
  }

  PVector attract(MoverAF m) {
    PVector force = PVector.sub(position, m.position);   // Calculate direction of force
    float d = force.mag();                              // Distance between objects
    d = constrain(d, 5.0, 25.0);                          // Limiting the distance to eliminate "extreme" results for very close or very far objects
    force.normalize();                                  // Normalize vector (distance doesn't matter here, we just want this vector for direction)
    float strength = (G * mass * m.mass) / (d * d);     // Calculate gravitional force magnitude
    force.mult(strength);     // Get force vector --> magnitude * direction
    return force;
  }

  // Method to display
  void display() {
    mass = (slider[4]/10)+10;
    ellipseMode(CENTER);
    strokeWeight(4);
    stroke(0);
    fill(175, 200);


    float h = knob[5]+20;
    for (int r = radius; r > 0; --r) {
      noStroke();
      fill(h, 90, 80);
      ellipse(position.x, position.y, mass*10, mass*10);
      h = (h + 0.1) %360;
    }
  }
}
