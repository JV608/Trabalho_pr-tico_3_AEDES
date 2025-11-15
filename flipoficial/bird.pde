class Bird {
  float x, y;
  float velocity, gravity, jumpForce;
  boolean alive;
  float score;
  float fitness;
  Brain brain;

Bird() {
  x = 64;
  y = height / 2;
  velocity = jumpForce;   // <-- impulso inicial para cima
  gravity = 0.7;
  jumpForce = -10;
  alive = true;
  score = 0;
  // usamos 3 entradas + bias no Brain
  brain = new Brain(3);
}

Bird(Brain brain) {
  x = 64;
  y = height / 2;
  velocity = jumpForce;   // <-- impulso inicial para cima
  gravity = 0.7;
  jumpForce = -10;
  alive = true;
  score = 0;
  this.brain = brain.copy();
}


  void update(ArrayList<Pipe> pipes) {
    if (!alive) return;

    // encontra o cano mais próximo à frente
    Pipe closest = null;
    float minDist = Float.MAX_VALUE;
    for (Pipe p : pipes) {
      float d = (p.x + p.w) - x;
      if (d > 0 && d < minDist) {
        minDist = d;
        closest = p;
      }
    }

    // prepara inputs normalizados em [-1,1]
    if (closest != null) {
      float[] inputs = new float[3];
      inputs[0] = map(y, 0, height, -1, 1);                       // posição vertical
      inputs[1] = map(closest.gapY, 0, height, -1, 1);            // centro do gap
      inputs[2] = map(minDist, 0, width, 1, -1);                  // distância horizontal (1=perto, -1=longe)

      if (brain.decide(inputs)) { // decide já considera bias
        jump();
      }
    }

    // física
    velocity += gravity;
    velocity = constrain(velocity, -15, 15);
    y += velocity;

    score += 1; // fitness básico por frame

    // limites da tela
    if (y - 10 > height || y + 10 < 0) {
      alive = false;
    }
  }

  void jump() {
    velocity = jumpForce;
  }

  void draw() {
    if (!alive) return;
    
    image(gif, x, y, 50, 50);
  }

  void calculateFitness() {
    fitness = score * score;
    // fitness mínimo para evitar zeros
    if (fitness < 1) fitness = 1;
  }
}
