class Tomas extends Animacio {

ParticulaT[] partis = new ParticulaT[7];
MollaT[] molles = new MollaT[6];

float angle=0;
float speed=0.02;
boolean active1, active2;
int radi1, radi2;
int colorMolla=255;


  Tomas(String songName) {
    super(songName);
    init();
    song.play();
  }

  void init() {

    active1=false;
    radi1 = radi2 = 0;
   
   background(0); 
  ellipseMode(RADIUS);
  colorMode(HSB);
  
  for (int i = 0; i < partis.length; i++) {
    partis[i] = new ParticulaT(width/2, i*40);
  }
  
  for (int i = 0; i < molles.length; i++) {
    molles[i] = new MollaT(partis[i], partis[i+1], 40);
  }
   
  }

  void run() {
  }

  void display() {

    //BORRAR BACKGROUND
  //background(255); 
  
  if(active1){
    println("ACTIVE 1:"+active1);
    partis[6].dragging=true;
    println("Pista1:"+radi1);
    println("Pista2:"+radi2);
    for (MollaT m : molles) {
    m.setColorMolla(colorMolla);
    m.calculaForcaMolla();
    m.dibuixa();
  }

  for (ParticulaT p : partis) {
    p.mou();
    p.dibuixa();
    p.drag((int)map(radi1, 0, 127, 0, width),(int)map(radi2, 0, 127, 0, height));
  }
    
  }
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
