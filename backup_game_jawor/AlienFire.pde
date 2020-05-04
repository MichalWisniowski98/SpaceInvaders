class AlienFire{
    int x,y;
    
    
    AlienFire(int a, int b){
      x=a;
      y=b;
    }

    void sety(int c){
      y=c;
    }
    
    int gety(){
      return y;
    }
    
    int getx(){
      return x;
    }
    
    //strzelanie przeciwnika
    void strzal_aliena(int x, int y){
      image(strzal_aliena,x,y,10,20);
  }

}