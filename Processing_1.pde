//Se declaran las variables
float posx=width/2;
float vx=3;
float posy=height/2;
float vy=9;
float radiobola =20;
float alturapala=500;
float anchopala=80;
float altopala=20;
float xpala =0;
float palax =0;
int nivel=0;


void setup() {
  size(600, 600);
  background(0);
}


void keyPressed() {
  if (key==' ') nivel=1;  
  if (key=='n') exit();
  if (key=='y') nivel=1;
}

//Para la pantalla de presentación del juegp
void presentacion() {

  background(0);
  textSize(16);
  text("Para empezar pulsa espacio", 200, height/2);
}


void draw() {
  
  if (posy>540){
  nivel=2;
  posy=30;
  
  }

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
}

//Al perder el juego
void nivel2() {
  background(0);
  text("Perdiste ¿Reintentar?", 200, height/2.25);
  text("Si", 225, height/1.75);
  text("No", 325, height/1.75);
  text("Pulsa y", 215, height/1.5);
  text("Pulsa n", 315, height/1.5);
}

//Para la pantalla de juego
void nivel1() {

  background(0);
  xpala =(mouseX-40);
  palax =(xpala+anchopala);
  posy=vy + posy;
  posx=vx + posx;
  
  rect(xpala, alturapala, anchopala, altopala);
  ellipse(posx, posy, radiobola, radiobola);

  //Rebote de la bola
  if (posy<20) {
    vy=vy*-1;
  }

  if (posx>580) {
    vx=vx*-1;
  }
  
  if (posx<30) {
    vx=vx*-1;
  }

  if (posy==500 && posx>(xpala) && posx<palax) {
    vy=vy*-1;
    }
}