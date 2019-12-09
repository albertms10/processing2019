class Maria extends Animacio{
  
  // Beat
  Diana_MV kick;
  float d, dMax, c;
  float kickD, kickDMax, kickC;
  
  // Palmeres
  Palm_MV palm;
  
  // Stars
  Stars_MV stars;
  
  // Clicks
  Clicks_MV click;
  int[] sel;
  int[] count;
  
  

  Maria(String nameSong) {
    super(nameSong);
    init();
    song.play();
  }

  /**
   * Mètode equivalent al setup()
   */
  void init() {
      
    palm = new Palm_MV();
    
    stars =  new Stars_MV(120);
    
    click =  new Clicks_MV();
    sel = new int[3];
    count = new int[3];
    for(int i=0; i <3; i++){
      sel[i] = count[i] = -1;
    }
   
    initCercles();
    
  }
  
  void initCercles() {
    kickDMax = 0.2*height;
    kick  = new Diana_MV( 0, 3);
  }
  
  void checkKick() {
  
    if ( beat.isKick() ) {
      kickC = 5;
    } else {
      kickC = 0.95;
    }
  
    kickD *= kickC;
  
    if(kickD > kickDMax){
      kickD = kickDMax;
    }else if (kickD < 0.1*kickDMax){
      kickD = 0.1*kickDMax;
    }
  
    kick.display(kickD);
  }
  /**
   * Mètode per a càlculs, si cal
   */
  void run() {}

  /**
   * Mètode equivalent al draw()
   */
  void display() {
    
    background(0);
       
    palm.display();
    
    stars.display();
    
    for(int i=0; i<3;i++){
      if(sel[i] != -1 && count[i] != -1){
         if(count[i] < 100){
          click.display(sel[i],count[i]);
          count[i]++;
         }else{
           sel[i]=count[i]= -1;
         }
      }
    }
    
    beat.detect(song.mix);
    
    checkKick();
  
  
  }
  
  /**
   * Aquestes funcions (potser no calen totes)
   * les haurem de programar com si fossin les funcions de teclat i ratolí.
   * Les cridem des del programa principal quan la nostra animació està activa.
   */
  void f_keyPressed() {
     if (key == 'q') {
        sel[0] = count[0] = 0;
      } 
      if (key == 'w') {
        sel[1] = 1;
        count[1] = 0;
        
      }
      if (key == 'e') {
        sel[2] = 2;
        count[2] = 0;
        
      }
  }
  
  void f_keyReleased() {}

  void f_mousePressed() {}

  void f_mouseDrgged() {}

  void f_mouseReleased() {}


}
