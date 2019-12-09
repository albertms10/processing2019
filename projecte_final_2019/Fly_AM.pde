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
    pushMatrix();

    translate(pos.x, pos.y);
    rotate(angle);

    noStroke();
    fill(41);
    ellipse(0, 0, rad, rad);

    wings.move().draw();

    popMatrix();
  }
}

class Wind {
  int n;
  ArrayList<Wave> wind;

  Wind(int n) {
    wind = new ArrayList<Wave>();

    for (int i = 0; i < n; i++) {
      wind.add(new Wave());
    }
  }
  
  void draw() {
    for (int i = 0; i < map(slider[1], 0, 127, 1, wind.size()); i++) {
      wind.get(i).draw();
    }
  }
}

class Wave {
  int xSpacing = 1;   // How far apart should each horizontal location be spaced
  int w;              // Width of entire wave

  float theta = 0.0;   // Start angle at 0
  float amplitude = 20.0;  // Height of wave
  float period = 1000.0;  // How many pixels before the wave repeats
  float dx;  // Value for incrementing X, a function of period and xspacing
  float[] yValues;  // Using an array to store height values for the wave
  float yOffset;

  Wave() {
    w = width + 16;
    dx = xSpacing * TWO_PI / period;
    yValues = new float[w / xSpacing];
    yOffset = random(height / 2);
  }

  void draw() {
    calcWave();
    renderWave();
  }

  void calcWave() {
    // Increment theta (try different values for 'angular velocity' here
    theta += 0.02;

    // For every x value, calculate a y value with sine function
    float x = theta;
    for (int i = 0; i < yValues.length; i++) {
      yValues[i] = sin(x) * amplitude;
      x += dx;
    }
  }

  void renderWave() {
    noStroke();

    for (int x = 0; x < yValues.length; x++) {
      float xPos = x * xSpacing;
      fill(0, map(xPos, 0, width, 0, 40));
      ellipse(xPos, height / 2 + yValues[x] + yOffset, 1, 1);
    }
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
      -fly.rad / 3, 
      -fly.rad / 3, 
      fly.rad / 2, 
      fly.rad / 2
      );
  }
}
