static class Zmienne_globalne{
    static int level=1;
    
    //ustawienie poziomu
    public static void setlevel(){
      level++;
    }
    
    //wyzerowanie poziomu - rozpoczęcie od nowa
    public static void zerujlevel(){
      level=1;
    }
    
    public static int getlevel(){
      return level;
    }


}