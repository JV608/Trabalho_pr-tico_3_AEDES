ArrayList<Bird> population;
ArrayList<Pipe> pipes;
GeneticAlgorithm ga;
int populationSize = 200;

void setup() {
  size(800, 600);
  pipes = new ArrayList<Pipe>();
  population = new ArrayList<Bird>();
  for (int i = 0; i < populationSize; i++) {
    population.add(new Bird());
  }
  ga = new GeneticAlgorithm(0.05);
}

void draw() {
  background(0, 150, 255);

  // Gera novos canos periodicamente
  if (frameCount % 100 == 0) {
    pipes.add(new Pipe());
  }

  // Atualiza e desenha canos
  for (int i = pipes.size() - 1; i >= 0; i--) {
    Pipe p = pipes.get(i);
    p.update();
    p.draw();
    if (p.x + p.width < 0) {
      pipes.remove(i);
    }
  }

  // Atualiza e desenha pássaros
  boolean allDead = true;
  for (Bird b : population) {
    if (b.alive) {
      b.update(pipes);
      b.draw();
      for (Pipe p : pipes) {
        if (p.collides(b)) {
          b.alive = false;
          break;
        }
      }
    }
    if (b.alive) allDead = false;
  }

  // Se todos morreram, gera nova população
  if (allDead) {
    ga.evaluate(population);
    population = ga.reproduce(population);
    pipes.clear();
    frameCount = 0;
  }

  // HUD
  fill(255);
  textSize(16);
  text("Geração: " + ga.generation, 10, 20);
  text("Melhor Score: " + ga.bestScore, 10, 40);
}
