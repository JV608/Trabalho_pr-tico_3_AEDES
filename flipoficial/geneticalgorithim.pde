class GeneticAlgorithm {
  float mutationRate;
  int generation;
  float bestScore;
  Bird bestBird;

  GeneticAlgorithm(float mutationRate) {
    this.mutationRate = mutationRate;
    this.generation = 1;
    this.bestScore = 0;
  }

  void evaluate(ArrayList<Bird> population) {
    float totalFitness = 0;
    bestScore = 0;
    bestBird = null;

    for (Bird b : population) {
      b.calculateFitness();
      totalFitness += b.fitness;
      if (b.score > bestScore) {
        bestScore = b.score;
        bestBird = b;
      }
    }

    // proteger contra soma zero
    if (totalFitness <= 0.0001) {
      float equal = 1.0 / population.size();
      for (Bird b : population) b.fitness = equal;
      return;
    }

    for (Bird b : population) {
      b.fitness /= totalFitness;
    }
  }

  Bird selectParent(ArrayList<Bird> population) {
    float r = random(1);
    float sum = 0;
    for (Bird b : population) {
      sum += b.fitness;
      if (sum > r) {
        return b;
      }
    }
    // fallback aleatório
    return population.get(int(random(population.size())));
  }

  ArrayList<Bird> reproduce(ArrayList<Bird> oldPopulation) {
    ArrayList<Bird> newPopulation = new ArrayList<Bird>();
    for (int i = 0; i < oldPopulation.size(); i++) {
      Bird parentA = selectParent(oldPopulation);
      Bird parentB = selectParent(oldPopulation);
      Brain childBrain = parentA.brain.crossover(parentB.brain);
      childBrain.mutate(mutationRate);
      Bird child = new Bird(childBrain);
      newPopulation.add(child);
    }
    generation++;
    return newPopulation;
  }
}
