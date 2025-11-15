class Population {
  ArrayList<Bird> birds;
  GeneticAlgorithm ga;
  int size;

  Population(int size, float mutationRate) {
    this.size = size;
    ga = new GeneticAlgorithm(mutationRate);
    birds = new ArrayList<Bird>();
    for (int i = 0; i < size; i++) {
      birds.add(new Bird());
    }
  }

  void update(ArrayList<Pipe> pipes) {
    for (Bird b : birds) {
      if (b.alive) {
        b.update(pipes);
        for (Pipe p : pipes) {
          if (p.collides(b)) {
            b.alive = false;
            break;
          }
        }
      }
    }
  }

  void draw() {
    for (Bird b : birds) {
      b.draw();
    }
  }

  boolean allDead() {
    for (Bird b : birds) {
      if (b.alive) return false;
    }
    return true;
  }

  void evolve() {
    ga.evaluate(birds);
    birds = ga.reproduce(birds);
  }

  void resetPositions() {
    for (Bird b : birds) {
      b.x = 64;
      b.y = height / 2;
      b.velocity = 0;
      b.alive = true;
      b.score = 0;
    }
  }
}
