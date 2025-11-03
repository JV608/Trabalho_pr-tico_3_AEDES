Trabalho 3: Flappy Bird Inteligente

Objetivo: Desenvolver o jogo Flappy Bird utilizando a linguagem de programação Processing e, em seguida, criar uma inteligência artificial baseada em algoritmos genéticos para que o computador aprenda a jogar sozinho, evoluindo a melhor estratégia para desviar dos canos.
Divisão Sugerida: O projeto é dividido em três grandes partes:
A Mecânica do Jogo: A implementação do Flappy Bird clássico, controlado pelo jogador.
O Cérebro do Pássaro: A criação de uma estrutura de decisão simples (nosso "perceptron") que controla o pássaro.
A Evolução: A implementação do algoritmo genético que gerencia uma população de pássaros e os evolui para se tornarem jogadores cada vez melhores.

Parte 1: Conceitos Teóricos

1. O que é um Algoritmo Genético (AG)?
Pense na teoria da evolução de Darwin: os indivíduos mais adaptados ao ambiente sobrevivem e deixam descendentes, passando suas características adiante. Um Algoritmo Genético imita esse processo no computador.
População: Em vez de animais, teremos uma população de pássaros (por exemplo, 500 pássaros jogando ao mesmo tempo). Cada pássaro tem seu próprio "cérebro" com uma estratégia de decisão diferente.
Aptidão (Fitness): Como medimos qual pássaro é "mais adaptado"? Pela sua pontuação! A distância que um pássaro percorre antes de bater é a sua aptidão. Quanto mais longe ele vai, mais "apto" ele é.
Seleção: Ao final de uma rodada (quando todos os pássaros morrerem), selecionamos os melhores (os que tiveram maior aptidão) para serem os "pais" da próxima geração.
Cruzamento (Crossover): Pegamos o "DNA" (as regras de decisão) de dois pais e os combinamos para criar um "filho". O filho herda características de ambos os pais.
Mutação: Para introduzir novidade e evitar que todos os pássaros fiquem iguais, aplicamos uma pequena chance de mutação aleatória no DNA do filho. Isso pode gerar uma característica inesperada que pode ser muito boa (ou muito ruim).
Repetindo esse ciclo (Avaliar Aptidão -> Selecionar -> Cruzar -> Mudar), a população de pássaros, geração após geração, ficará cada vez melhor em jogar Flappy Bird.

2. Como o Pássaro "Pensa"? (O Perceptron Simplificado)
Nosso pássaro não terá uma inteligência complexa. Ele tomará uma única decisão: "devo pular agora ou não?".
Para decidir, ele vai olhar para o ambiente e coletar algumas informações (entradas). Por exemplo:
Sua própria altura (posição Y).
A distância horizontal até o próximo cano.
A altura do centro do vão do próximo cano.
O "cérebro" do pássaro será um conjunto de pesos. Cada peso representa a importância que o pássaro dá a cada uma dessas entradas. A decisão é tomada com uma matemática simples:


Se o resultado da SomaPonderada for maior que um certo valor (por exemplo, zero), o pássaro pula. Caso contrário, não faz nada.
O "DNA" do pássaro são exatamente esses pesos! O algoritmo genético não vai mudar o código do pássaro; ele vai encontrar a combinação perfeita de Peso_1, Peso_2 e Peso_3 que resulta na melhor performance.

Parte 2: Detalhes da Implementação (O Passo a Passo)

Fase 1: Construir o Jogo Flappy Bird
Nesta fase, esqueçam a IA. O objetivo é ter um jogo funcional controlado pela barra de espaço.
Crie a Classe Bird:
Atributos: float x, y (posição), float velocity (velocidade vertical), float gravity (gravidade), float jumpForce (força do pulo).
Métodos:
update(): A cada frame, adiciona a gravity à velocity e a velocity à posição y.
jump(): Define a velocity com um valor negativo (ex: -10) para mover o pássaro para cima.
draw(): Desenha o pássaro na tela (pode ser um círculo ou uma imagem).
checkCollision(Pipe pipe): Verifica se o pássaro colidiu com um cano ou com os limites da tela.
Crie a Classe Pipe:
Atributos: float x (posição horizontal), float gapY (posição vertical do centro do vão), float gapHeight (altura do vão), float width (largura do cano).
Métodos:
update(): Move o cano da direita para a esquerda.
draw(): Desenha os dois retângulos do cano (superior e inferior).
Gerenciamento no Sketch Principal:
No setup(), inicialize o pássaro e uma lista (ArrayList) de canos.
No draw(), chame os métodos update() e draw() de todos os objetos.
Crie uma lógica para adicionar novos canos à lista em intervalos regulares.
Remova os canos que já saíram da tela para não sobrecarregar a memória.
Implemente a lógica de "Game Over" e reinício.
Use keyPressed() para chamar o método bird.jump() quando uma tecla for pressionada.
Dica: Foquem em deixar esta parte 100% funcional antes de passar para a próxima fase.

Fase 2: Implementando o Cérebro e a População
Agora, vamos preparar o terreno para o algoritmo genético.
Crie a Classe Brain (ou integre no Bird):
Atributos: Um array ou ArrayList de floats para os pesos (float[] weights). O número de pesos deve ser igual ao número de entradas que vocês decidirem usar (sugestão: 3 a 5 entradas).
Construtor: Inicialize os pesos com valores aleatórios (ex: entre -1 e 1).
Método decide(float[] inputs):
Recebe um array de floats com os valores das entradas (altura do pássaro, distância do cano, etc.).
Calcula a soma ponderada, como na fórmula da parte teórica.
Retorna true se a soma for maior que zero (pular) e false caso contrário.
Modifique a Classe Bird:
Cada Bird agora deve ter um objeto Brain.
Cada Bird também precisa de um atributo int score ou float fitness.
No método update() do pássaro, em vez de esperar por uma tecla, ele deve:
a. Coletar as informações do ambiente (as "entradas"). Dica: Normalizem esses valores (convertam para uma faixa de 0 a 1 ou -1 a 1) para o cérebro funcionar melhor.
b. Chamar brain.decide(inputs).
c. Se a decisão for pular, chame o método jump().
d. Incremente o score do pássaro a cada frame que ele sobrevive.
Crie a População:
No sketch principal, em vez de um Bird, crie um ArrayList<Bird> population.
No setup(), popule essa lista com N pássaros (ex: 500), cada um com um Brain de pesos aleatórios.

Fase 3: O Algoritmo Genético
Esta é a classe que orquestrará a evolução.
Crie a Classe GeneticAlgorithm:
Método evaluate(ArrayList<Bird> population):
Este método é chamado quando a rodada acaba (todos os pássaros morreram).
Primeiro, calcule a aptidão de cada pássaro. A forma mais simples é fitness = score. Para dar mais valor aos melhores, você pode elevar ao quadrado: fitness = score * score.
Calcule a soma total de fitness da população.
Normalize o fitness de cada pássaro (divida o fitness individual pela soma total). Agora, o fitness de cada pássaro é uma probabilidade entre 0 e 1.
Método selection(ArrayList<Bird> population):
Cria uma "piscina de acasalamento" (mating pool).
Itere por todos os pássaros da população antiga. Adicione cada pássaro à piscina um número de vezes proporcional ao seu fitness normalizado. Pássaros com fitness alto aparecerão mais vezes na piscina, tendo mais chance de serem escolhidos.
Retorna essa piscina.
Método reproduce(ArrayList<Bird> matingPool):
Cria uma nova ArrayList<Bird> para a nova geração.
Para cada novo pássaro a ser criado:
a. Escolha aleatoriamente dois "pais" da matingPool.
b. Crie um novo Brain para o "filho".
c. Crossover: Itere pelos pesos. Para cada peso, sorteie se ele virá do pai A ou do pai B.
d. Mutação: Itere por cada peso do novo cérebro do filho. Com uma pequena chance (ex: 1% ou 5%), mude o valor daquele peso para um novo valor aleatório.
e. Crie um novo Bird com este cérebro e adicione à nova população.
Retorna a newPopulation.

Fase 4: Juntando Tudo
No Sketch Principal:
Tenha uma variável para a população atual e uma instância da sua classe GeneticAlgorithm.
No draw():
Faça o loop de atualização e desenho de todos os pássaros vivos.
Verifique se todos os pássaros morreram.
Quando todos morrerem:
Chame ga.evaluate(population).
Crie a piscina de acasalamento com ga.selection(population).
Crie a nova geração com ga.reproduce(matingPool).
Substitua a population antiga pela nova.
Reinicie o jogo (resete os canos, etc.).
Visualização: É muito importante exibir informações na tela para ver o progresso! Mostre o número da geração atual, a pontuação do melhor pássaro da geração anterior e quantos pássaros ainda estão vivos.
Dica: Adicione um controle (um slider ou uma tecla) para acelerar a simulação. Rodar o draw() várias vezes por frame fará com que o processo de aprendizado, que pode levar centenas de gerações, seja muito mais rápido.
Entregáveis e Avaliação
Código-fonte: O projeto completo em Processing, bem comentado e organizado (compactado em formato zip).
Apresentação/Slide: Uma breve demonstração do projeto funcionando, mostrando a evolução ao longo das gerações.
As entradas que escolheram para o cérebro do pássaro e por quê.
Os parâmetros do algoritmo genético (tamanho da população, taxa de mutação) e como chegaram a esses valores.
As dificuldades encontradas e como as resolveram.
Uma conclusão sobre o resultado: o pássaro realmente aprendeu a jogar?
Vídeo de Execução do Código: Um vídeo mostrando a evolução do pássaro
