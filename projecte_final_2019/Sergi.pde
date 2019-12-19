class Sergi extends Animacio {
  float radi1, radi2, roda1, roda2, roda3, roda4, i, slider3,slider4;
  int x;
  int y;
  float outsideRadius=1;
  float insideRadius=1;
  float   kickSize;

  float A = 1.419, B = -2.284, C = 2.427, D = -2.177;

  float dejongX(float x, float y) {
    return sin(A * y) - cos(B * x);
  }
  float dejongY(float x, float y) {
    return sin(C * x) - cos(D * y);
  }


 PImage img1, img2, img3;

  Sergi(String songName) {
    super(songName);
    init();
    song.play();
  }

  /**
   * Mètode equivalent al setup()
   */
  void init() {
    
    img1 = loadImage("Gucci.png");
    img1.resize(width/5, height/5);
    img2 = loadImage("Fendi.png");
    img2.resize(width/5, height/5);
    img3 = loadImage("Prada.png");
    img3.resize(width/5, height/5);
    
    ellipseMode(RADIUS);
    radi1 = slider[1];
    radi2 = slider[2];
    roda1 = knob[1]*5;
    roda2 = knob[2]*5;
    roda3 = knob[3]*7;
    slider3 = slider[3]*8;
    x = width/2;
    y = height/2;
        background(150, 180, roda3);
  }

  /**
   * Mètode per a càlculs, si cal
   */
  void run() {
  }

  /**
   * Mètode equivalent al draw()
   */
  void display() {
    beat.detect(song.mix);
    i=1;
    kickSize = constrain(kickSize*0.95, 20, 150);
    if ( beat.isHat() ) kickSize = 190;

    radi1 = slider[1]+(kickSize/4);
    radi2 = slider[2];
    roda1 = knob[1]*3;
    roda2 = knob[2]*5;
    roda3 = knob[3]*7;
    roda4= knob[4];
    slider3 = slider[3]*8;
    slider4= slider[4]*7;
    
    
    roda4 = constrain(roda4, -10, 15);
    slider4 = constrain(slider4, -10, 15);
    
    background(roda2,150,220);
    
    int numPoints = int(map(roda1, 0, width, 6, 60));
    float angle=0;
    float angleStep = 180.0/numPoints;

    fill(HSB, 255, 255, 255);
    ellipse(width/2, height/2, radi1*2, radi1*2);
    if (buttonS[4]==false) {
      roda4=12;}
      
    else{
      roda4= knob[4];
    }
      
    if (buttonS[5]==false) {
      slider4=70;}
      
    else{
      slider4= slider[4]*7;
    }
    println(slider4);
    beginShape(TRIANGLE_STRIP); 

    for (int i = 0; i <= numPoints; i++) {

      float px = x + cos(radians(angle)) * outsideRadius*radi1*2;
      float py = y + sin(radians(angle)) * outsideRadius*radi1*2;

      angle += angleStep;
      vertex(px, py);
      px = x + cos(radians(angle)) * insideRadius*radi1-20;
      py = y + sin(radians(angle)) * insideRadius*radi1-20;
      vertex(px*(slider4/70), py*(roda4/12)); 
      angle += angleStep;
    }

    endShape();

    if (mousePressed) {
   
    } else {
    stroke(0);
    }
      



    float z = random(-PI, PI);
    float l = random(-PI, PI);

    for (int i = 0; i < 1000; i++) {
      float xx = dejongX(z, l);
      float yy = dejongY(z, l);
      float sx = xx * width *0.24;
      float sy = yy * height *0.24;
      stroke(0, 80);
      point(sx, sy);
      z = xx;
      l = yy;

      if (frameCount%1==0) {
        fill(HSB, 120, 100, 160);
        ellipse(random(width), random(height), song.left.get(i)+(radi2/5), song.right.get(i)*20);
      }
      
    }
    if(frameCount>=1500 && frameCount<2300){
    if (frameCount%10==0) {
    
        image(img1, random(0, width),random(0,height));
        
    }
    if (frameCount%20==0) {
    
        image(img2, random(0, width),random(0,height));
        
    }
    if (frameCount%30==0) {
    
        image(img3, random(0, width),random(0,height));
        
    }
    
    } 
  }

  /**
   * Aquestes funcions (potser no calen totes)
   * les haurem de programar com si fossin les funcions de teclat i ratolí.
   * Les cridem des del programa principal quan la nostra animació està activa.
   */


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
