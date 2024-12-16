int numAgents = 10; // Nombre d'agents
Agent[] agents; // Array per emmagatzemar múltiples agents

void setup() {
  size(600, 600); // Tamany del sketch
  background(255); // Color de fons blanc
  agents = new Agent[numAgents]; // Inicialitzem l'array
  
  // Creem els agents amb posicions inicials aleatòries
  for (int i = 0; i < numAgents; i++) {
    agents[i] = new Agent(random(width), random(height));
  }
}

void draw() {
  for (int i = 0; i < numAgents; i++) {
    agents[i].move(); // Mou cada agent
    agents[i].display(); // Mostra cada agent
  }
}

class Agent {
  float x, y;
  float stepSize = 2; // Longitud del pas

  // Constructor
  Agent(float startX, float startY) {
    x = startX;
    y = startY;
  }

  // Funció per moure l'agent en una direcció aleatòria
  void move() {
    float angle = random(TWO_PI); // Angle aleatori
    float stepX = cos(angle) * stepSize;
    float stepY = sin(angle) * stepSize;

    x += stepX;
    y += stepY;

    // Comprovem si s'acosta a les vores de la pantalla
    if (x < 0 || x > width || y < 0 || y > height) {
      x = constrain(x, 0, width);
      y = constrain(y, 0, height);
      stepSize *= -1; // Invertim la direcció
    }

    // Comprovem la distància al ratolí i modifiquem la velocitat
    float distToMouse = dist(x, y, mouseX, mouseY);
    if (distToMouse < 100) {
      stepSize = map(distToMouse, 0, 100, 4, 1); // Reduïm la velocitat a prop del ratolí
    } else {
      stepSize = 2; // Velocitat normal
    }
  }

  // Funció per dibuixar l'agent
  void display() {
    stroke(0);
    point(x, y);
  }
}
