class AlbertF extends Animacio {
  color b1, b2, c1, c2;
  float kickSize;
  int radius, radius2, r2, cg;
  float gir;
  float [] x_star = new float[1500];
  float [] y_star = new float[1500];
  int x=10;
  int y=10;
  float num = 0;
  int n=50;
  float[] x_random, y_random;
  float[] vx_random, vy_random;
  float maxDist_random;

  MoverAF m;
  AttractorAF a;

  PImage img;

  AlbertF(String songName) {
    super(songName);
    init();
    song.play();
  }

  void init() {
    img = loadImage("logo_og.png");
    img.resize(width, height);

    background(200);
    noStroke();
    colorMode(HSB, 360, 100, 100);
    ellipseMode(CENTER);
    kickSize = 32;

    for (int i=0; i<1500; i++) {
      x_star[i]=random(-width, width);
      y_star[i]=random(-height, height);
    }
    x_random = new float[n];
    y_random = new float[n];
    vx_random = new float[n];
    vy_random = new float[n];
    maxDist_random=290;
    for (int w=0; w<n; w++) {

      x_random[w] = random(width);
      y_random[w] = random(height);


      float a=random(TWO_PI);
      float r=random(0.2, 1.2);


      vx_random[w] = random(-2, 2);
      vy_random[w] = random(-2, 2);
    }

    m = new MoverAF(); 
    a = new AttractorAF();
  }

  void run() {
  }

  void display() {
    fons_degradat();
    random_walker();
    cercles();
    graella();
    sol_principi();
    estrelles();
    atraccio();
    logo();
  }

  void logo() {
    tint(255, slider[8]*2);
    image(img, 0, 0);
  }


  void atraccio() {
    PVector force = a.attract(m);
    m.applyForce(force);
    m.update();
    a.display();
    m.display();
  }

  void random_walker() {
    for (int e=0; e<n; e++) {
      for (int k=e+1; k<n; k++) {
        noStroke();
        float h2 = knob[5]+20;
        fill(h2+15, 90, 80, knob[2]);
        // fill(0, 0, 100, knob[2]);
        ellipse(x_random[k], y_random[k], 20, 20);
        //line(x[i],y[i],x[k],y[k]);       
        float d=dist(x_random[e], y_random[e], x_random[k], y_random[k]);
        if (d<maxDist_random) {
          float h=map(d, 0, maxDist_random, 0, 360);
          stroke(h, 0, 100, knob[2]/3);
          strokeWeight(1); 
          line(x_random[e], y_random[e], x_random[k], y_random[k]);
        }
      }
    }
    for (int i=0; i<n; i++) {
      vx_random[i] += (knob[3]/500.0);
      vy_random[i] += (knob[3]/500.0);
      x_random[i]=x_random[i]+vx_random[i];
      y_random[i]=y_random[i]+vy_random[i];
      if (x_random[i]>=width||x_random[i]<=0) {
        vx_random[i] = -vx_random[i];
      }
      if (y_random[i]>=height || y_random[i]<=0) {
        vy_random[i] = -vy_random[i];
      }
    }
  }



  void graella() {
    noStroke();
    radius2=(slider[3]);
    float h = knob[5]+20;
    for (int r_2 = radius2; r_2 > 0; --r_2) {
      noStroke();
      fill(h, 90, 80);
      // ellipse(width/2, height/2, r+kickSize, r+kickSize);
      ellipse(width/6, height/6, (50+kickSize)+r_2, (50+kickSize)+r_2);
      ellipse(width/2, height/6, (50+kickSize)+r_2, (50+kickSize)+r_2);
      ellipse((width/6)*5, height/6, (50+kickSize)+r_2, (50+kickSize)+r_2);
      ellipse(width/6, height/2, (50+kickSize)+r_2, (50+kickSize)+r_2);
      ellipse((width/6)*5, height/2, (50+kickSize)+r_2, (50+kickSize)+r_2);
      ellipse(width/6, (height/6)*5, (50+kickSize)+r_2, (50+kickSize)+r_2);
      ellipse(width/2, (height/6)*5, (50+kickSize)+r_2, (50+kickSize)+r_2);
      ellipse((width/6)*5, (height/6)*5, (50+kickSize)+r_2, (50+kickSize)+r_2);
      h = (h + 0.1) %360;
    }
  }

  void fons_degradat() {
    c1 = color(knob[1], 80, 60);
    c2 = color(knob[1]+30, 80, 60);
    for (int i = 0; i <= height; i++) {
      float inter = map(i, 0, height, 0, 1);
      color c = lerpColor(c1, c2, inter);
      stroke(c);
      line(0, i, width, i);
    }
  }



  void sol_principi() {
    beat.detect(song.mix);
    kickSize = constrain(kickSize * 0.95, 16, 100);
    if ( beat.isHat() ) kickSize = 100;
    radius=(slider[1])*4;
    float h = knob[5]+20;
    for (int r = radius; r > 0; --r) {
      noStroke();
      fill(h, 90, 80);
      ellipse(width/2, height/2, r+kickSize, r+kickSize);
      h = (h + 0.1) %360;
    }
  }

  void cercles() {
    if (buttonS[2]==true) {
      r2=((slider[2])*4);
      for (int i=0; i<360; i+=15) {
        float angle = radians(i)+(kickSize/400.0); 
        noStroke();
        float h = knob[5]+20;
        fill(h, 90, 80);
        ellipse(width/2+r2*cos(angle), height/2+r2*sin(angle), 70, 70);
        fill(h+10, 90, 80);
        ellipse(width/2+r2*cos(angle), height/2+r2*sin(angle), 25, 25);
        ellipse(width/2+r2*cos(angle)-25, height/2+r2*sin(angle)-10, 11, 11);
        ellipse(width/2+r2*cos(angle)+20, height/2+r2*sin(angle)-20, 11, 11);
        ellipse(width/2+r2*cos(angle)+15, height/2+r2*sin(angle)+20, 11, 11);
      }
    }
  }

  void estrelles() {
    pushMatrix();
    translate(width/2, height/2);
    gir+=knob[4]/100.0;
    rotate(radians(gir));
    for (int i=0; i<1500; i++) {
      fill(0, 0, 100, 60);
      noStroke();
      ellipse(x_star[i], y_star[i], 3, 3);
    }
    popMatrix();
  }




  void f_keyPressed() {
  }

  void f_keyReleased() {
  }

  void f_mousePressed() {
  }

  void f_mouseDragged() {
  }

  void f_mouseReleased() {
  }
}
