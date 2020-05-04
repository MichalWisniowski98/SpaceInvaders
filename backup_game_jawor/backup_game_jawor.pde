int x,y,los,los2,poziom_losowania,czas_muzyki1, czas_muzyki2, kek;
PImage[] przeciwnik;
PImage strzal,strzal_aliena,kosmita,eksplozja,wygrana;
ArrayList noweAlieny1, noweFajery, alienFajery;
boolean nextlevel,muzyka1,muzyka2;

import processing.sound.*;

SoundFile wybuch1, gameover1, next_level1, win1, main_theme1, game_theme1;

Explosion nowyExplosion;
Alien nowyAlien;
Zmienne_globalne nowezmienne_globalne; 


enum Stan {MENU, GRA, INFO, LEVEL, PAUSE, KONIEC}
Stan mojStan;

void setup(){
  size(614,335);
  frameRate(30);
  y=250;
  x=300;
  kek=0;
  poziom_losowania=2;
  czas_muzyki1=1;
  czas_muzyki2=1;
  nextlevel=true;
  muzyka1=true;
  muzyka2=true;
  
  
  //typy przeciwników
  przeciwnik=new PImage[4];
  
  for(int i=0; i<4; i++){
     kosmita= loadImage("alien"+i+".png");
     przeciwnik[i]=kosmita;
  }
  
  
  noweAlieny1=new ArrayList<Alien>();
  noweFajery=new ArrayList<Fire>();
  alienFajery=new ArrayList<Fire>();
        
  tworzenieAlienow();

    
  strzal=loadImage("fire1.png");
  strzal_aliena=loadImage("fire2.png");
  eksplozja=loadImage("explosion.png");
  wygrana=loadImage("wygrana.png");
  nowyExplosion = new Explosion();
  
    wybuch1 = new SoundFile(this, "Explosion.mp3");
    gameover1 = new SoundFile(this, "gameover.mp3");
    next_level1 = new SoundFile(this, "next_level1.mp3");
    win1 = new SoundFile(this, "win.mp3");
    main_theme1 = new SoundFile(this, "main_theme.mp3");
    game_theme1 = new SoundFile(this, "game_theme.mp3");
    mojStan=Stan.MENU;
  
}
  

void draw(){
  if(mojStan==Stan.MENU){
    if(millis()>=42500*czas_muzyki1){
      muzyka1=true;
      czas_muzyki1++;
    }
    if(muzyka1) main_theme1.play();
    muzyka1=false;
    
    background(loadImage("menu.png"));
    x=300;
    
  }
  if(mojStan==Stan.GRA)
  {
  background(loadImage("background.png"));
  imageMode(CENTER);
  image(loadImage("spaceship.jpg"),x,300,50,48);
  
  main_theme1.dispose();
  
  
  if(millis()-kek>=150000*czas_muzyki2){
     muzyka2=true;
     czas_muzyki2++;
  }
  if(muzyka2) game_theme1.play();
  muzyka2=false;
    
  
  if(keyPressed){
    if(key=='p' || key=='P') mojStan=Stan.PAUSE;
  }
  
  //rozpoczęcie nowego poziomu - animacja, wczytanie nowych przeciwników
  if(noweAlieny1.size()<=0 && Zmienne_globalne.getlevel()<4){
    if(nextlevel){
        next_level1.play();
        nextlevel=false;
    }
    if(x>300){
      String napis="lvl"+Zmienne_globalne.getlevel()+".png";
      image(loadImage(napis),307,164,143,39);
      println("WHOA NEXT LEVEL HUH? SWEET!");
      x=x-5;
    }
    if(x<300){
      String napis="lvl"+Zmienne_globalne.getlevel()+".png";
      image(loadImage(napis),307,164,143,39);
      println("WHOA NEXT LEVEL HUH? SWEET!");
      x=x+5;
    }
    if(x==300){
      delay(2000);
      println("Lets do this!");
      noweAlieny1.removeAll(noweAlieny1);
      Zmienne_globalne.setlevel();
      tworzenieAlienow();
      nextlevel=true;
    }
  }
  
  //koniec gry
  if(noweAlieny1.size()<=0 && Zmienne_globalne.getlevel()>=4){
    image(wygrana,307,167);
    game_theme1.dispose();
    if(nextlevel){
        win1.play();;
        nextlevel=false;
    }
    println("HEY THATS PRETTY GOOD");
        if(x>300){
           x=x-5;
        }
        if(x<300){
           x=x+5;
        }
        if(x==300){
          delay(2000);
          czysc();
        }
  }
  
 
  //tworzenie przeciwników
  for(int i=0;i<noweAlieny1.size();i++){
    Alien nowyAlien = (Alien)noweAlieny1.get(i);
    nowyAlien.rysuj(nowyAlien.osx,nowyAlien.osy,Zmienne_globalne.getlevel()-1);
  }
  
  //sprawdzanie czy przeciwnik został trafiony i jeżeli tak to usunięcie go z arraylisty
  los2=(int)random(0,11);
  for(int j=0;j<noweFajery.size();j++){
  
    Fire nowyFire=(Fire)noweFajery.get(j);
    int y=nowyFire.gety();
    nowyFire.strzal(nowyFire.xstrzalu,y);
    for(int i=0;i<noweAlieny1.size();i++){
        Alien nowyAlien=(Alien)noweAlieny1.get(i);
        if(nowyFire.xstrzalu>=(nowyAlien.getosx()-20) && nowyFire.xstrzalu
            <=(nowyAlien.getosx()+10) && y<=nowyAlien.getosy()){
          noweAlieny1.remove(i);
          wybuch1.play();
          nowyExplosion.bum(nowyAlien.getosx(),y);
          if(los2==1){
            println("WOW");
          }
          if(los2==4){
            println("AMAIZING");
          }
          if(los2==6){
            println("ASTONISHING");
          }
          if(los2==8){
            println("NICE");
          }
          if(los2==10){
            println("INCREDIBLE");
          }
          
          if(j>=0){
            noweFajery.remove(j);
            j--;
          }
         }
     }
     nowyFire.sety(y-10);
          
  
     if(y<=-200){
       noweFajery.remove(j);
       j--;
     }
  }
  
  los=(int)random(0,200*poziom_losowania);
  
  //strzelanie pzeciwników, jeżeli przecwnik trafi rozpoczęcie gry od nowa
  if(los<noweAlieny1.size()){
    Alien nowy=(Alien)noweAlieny1.get(los);
    int x= nowy.getosx();
    int y=nowy.getosy();
    AlienFire alienFire=new AlienFire(x,y);
    alienFajery.add(alienFire);
  }
  
  for(int j=0;j<alienFajery.size();j++){
  
    AlienFire alienFire=(AlienFire)alienFajery.get(j);
    int y=alienFire.gety();
    alienFire.strzal_aliena(alienFire.getx(),y);
    
    if(alienFire.getx()>=x-25 && alienFire.getx()<=x+25 && alienFire.gety()>280){
          game_theme1.dispose();
          gameover1.play();
          nowyExplosion.bum(x,y);
          println("Well it happens");
          println("Lets try it again");
          mojStan=Stan.KONIEC;
          break;
    }
            
        
    alienFire.sety(y+5);
          
  
    if(y>=330){
      alienFajery.remove(j);
      j--;
    }
  }
  
  }
  
    if(mojStan==Stan.PAUSE){
      textSize(32);
      text("PRESS R TO RESUME GAME", 100,150,450,450);
      if(keyPressed){
        if(key=='r' || key=='R') mojStan=Stan.GRA;
      }
    }
    
    if(mojStan==Stan.INFO){
      background(loadImage("info.png"));
    }
    
    if(mojStan==Stan.LEVEL){
      background(loadImage("difficulty.png"));
      if(keyPressed){
        if(key=='1'){
          poziom_losowania=4;
          mojStan=Stan.GRA;
        }
        if(key=='2'){
          poziom_losowania=2;
          mojStan=Stan.GRA;
        }
        if(key=='3'){
          poziom_losowania=1;
          mojStan=Stan.GRA;
        }
      }
    }
        
    
    if(mojStan==Stan.KONIEC){
      background(loadImage("gameover2.png"));
      if(keyPressed){
        if(key=='e' || key=='E'){
           czysc();
        }
      }
    }
    
  
}
 

//stworzenie przeciwników i dodanie ich do arraylisty
void tworzenieAlienow(){
  
    
   
    for(int i=1; i<4; i++){
      for(int il=0; il<10; il++){
       
       nowyAlien=new Alien(40+(il*60),(i*40));
       nowyAlien.setAlien(Zmienne_globalne.getlevel());
       noweAlieny1.add(nowyAlien);
       
       }
    
       
    }

}

//czyszczenie całej gry i rozpoczęcie od nowa
void czysc(){
    alienFajery.removeAll(alienFajery);
    noweFajery.removeAll(noweFajery);
    noweAlieny1.removeAll(noweAlieny1);
    Zmienne_globalne.zerujlevel();
    setup();
  
}
    
//reakcja klawiszy - "a" poruszenie statkiem w lewo, "d" w prawo, spacja " " wystrzelenie pocisku
void keyPressed(){

    if(keyCode==32) 
    {
       Fire nowyFire =new Fire();
       nowyFire.setx(x);
       noweFajery.add(nowyFire);
    }
    if(keyCode==65)  x=x-10; 
    if(keyCode==68)  x=x+10;
    if(keyCode==81){
      if(mojStan!=Stan.KONIEC){
        kek=millis();
        mojStan=Stan.GRA;
      }
    }
    if(keyCode==73){
      if(mojStan==Stan.MENU){
        mojStan=Stan.INFO;
      }
    }
    if(keyCode==76){
      if(mojStan==Stan.MENU){
        mojStan=Stan.LEVEL;
      }
    }
}
  