# Xadrez

**Disciplina**: FGA0210 - PARADIGMAS DE PROGRAMAÇÃO - T01 <br>
**Nro do Grupo**: 03<br>
**Paradigma**: Lógico<br>

## Alunos

|Matrícula | Aluno |
| :--: | :--: |
| 20/2028211 |  [Antônio Aldísio](https://github.com/AntonioAldisio/) |
| 19/0026243 |  [Dafne Moretti Moreira](https://github.com/DafneM/) |
| 18/0122258 |  [Igor Queiroz Lima](https://github.com/igorq937/) |
| 19/0030879 |  [João Pedro Moura Oliveira](https://github.com/Joao-Moura/) |
| 17/0080102 |  [Lucas Gomes Lopes](https://github.com/LucasGlopes/) |
| 18/0114093 |  [Lucas Ursulino Boaventura](https://github.com/lboaventura25/) |
| 19/0019085 |  [Rafael Cleydson da Silva Ramos](https://github.com/RcleydsonR/) |
| 19/0020377 |  [Thiago Sampaio de Paiva](https://github.com/thiagohdaqw/) |


## Sobre 

O projeto,como o próprio nome já diz, trata-se de um Xadrez, jogo de tabuleiro de natureza recreativa ou competitiva para dois jogadores. A partida de xadrez é disputada em um tabuleiro de casas claras e escuras, sendo que, no início, cada enxadrista controla dezesseis peças com diferentes formatos e características. O objetivo da partida é dar xeque-mate (também chamado simplesmente de mate) no rei adversário.

O motivo para a escolha desse tema é em decorrência da complexidade por trás de toda a interface gráfica e dos algoritmos de movimentação das diferentes peças do xadrez. Portanto, como uma forma de se aprender o paradigma lógico com a linguagem [Prolog](https://www.swi-prolog.org/) com objeitvo de exercitar a lógica para resolução de problemas, esse trabalho foi concebido.

A ideia do projeto é baseada em um projeto de um dos integrantes do grupo e de uma biblioteca Python que faz a conexão com o Stockfish: [chessGamer](https://gitlab.com/ensino_unb/EDAFGA/2020_1/grupo-1-ai/-/tree/feature/chessGame/src) e [stockfish](https://github.com/zhelyabuzhsky/stockfish)

## Screenshots
* Menu da Aplicação:

<img src="https://user-images.githubusercontent.com/49499946/182047320-620b487a-1745-49e6-81a2-d3bb20d4cffb.png" width="600" />


* Tela do Jogo:

<img src="https://user-images.githubusercontent.com/49499946/182047209-65fea064-f314-4edc-8505-6d47c6f1a5f2.png" width="600" />

* Jogo em execução:

<img src="https://user-images.githubusercontent.com/49499946/182209197-e13eb1b0-a3c1-4cbd-ac9e-5e4355e17ffe.gif" width="600" />

## Instalação 
**Linguagem**: [Prolog](https://www.swi-prolog.org/) <br>
**Tecnologias**: Prolog e [Stockfish](https://stockfishchess.org/)<br>

## Pré-requisitos
### Prolog

Para toda a codificação foi utilizado o Prolog, mais especificamente o [swipl](https://www.swi-prolog.org/). Um tutorial mais completo sobre sua instalação pode ser encontrado em [https://www.swi-prolog.org/build/unix.html](https://www.swi-prolog.org/build/unix.html). Entretanto, para fins práticos, a instalação a seguir foi utilizada pelos membros:
```bash
# Clone o repositório do swipl
$ git clone https://github.com/SWI-Prolog/swipl-devel.git

# Entre na pasta onde se encontra o Makefile
$ cd swipl-devel

# Crie uma pasta para a build e entre nela
$ mkdir build
$ cd build

# Builde o projeto
$ cmake -DCMAKE_INSTALL_PREFIX=/usr/local ..
$ make
$ sudo make install
```

### Stockfish 15

Para realizar a análise e avaliação do tabuleiro, foi utilizado um programa externo conhecido como Stockfish. Ele é responsável por calcular, e analisar a pontuação do tabuleiro em uma determinada jogada. A sua instalação deve ser feita da seguinte maneira (compilando da source):
```bash
# Clone o repositório do Stockfish
$ git clone https://github.com/official-stockfish/Stockfish.git

# Entre na pasta onde se encontra o Makefile
$ cd Stockfish/src

# Rode o comando make (instalação padrão)
$ make -j build ARCH=x86-64

# Adicione a pasta src no seu $PATH (temporário), pois lá que se encontra o executável
$ export PATH="$PATH:pasta_do_stockfish/src"
```

## Uso 

Para utilizar o projeto é necessário estar com o prolog e o Stockfish instalados e no path do terminal. Com isso feito, e considerando que esteja na raiz do projeto, basta executar os seguintes comandos:
```bash
# Clone do projeto
git clone https://github.com/UnBParadigmas2022-1/2022.1_G3_Logico_Chess.git

# Entre na pasta onde se encontram os arquivos .pl
$ cd /2022.1_G3_Logico_Chess/src/

# Entrando no interpretador do swipl
$ swipl main.pl

# Executando a main
$ main.
```

## Vídeo
Adicione 1 ou mais vídeos com a execução do projeto.
Procure: 
(i) Introduzir o projeto;
(ii) Mostrar passo a passo o código, explicando-o, e deixando claro o que é de terceiros, e o que é contribuição real da equipe;
(iii) Apresentar particularidades do Paradigma, da Linguagem, e das Tecnologias, e
(iV) Apresentar lições aprendidas, contribuições, pendências, e ideias para trabalhos futuros.
OBS: TODOS DEVEM PARTICIPAR, CONFERINDO PONTOS DE VISTA.
TEMPO: +/- 15min

## Participações
Apresente, brevemente, como cada membro do grupo contribuiu para o projeto.
|Nome do Membro | Contribuição | Significância da Contribuição para o Projeto (Excelente/Boa/Regular/Ruim/Nula) |
| :--: | :--: | :--: |
| [Antônio Aldísio](https://github.com/AntonioAldisio/) | Lógica da torre e promoção do peão em rainha| Excelente |
| [Dafne Moretti Moreira](https://github.com/DafneM/) | Lógica de movimentação do bispo, da rainha e do rei | Excelente |
| [Igor Queiroz Lima](https://github.com/igorq937/) | FALTA | Excelente |
| [João Pedro Moura Oliveira](https://github.com/Joao-Moura/) | Integração com o Stockfish, lógica do check, xequemate e roque | Excelente |
| [Lucas Gomes Lopes](https://github.com/LucasGlopes/) | Lógica do Cavalo | Excelente |
| [Lucas Ursulino Boaventura](https://github.com/lboaventura25/) | Multiplayer Socket | Boa |
| [Rafael Cleydson da Silva Ramos](https://github.com/RcleydsonR/) | Estrutura e functores iniciais, lógica do peão (3 movimentos básicos) e da rainha. | Excelente |
| [Thiago Sampaio de Paiva](https://github.com/thiagohdaqw/) | Menu, Fluxo do Jogo, Multiplayer Socket e Integração | Excelente |


## Outros 
### Lições Aprendidas

O Prolog, por utilizar o paradigma lógico, faz uso extensivo das entradas e saidas da máquina de von Neumann, permitindo que ambos caminhos sejam possíveis, facilitando diversas programações. Além disso, o controle de fluxo se torna essencial nos códigos, garantindo grande controle ao programador.

Outro ponto fundamental desse paradigma, que também se encontra presente no funcional, é a utilização de listas como uma das estruturas principais. E graças a isso, a recursividade passa a ser abordada de uma maneira quase trivial.

<!-- ### Percepções -->

### Contribuições e Fragilidades

Uma das principais contribuições que o projeto pode ter é no desenvolvimento separado da interface que faz a conexão com o Stockfish, permitindo que outros programadores e cientistas possam ter um acesso facilitado a esse executável, através de uma biblioteca encapsulada.

### Melhorias Futuras
Diversas alterações e melhorias ainda podem ser feitas, e a equipe separou algumas interessantes:

- Melhor encapsulamento do Stockfish, sem a necessidade de abertura e fechamento a cada execução de um comando.
- Integração de novos comandos do Stockfish.
- Validação própria sem utilizar o Stockfish por trás dos panos.
- Mostrar caminho possível para peça selecionado pelo jogador.
- Colocar o algoritimo padrão de movimento no movimento da torre.
- O jogo fechar o terminal do prolog para recomeçar uma nova partida.


## Fontes
- Insipirado em: chessGame. Disponível em: <https://gitlab.com/ensino_unb/EDAFGA/2020_1/grupo-1-ai/-/tree/feature/chessGame/src>
- Documentação do Prolog. Disponível em: <https://www.swi-prolog.org/>
- Bramer, M. A. [Logic Programming with Prolog](https://www.amazon.com.br/Logic-Programming-PROLOG-Max-Bramer-dp-144715486X/dp/144715486X/ref=dp_ob_title_bk). New York: Springer, 2013. 
