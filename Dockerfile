FROM ubuntu:latest

COPY . chess

RUN apt-get update -y
RUN apt-get install -y xauth git
RUN apt-get install -y swi-prolog

RUN git clone https://github.com/official-stockfish/Stockfish.git
WORKDIR /Stockfish/src
RUN make -j build ARCH=x86-64
ENV PATH="${PATH}:/Stockfish/src"

WORKDIR /chess/src
ENTRYPOINT ["swipl", "main.pl"]