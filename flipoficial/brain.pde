class Brain {
  float[] weights; // includes a weight for bias as last index

  Brain(int numInputs) {
  // store numInputs weights plus one bias weight
  weights = new float[numInputs + 1];
  for (int i = 0; i < weights.length; i++) {
    weights[i] = random(-1, 1);
  }
  // tornar bias inicial levemente positivo para incentivar pulos iniciais
  weights[weights.length - 1] = random(0.5, 1.5);
}


  // copia completa do cérebro
  Brain copy() {
    Brain b = new Brain(weights.length - 1);
    for (int i = 0; i < weights.length; i++) b.weights[i] = weights[i];
    return b;
  }

  // Decide retorna boolean: soma ponderada + bias > 0
  boolean decide(float[] inputs) {
    float sum = 0;
    for (int i = 0; i < inputs.length; i++) {
      sum += inputs[i] * weights[i];
    }
    // bias (last weight * 1)
    sum += weights[weights.length - 1] * 1.0;
    return sum > 0;
  }

  Brain crossover(Brain partner) {
    int n = weights.length;
    Brain child = new Brain(n - 1);
    int mid = int(random(n));
    for (int i = 0; i < n; i++) {
      if (i > mid) child.weights[i] = weights[i];
      else child.weights[i] = partner.weights[i];
    }
    return child;
  }

  void mutate(float rate) {
    for (int i = 0; i < weights.length; i++) {
      if (random(1) < rate) {
        weights[i] += randomGaussian() * 0.3; // maior variação para explorar
        weights[i] = constrain(weights[i], -8, 8);
      }
    }
  }
}
