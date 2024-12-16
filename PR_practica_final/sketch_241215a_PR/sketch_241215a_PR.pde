// Dimensions del joc
int amplada = 600;
int altura = 600;

// Coet
float coetX = amplada / 2;
float coetY = altura - 50;
float velocitatCoet = 5;
int ampladaCoet = 20;
int alturaCoet = 30;

// Obstacles
int numObstacles = 6;
float[] obstacleX = new float[numObstacles];
float[] obstacleY = new float[numObstacles];
int ampladaObstacle = 50;
int alçadaObstacle = 10;
float velocitatObstacles = 3;

// Puntuació i estat
int puntuacio = 0;
boolean jocFinalitzat = false;

// Configuració inicial
void settings() {
  size(amplada, altura); // Aquí configurem les dimensions de la finestra
}

void setup() {
  resetJoc();
}

void draw() {
  if (jocFinalitzat) {
    mostrarMissatgeFinal();
    return;
  }
  
  background(0); // Fons negre

  // Dibuixar coet i obstacles
  dibuixarCoet();
  actualitzarObstacles();
  dibuixarObstacles();

  // Comprovar col·lisions
  comprovarColisions();

  // Dibuixar puntuació
  mostrarPuntuacio();
}

void dibuixarCoet() {
  stroke(255);
  fill(255);
  triangle(coetX, coetY, coetX - ampladaCoet / 2, coetY + alturaCoet, coetX + ampladaCoet / 2, coetY + alturaCoet);
}

void actualitzarObstacles() {
  for (int i = 0; i < numObstacles; i++) {
    obstacleY[i] += velocitatObstacles;
    // Si l'obstacle surt de la pantalla, el tornem a posar a dalt
    if (obstacleY[i] > altura) {
      obstacleY[i] = random(-300, -50);
      obstacleX[i] = random(0, amplada - ampladaObstacle);
    }
  }
}

void dibuixarObstacles() {
  fill(255, 0, 0);
  noStroke();
  for (int i = 0; i < numObstacles; i++) {
    rect(obstacleX[i], obstacleY[i], ampladaObstacle, alçadaObstacle);
  }
}

void comprovarColisions() {
  for (int i = 0; i < numObstacles; i++) {
    if (coetX > obstacleX[i] && coetX < obstacleX[i] + ampladaObstacle &&
        coetY > obstacleY[i] && coetY < obstacleY[i] + alçadaObstacle) {
      jocFinalitzat = true;
    }
  }

  // Si el coet arriba a dalt, sumar punt i reiniciar posició
  if (coetY < 0) {
    puntuacio++;
    coetY = altura - 50;
    velocitatObstacles += 0.2; // Augmenta la dificultat
  }
}

void mostrarPuntuacio() {
  fill(255);
  textSize(16);
  text("Punts: " + puntuacio, 10, 20);
}

void mostrarMissatgeFinal() {
  background(0);
  fill(255);
  textSize(32);
  textAlign(CENTER, CENTER);
  text("Fi del joc!", amplada / 2, altura / 2 - 20);
  textSize(16);
  text("Prem 'R' per tornar a començar", amplada / 2, altura / 2 + 20);
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) coetY -= velocitatCoet; // Mou el coet cap amunt
    if (keyCode == DOWN) coetY += velocitatCoet; // Mou el coet cap avall
    if (keyCode == LEFT) coetX -= velocitatCoet; // Mou el coet cap a l'esquerra
    if (keyCode == RIGHT) coetX += velocitatCoet; // Mou el coet cap a la dreta
  }

  // Reiniciar el joc si el jugador prem 'R'
  if (key == 'r' || key == 'R') {
    resetJoc();
  }
}

void resetJoc() {
  coetX = amplada / 2;
  coetY = altura - 50;
  puntuacio = 0;
  velocitatObstacles = 3;

  // Inicialitzar obstacles
  for (int i = 0; i < numObstacles; i++) {
    obstacleX[i] = random(0, amplada - ampladaObstacle);
    obstacleY[i] = random(-300, -50);
  }

  jocFinalitzat = false;
}
