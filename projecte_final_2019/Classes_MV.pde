class Cercle_MV { 
  float x, y, w, h;
  color c, bg;
  int s;
  
  // constructor amb color de fons
  Cercle_MV( float _d, color _c) {
    x = width/2;
    y = height/2;
    w = _d;
    h = _d;
    c = _c;
    bg = 0;
  }
  
  void display() {    
   
    noStroke();
    fill(c);    
    ellipse(x, y, w, h);
  }
}

class Clicks_MV{

  int num = 7;
  int[] posX ;
  int[] posY;
  color[] c;
  int r = 5;
  int[] trans;
  boolean[] op;
  
  Clicks_MV(){
    posX = new int[num];
    posY = new int[num];
    c = new color[num];
    
    for(int i = 0; i<num; i++){
      c[i] = color(0, random(100,255), random(100,255));
    }
    
     
  }
  
  void display(int sel, int count){
    
    posX[0] = width/2 - 200-slider[1]; 
    posY[0] = height/2 - 100; 
    
    posX[1] = width/2; 
    posY[1] = height/2 - 200-slider[1]; 
    
    posX[2] = width/2 + 200+slider[1]; 
    posY[2] = height/2 - 100; 
    
    posX[3] = width/2 - 200-slider[1]; 
    posY[3] = height/2 + 100; 
    
    posX[4] = width/2; 
    posY[4] = height/2 + 200+slider[1]; 
    
    posX[5] = width/2 + 200+slider[1]; 
    posY[5] = height/2 + 100;
    
    noStroke();
    fill(c[sel],150-count);
    ellipse(posX[sel],posY[sel], r+count,r+count);
    
    fill(c[sel],100-count);
    ellipse(posX[sel],posY[sel], 10+r+count, 10+r+count);
    
    fill(c[sel], 50-count);
    ellipse(posX[sel],posY[sel], 30+r+count, 30+r+count);
    
  }
    
    

}


class Diana_MV {

  Cercle_MV[] cercles;
  float x, y, diam, diamAux;
  int nCercles;

  Diana_MV( float _diam, int _nCercles) {
    x = width/2;
    y = height/2;
    diam = _diam;
    nCercles = _nCercles;
    
    cercles = new Cercle_MV[nCercles];

    init();
  }

  void init() {
    diamAux = diam;
    int i;
    for (i=0; i<nCercles; i++) {
      cercles[i] = new Cercle_MV(diamAux, color(255,100));

      diamAux -= (diamAux/nCercles); 
    }
  }

  void display(float _diam) {
    
    diam = diamAux = _diam;
    int i;
    for (i=0; i<nCercles; i++) {

      cercles[i].w = diamAux;
      cercles[i].h = diamAux;
      diamAux -= (diamAux/nCercles);
      
      cercles[i].display();
    }
  }

}

class Palm_MV {

  float inc;
  int llargada = 0;
  int linies;
  float angle;

  Palm_MV (){
    inc = 0.0;
    llargada = 0;
    linies = 6;
  }
  
  void display(){
    pushMatrix();
    inc += 0.033;
    
    
    if(llargada < 100){
      llargada = knob[1]; // la llargada depen de l'slider
    }
    if(knob[1] < 100){
      llargada = knob[1]; 
    }
    angle = sin(inc)/20.0 ;
    
    translate(width/2,height/2); 
   
    
    for (int i = 0; i < linies; i++) { 
      linia(llargada, angle); 
      rotate(PI*2/linies); 
    }
    popMatrix();
  }
  
  void linia( int units, float angle) {
    pushMatrix();
    translate(0,0);
    
    for (int i =0 ; i < units; i++) {
      
      stroke(0,7*i,5*i);
      strokeWeight(1); 
      
      line(500,0,200,100);
      
      translate(0, 5); 
      rotate(angle);
    }
   
    popMatrix();
  }


}
class Stars_MV{

  int numStars;
  int[] posX ;
  int[] posY;
  int r = 2;
  int[] trans;
  boolean[] op;
  
  Stars_MV(int num){
    numStars = num;
    posX = new int[numStars];
    posY = new int[numStars];
    trans = new int[numStars];
    op = new boolean[numStars];
    
    
    for (int i = 0; i< numStars; i++){
       posX[i] = (int)random(0,width); 
       posY[i] = (int)random(0,height); 
       trans[i] = (int)random(0,200);
       if(trans[i] > 100){
         op[i] = false;
       }else{
         op[i] = true;
       }
       
    }
  }
  
  
  void display(int numStars){
    
    for (int i = 0; i< numStars; i++){
        
      if(op[i]){
          trans[i] = trans[i] + (int)random(0,10);
          if(trans[i] > 240){
            op[i] = false;
          }
        }else{
          trans[i] = trans[i] - (int)random(0,10);
          if(trans[i]< 20){
            op[i] = true;
          }
        }
       
        fill(255,255,255, trans[i]);
        noStroke();
        ellipse(posX[i], posY[i], r, r);
    }
  }

}

class Ball_MV {
  
  color col;
  PVector pos; //vector de posició
  PVector vel; //vector de velocitat
  
  float radi;
  int vida,type;
  

  Ball_MV(int var) {
    col = color(0,random(125,255),random(125,255));
    radi = random(5,25);
    pos = new PVector(random(0,width),random(0, height));
    vel = new PVector(random(-2,2), random(-2,2));
    vida = 250;
    type= var;
    
  }
  
  void run(){
    mou();
    dibuixa();
  }

  void mou() {
    pos.add(vel);
    
    if(pos.x <= radi){
      pos.x = radi;
      vel.x = -vel.x;
    }
    if(pos.x >= width-radi){
      pos.x = width-radi;
      vel.x = -vel.x;
    }
    if(pos.y <= radi){
      pos.y = radi;
      vel.y = -vel.y;
    }
    if(pos.y >= height-radi){
      pos.y = height-radi;
      vel.y = -vel.y;
    }
    vida--;
  }

  void dibuixa() {
    
    if (type == 1){
      ellipseMode(RADIUS);
      stroke(col, vida/2);
      noFill();
      ellipse(pos.x, pos.y, radi,radi);
      
    }else if (type == 2){
      ellipseMode(RADIUS);
      noStroke();
      fill(col, vida/2);
      ellipse(pos.x, pos.y, radi,radi);
      
    }
    
  }
  
  boolean haMort() {
    if (vida <= 0) {
      return true;
    } else {
      return false;
    }
  }
}
