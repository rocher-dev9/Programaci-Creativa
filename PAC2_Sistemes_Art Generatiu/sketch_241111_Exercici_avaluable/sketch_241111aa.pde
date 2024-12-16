// Aquest sketch és una peça d'art generatiu que crea un conjunt de cercles que es mouen de forma aleatòria dins del canvas.
// Els cercles varien en grandària, velocitat i color, creant un efecte visual dinàmic i imprevisible. 
// La peça interactua amb el moviment del ratolí: quan el ratolí es troba a prop d'un cercle, aquest es mou cap a ell i canvia de color per indicar la interacció. 
// Si el ratolí està a prop d'algun cercle, es mostra un missatge a la part inferior del canvas indicant aquesta proximitat.

int numCircles = 50; // Nombre de cercles
Circle[] circles; // Array per emmagatzemar els cercles

void setup() {
  size(600, 600); // Tamany del sketch (assegurem que sigui visible)
  background(30); // Color de fons gris fosc
  circles = new Circle[numCircles]; // Inicialitzem l'array de cercles

  // Creem els cercles amb posicions, velocitats i colors aleatoris
  for (int i = 0; i < numCircles; i++) {
    float x = random(width);
    float y = random(height);
    float size = random(10, 40);
    float speedX = random(-2, 2);
    float speedY = random(-2, 2);
    color col = color(random(255), random(255), random(255), 150);
    circles[i] = new Circle(x, y, size, speedX, speedY, col);
  }
}

void draw() {
  background(30); // Refresquem el fons per evitar que els cercles deixin rastre

  boolean mouseIsNear = false; // Variable per comprovar si el ratolí està a prop de qualsevol cercle

  // Actualitzem i dibuixem cada cercle
  for (int i = 0; i < numCircles; i++) {
    circles[i].move();
    circles[i].display();

    // Si algun cercle interactua amb el ratolí, activem la variable
    if (dist(circles[i].x, circles[i].y, mouseX, mouseY) < 100) {
      mouseIsNear = true;
    }
  }

  // Mostrem un missatge si el ratolí està a prop d'un cercle
  if (mouseIsNear) {
    fill(255);
    textSize(20);
    text("El ratolí està a prop!", 20, height - 20);
  }
}

class Circle {
  float x, y; // Posició
  float size; // Grandària del cercle
  float speedX, speedY; // Velocitat en les direccions X i Y
  color col; // Color del cercle

  // Constructor
  Circle(float x, float y, float size, float speedX, float speedY, color col) {
    this.x = x;
    this.y = y;
    this.size = size;
    this.speedX = speedX;
    this.speedY = speedY;
    this.col = col;
  }

  // Mou el cercle dins del canvas, canviant de direcció si toca les vores
  void move() {
    // Comportament per moure cap al ratolí si és a prop
    float distanceToMouse = dist(x, y, mouseX, mouseY);
    if (distanceToMouse < 100) {
      float attractionStrength = 0.05;
      speedX += (mouseX - x) * attractionStrength / distanceToMouse;
      speedY += (mouseY - y) * attractionStrength / distanceToMouse;

      // Canvi de color per indicar la interacció amb el ratolí
      col = color(255, 0, 0, 150); // Canvia a vermell semitransparent
    } else {
      col = color(random(255), random(255), random(255), 150); // Torna al color original
    }

    x += speedX;
    y += speedY;

    // Comprovem les vores i canviem de direcció si és necessari
    if (x < 0 || x > width) {
      speedX *= -1;
    }
    if (y < 0 || y > height) {
      speedY *= -1;
    }

    // Limitem la velocitat màxima per evitar moviments excessius
    speedX = constrain(speedX, -5, 5);
    speedY = constrain(speedY, -5, 5);
  }

  // Mostra el cercle a la pantalla
  void display() {
    fill(col);
    noStroke();
    ellipse(x, y, size, size);
  }
}
