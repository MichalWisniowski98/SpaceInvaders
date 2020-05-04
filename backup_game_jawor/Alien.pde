class Alien{

    int osx,osy;
    int aliennumer;
   
    public Alien(int a, int b){
      osx=a;
      osy=b;
    }
    
    //ustawienie który typ przeciwnika
    public void setAlien(int numer){
      aliennumer=numer;
    }
    
   
    
    //stworzenie przeciwnika
    public void rysuj(int x,int y, int level){
      x=osx;
      y=osy;
      image(przeciwnik[level],x,y,40,40);
    }
    
    void strzal(int x, int y){
      image(strzal,x,y,10,20);
    }
    
    
    public int getosx(){
      return osx;
    }
    
    public int getosy(){
      return osy;
    }

}