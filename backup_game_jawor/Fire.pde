class Fire{
  int xstrzalu;
  int ystrzalu=280;
  
  
  void sety(int y){
    ystrzalu=y;
  }
  
  int gety(){
    return ystrzalu;
  }
 
  void setx(int nowyx){
    xstrzalu=nowyx;
  }
  
  //pocisk statku
  void strzal(int x, int y){
    image(strzal,x,y,10,20);
  }
  
}