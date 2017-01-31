//Se crean las variables para la bola
float bolaposx=width/2;
float bolaposy=height/5;
float vx= random(3,6 );
float vy= random(5, 10);
float radiobola=20;
float Inc=1.005;
//Se crean las variables para la pala
float palaposx;
float palaposy=520;
int anchopala=80;
int altopala=10;
float Xpala;
float palaX;
//Variable para la imagen de fondo
PImage img;
//Variables generales
int nivel=0;
int puntuacion=0;
int vidas=3;
int hbarrav=570;
//Llamada a bloques
Bloque[] miBloque1 = new Bloque[5];
Bloque[] miBloque2 = new Bloque[5];
Bloque[] miBloque3 = new Bloque[5];

void setup() {
  size(600, 600);
  img=loadImage("fondo.jpg");
  frameRate(50);
}

void draw() {
  image(img, 0, 0);
  cambiodenivel(); //Función para cambiar de nivel
}

//Funcion para la pulsación de botones
void mousePressed() {
  botones(); 
}

//Movimuento de la bola
void bola() {
  ellipse(bolaposx, bolaposy, radiobola, radiobola);
  bolaposx=vx+bolaposx;
  bolaposy=vy+bolaposy;
}

//Rebotes de la bola
void rebotes() {
  if (bolaposx>width-radiobola*1.5) vx=vx*-Inc;
  if (bolaposx<radiobola/2) vx=vx*-Inc;
  if (bolaposy<radiobola) vy=vy*-Inc;
  Xpala=palaposx-anchopala/2;
  palaX=palaposx+anchopala/2;
  if ((bolaposy>palaposy) && (bolaposx>(Xpala)) && (bolaposx<(palaX))) {
    vy=vy*-Inc;
  }
}
//Movimiento de la pala
void pala() {
  rectMode(CENTER);
  palaposx=mouseX;
  rect(palaposx, palaposy, anchopala, altopala);
}


void cambiodenivel() {
  switch (nivel) {
  case 0:
    Start();
    break;
  case 1:
    Jugar();
    break;
  case 2:
    Perder();
    break;
  case 3:
    Ganar();
    break;
  }
}

//Pantalla de inicio del juego 
void Start() {
  fill(37, 132, 255);
  rect(150, 150, width/2, 150);
  textSize(48);
  textAlign(CENTER);
  text("ARKANOID", width/2, 100);
  textSize(48);
  fill(128, 0, 255);
  text("PLAY", width/2, 235);
}
//Pantalla de juego
void Jugar() {
  bola();
  rebotes();
  pala();
  Bloques();
  text("Vidas:"+vidas, 100, 100);
  rect(300, hbarrav, 600, 10);
  if (bolaposy>580 && vidas==0) nivel=2;
  if (vidas==0) hbarrav=-20;
  if (puntuacion==15) nivel=3;
  if (bolaposy>540 && vidas!=0) {
    vidas=vidas-1;
    vy=vy*-Inc;
  }
}
//Botones para moverse entre niveles
void botones() {
  if ((150<mouseX & mouseX<450) && (150<mouseY & 300>mouseY) && (nivel==0)) {
    nivel=1;
    creacionBloque();
  }

  if ((100<mouseX & mouseX<275) && (200<mouseY & 300>mouseY) && (nivel==2 ||nivel==3)) {
    nivel=1;
    creacionBloque();
    puntuacion=0;
    vidas=3;
    hbarrav=560;
  }
  if ((325<mouseX & mouseX<500) && (200<mouseY & 300>mouseY) && (nivel==2|| nivel==3)) exit();
}

//Creación de la clase Bloque
class Bloque {

  //Variables de los bloques
  int Posx;
  int Posy;
  int estado;
  int anchoBloque;
  int altoBloque;
  float r;
  float g;
  float b;
  //Constructor de los bloques
  Bloque (int xPosTemp, int yPosTemp, int estadoTemp) { 
    Posx=xPosTemp;
    Posy=yPosTemp;
    estado=estadoTemp;
    anchoBloque=40;
    altoBloque=20;
  }
//Mostrar los bloques
  void display() {
    if (estado==1) {
      rectMode(CENTER);
      fill(128, 0, 255);
      rect(Posx, Posy, anchoBloque, altoBloque);
    }
  }
//Hacer desaparecer los bloques
  void borrarBloque() {
    if (bolaposx < Posx+anchoBloque/2+radiobola && bolaposx > Posx-anchoBloque/2-radiobola && bolaposy > Posy-altoBloque/2-radiobola && bolaposy < Posy +altoBloque/2+radiobola && estado==1) {
      estado=0;
      vy=vy*-Inc;
      puntuacion=puntuacion+1;
    }
  }
}
//Llamada a las funciones de los bloques
void Bloques() {
  for (int i=0; i< 5; i ++) {
    miBloque1[i].display();
    miBloque1[i].borrarBloque();
  }
  for (int h=0; h< 5; h ++) {
    miBloque2[h].display();
    miBloque2[h].borrarBloque();
  }
  for (int m=0; m< 5; m ++) {
    miBloque3[m].display();
    miBloque3[m].borrarBloque();
  }
}
//Para crear los bloques
void creacionBloque() {
  for (int i=0; i< miBloque1.length; i++) {
    miBloque1[i]= new Bloque(i*width/5+width/(2*5), height/7, 1);
  }
  for (int h=0; h< miBloque2.length; h++) {
    miBloque2[h]= new Bloque(h*width/5+width/(2*5), 2*height/7, 1);
  }
  for (int m=miBloque3.length/8; m< miBloque3.length; m++) {
    miBloque3[m]= new Bloque(m*width/5+width/(2*5), 3*height/7, 1);
  }
}
//Pantalla después de perder
void Perder() {
  bolaposy=50;
  image(img, 0, 0);
  fill(128, 0, 255);
  textAlign(CENTER);
  text("Perdiste ¿Reintentar?", width/2, 100);  
  text("Puntuación:", width/2, height/1.3);
  text(puntuacion, width/2, height/1.15);
  rectMode(CORNER);
  rect(325, 200, 175, 100);
  rect(100, 200, 175, 100);
  fill(255);
  text("Si", 100+(175/2), 200+(100/1.5));
  text("No", 325+(175/2), 200+(100/1.5));
}
//Pantalla después de ganar
void Ganar() {
  bolaposy=50;
  image(img, 0, 0);
  fill(128, 0, 255);
  textAlign(CENTER);
  text("¡Ganaste!", width/2, 100);  
  text("Puntuación:", width/2, height/1.3);
  text(puntuacion, width/2, height/1.15);
  rectMode(CORNER);
  rect(325, 200, 175, 100);
  rect(100, 200, 175, 100);
  fill(255);
  text("Jugar", 100+(175/2), 200+(100/1.5));
  text("Salir", 325+(175/2), 200+(100/1.5));
}
