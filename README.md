# RepositorioTemplate
Esse repositório é para ser utilizado pelos grupos como um template inicial, da home page do Projeto.
As seções do Template NÃO DEVEM SER OMITIDAS, sendo TODAS RELEVANTES.

**!! *Atenção: Renomeie o seu repositório para (Ano.Semestre)_(Grupo)_(Paradigma)_(NomeDoProjeto)*. !!** 

Paradigmas:
 - Funcional
 - Logico
 - SMA

**!! *Não coloque os nomes dos alunos no título do repositório*. !!**

**!! *Exemplo de título correto: 2022.1_G1_Logico_ProjetoRoteirosAereos*. !!**
 
 (Apague esses comentários)

# NomeDoProjeto

**Disciplina**: FGA0210 - PARADIGMAS DE PROGRAMAÇÃO - T01 <br>
**Nro do Grupo**: XX<br>
**Paradigma**: XXXXXXXXXX<br>

## Alunos
|Matrícula | Aluno |
| -- | -- |
| xx/xxxxxx  |  xxxx xxxx xxxxx |
| xx/xxxxxx  |  xxxx xxxx xxxxx |

## Sobre 
Descreva o seu projeto em linhas gerais. 
Use referências, links, que permitam conhecer um pouco mais sobre o projeto.

## Screenshots
Adicione 2 ou mais screenshots do projeto em termos de interface e/ou funcionamento.

## Instalação 
**Linguagens**: xxxxxx<br>
**Tecnologias**: xxxxxx<br>

## Pré-requisitos
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
Explique como usar seu projeto.
Procure ilustrar em passos, com apoio de telas do software.

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
| -- | -- | -- |
| Fulano  |  Programação dos Fatos da Base de Conhecimento Lógica | Boa |

## Outros 
Quaisquer outras informações sobre o projeto podem ser descritas aqui.
(i) Lições Aprendidas;
(ii) Percepções;
(iii) Contribuições e Fragilidades, e
(iV) Trabalhos Futuros.

## Fontes
Referencie, adequadamente, as referências utilizadas.
Indique ainda, fontes de leitura complementares.
