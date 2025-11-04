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
    velocity = 0;
    gravity = 0.7;
    jumpForce = -10;
    alive = true;
    score = 0;
    brain = new Brain(3); // 3 inputs: y, pipeCenterY, distToPipe
  }

  Bird(Brain brain) {
    x = 64;
    y = height / 2;
    velocity = 0;
    gravity = 0.7;
    jumpForce = -10;
    alive = true;
    score = 0;
    this.brain = brain;
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

      if (brain.decide(inputs)) {
        jump();
      }
    }

    // física
    velocity += gravity;
    velocity = constrain(velocity, -15, 15);
    y += velocity;

    score += 1; // fitness básico

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
    fill(255, 200, 0);
    ellipse(x, y, 20, 20);
  }

  void calculateFitness() {
    fitness = score * score;
  }
}
