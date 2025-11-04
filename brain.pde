class Brain {
  float[] weights;

  Brain(int numInputs) {
    weights = new float[numInputs];
    for (int i = 0; i < numInputs; i++) {
      weights[i] = random(-1, 1);
    }
  }

  // Decide retorna boolean: true = pular
  boolean decide(float[] inputs) {
    float sum = 0;
    for (int i = 0; i < inputs.length; i++) {
      sum += inputs[i] * weights[i];
    }
    // threshold simples em 0
    return sum > 0;
  }

  Brain crossover(Brain partner) {
    Brain child = new Brain(weights.length);
    int mid = int(random(weights.length));
    for (int i = 0; i < weights.length; i++) {
      if (i > mid) child.weights[i] = weights[i];
      else child.weights[i] = partner.weights[i];
    }
    return child;
  }

  void mutate(float rate) {
    for (int i = 0; i < weights.length; i++) {
      if (random(1) < rate) {
        weights[i] += randomGaussian() * 0.2;
        weights[i] = constrain(weights[i], -5, 5);
      }
    }
  }
}
