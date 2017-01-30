//Se declaran las variables


float posx=width/2;
float vx=random(-5,-3);
float posy=height/2;
float vy=9;
float radiobola =20;

float alturapala=510;
float anchopala=80;
float altopala=10;
float xpala =0;
float palax =0;
int nivel=0;
int puntuacion=0;
int vidas=3;
int heightv=580;
int distexto=50;
float hfin=(height-radiobola);
int i=0;
float r;
float g;
float b;



void setup() {
  size(600, 600);
  background(0);
  r=random(50, 255);
  g=random(50, 255);
  b=random(50, 255);
  frameRate(50);
}

void draw() {



  if (vidas==0) heightv=-20;

  switch (nivel) {
  case 0:
    presentacion();
    break;
  case 1:
    nivel1();
    break;
  case 2:
    nivel2();
    break;
  }
  rebotes();
}


void mousePressed() {
  botones();
}
void presentacion() {
  background(0);
  fill(37, 132, 255);
  rect(150, 150, width/2, 150);
  textSize(48);
  textAlign(CENTER);
  text("ARKANOID", width/2, 100);

  textSize(48);
  fill(128, 0, 255);
  text("PLAY", width/2, 235);
}
//NIVEL 1
void nivel1() {

  background(0);
  xpala =(mouseX-(anchopala/2));
  palax =(mouseX+(anchopala/2));
  posy=vy + posy;
  posx=vx + posx;
  fill(r, g, b);
  rectMode(CENTER);
  rect(mouseX, alturapala, anchopala, altopala);
  ellipse(posx, posy, radiobola, radiobola);
  rect(width/2, heightv, width, 5);
  textAlign(RIGHT);
  text("Vidas:", distexto, distexto);
  textAlign(LEFT);
  text(vidas, distexto, distexto);





  for (i=0; i< 5; i++) {
    miBloque[i]= new Bloque(((width/6)*i)+width/6, height/8, 1);
    miBloque[i].display();
    miBloque[i].disa();
  }

  for (int j=0; j< 5; j++) {
    miBloque[j]= new Bloque(((width/6)*j)+width/6, height/5.25, 1);
    miBloque[j].display();
    miBloque[j].disa();
  }

  for (int k=0; k< 5; k++) {
    miBloque[k]= new Bloque(((width/6)*k)+width/6, height/4, 1);
    miBloque[k].display();
    miBloque[k].disa();
  }





  //Rebote en barra con vidas

  if (posy>560 && vidas!=0) {
    vy=vy*-1;
    vidas=vidas-1;
  }

  //Paso a nivel2

  if (posy>585 & vidas==0) {
    nivel=2;
  }
}

//NIVEL 2
void nivel2() {
  posy=50;
  background(0);
  fill(r, g, b);
  textAlign(CENTER);
  text("Perdiste ¿Reintentar?", width/2, 100);  
  text("Puntuación:", width/2, height/1.3);
  text(puntuacion, width/2, height/1.25);


  rectMode(CORNER);
  rect(325, 200, 175, 100);
  rect(100, 200, 175, 100);
  fill(255);
  text("Si", 100+(175/2), 200+(100/1.5));
  text("No", 325+(175/2), 200+(100/1.5));
}

Bloque[] miBloque = new Bloque[5];


class Bloque {
  // DATOS
  float xpos; // posicion x de la pelota
  float ypos; // posicion y de la pelotq
  float state;
  float anchobloque;
  float altobloque;
  float r;
  float g;
  float b;


  // CONSTRUCTOR
  Bloque(float xposTemp, float yposTemp, float stateTemp) {
    xpos=xposTemp;
    ypos=yposTemp;
    state=stateTemp;
    anchobloque= 40;
    altobloque=20;
    r=random(0, 255);
    g=random(0, 255);
    b=random(0, 255);
  }
  void disa() {
    if (posx>xpos-anchobloque/2-radiobola && posx<xpos+anchobloque/2+radiobola && posy>ypos-altobloque/2-radiobola && posy < ypos +altobloque/2+radiobola) {
      state=0;
      vy=vy*(-1);
    }
  }

  void display() {
    rectMode(CENTER);
    if (state==1) {
      rect(xpos, ypos, anchobloque, altobloque);
    }
  }
}
void botones() {
  if ((150<mouseX & mouseX<450) && (150<mouseY & 300>mouseY) && (nivel==0)) nivel=1;
  if ((100<mouseX & mouseX<275) && (200<mouseY & 300>mouseY) && (nivel==2)) {
    nivel=1;
    vidas=3;
    heightv=580;
    r=random(50, 255);
    g=random(50, 255);
    b=random(50, 255);
  }
  if ((325<mouseX & mouseX<500) && (200<mouseY & 300>mouseY) && (nivel==2)) exit();
}
void rebotes() {
  if (posy<20)  vy=vy*-1;
  if (posx>580) vx=vx*-1;
  if (posx<30)  vx=vx*-1;
  if (posy==500 && posx>(xpala) && posx<palax) {
    vy=vy*-1;
    puntuacion=puntuacion+1;

    
  }
}
