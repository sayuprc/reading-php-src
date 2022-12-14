FROM debian:bullseye-slim

RUN apt update \
  && apt install -y git gdb autoconf gcc bison re2c make curl

RUN cd /usr/local/src \
  && git clone --depth 1 https://github.com/php/php-src.git

RUN cd /usr/local/src/php-src \
  && ./buildconf \
  && ./configure --disable-all --enable-debug --enable-opcache \
  && make \
  && make install

RUN cd /usr/local/src \
  && git clone https://github.com/derickr/vld.git \
  && cd vld \
  && phpize \
  && ./configure \
  && make \
  && make install

RUN cd $HOME \
  && curl -LO https://git.io/.gdbinit \
  && cat /usr/local/src/php-src/.gdbinit >> $HOME/.gdbinit

WORKDIR /usr/local/src/php-src
