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

  int num = 3;
  int[] posX ;
  int[] posY;
  int r = 5;
  int[] trans;
  boolean[] op;
  
  Clicks_MV(){
    posX = new int[num];
    posY = new int[num];
    
    posX[0] = width/2 - 150; 
    posY[0] = height/2 - 50; 
    
    posX[1] = width/2; 
    posY[1] = height/2 - 150; 
    
    posX[2] = width/2 + 150; 
    posY[2] = height/2 - 50; 
  }
  
  void display(int sel, int count){
    
    noFill();
    
    stroke(255,150-count);
    ellipse(posX[sel],posY[sel], r+count,r+count);
    
    stroke(255,100-count);
    ellipse(posX[sel],posY[sel], 10+r+count, 10+r+count);
    
    stroke(255, 50-count);
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
    /*
    println(">> Diana creada");
    println(" - x: " + x + ", y: " + y);
    println(" - diam: " + diam);
    println(" - cercles: " + nCercles);*/
  }

  void init() {
    diamAux = diam;
    int i;
    for (i=0; i<nCercles; i++) {
      cercles[i] = new Cercle_MV(diamAux, color(0, 100+(i*30), 100 + (i*20)));

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
  float llargada;
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
    if(llargada < 25){
      llargada += 0.1;
    }
  
    angle = sin(inc)/20.0 ;
    
    translate(width/2,height/2); 
    
    for (int i = 0; i < linies; i++) { 
      linia((int)llargada, angle); 
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
      
      line(20,0,20,100);
      
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
  
  
  void display(){
    for (int i = 0; i< numStars; i++){
        
      if(op[i]){
          trans[i] = trans[i] + (int)random(0,3);
          if(trans[i] > 240){
            op[i] = false;
          }
        }else{
          trans[i] = trans[i] - (int)random(0,3);
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
