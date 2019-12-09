class Fly_AM {
  PVector pos;
  float rad;
  float angle;
  Wings_AM wings;

  Fly_AM(float x, float y) {
    pos = new PVector(x, y);
    angle = 0;
    wings = new Wings_AM(this);
  }

  Fly_AM(float x, float y, float rad) {
    this(x, y);
    this.rad = rad;
  }

  Fly_AM() {
    this(random(width), random(height), 20);
  }

  Fly_AM setX(float x) {
    pos.x = x;
    return this;
  }

  Fly_AM setY(float y) {
    pos.y = y;
    return this;
  }

  Fly_AM setPos(float x, float y) {
    setX(x);
    setY(y);
    return this;
  }

  Fly_AM setRad(float rad) {
    this.rad = rad;
    return this;
  }

  Fly_AM move(float desiredX, float desiredY) {
    setX(desiredX);

    if (desiredY > pos.y) {
      setY(pos.y + desiredY / pos.y);
    } else {
      setY(pos.y - desiredY / pos.y);
    }

    return this;
  }

  void draw() {
    translate(pos.x, pos.y);
    rotate(angle);
    noStroke();
    fill(41);
    ellipse(0, 0, rad, rad);

    wings.move().draw();
  }
}

class Wings_AM {
  Fly_AM fly;

  Wings_AM(Fly_AM fly) {
    this.fly = fly;
  }

  Wings_AM move() {
    return this;
  }

  void draw() {
    noStroke();
    fill(360, 80);
    ellipse(
      fly.rad / 3, 
      fly.rad / 3, 
      fly.rad / 2, 
      fly.rad / 2
      );
  }
}
