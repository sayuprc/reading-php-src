FROM debian:bookworm-slim

COPY ["./installer", "/tmp/installer"]

RUN apt update \
  && ./tmp/installer

COPY ["./php-src", "/usr/local/src/php-src"]
COPY ["./config.nice", "/usr/local/src/php-src/config.nice"]

RUN cd /usr/local/src/php-src \
  && ./buildconf \
  && ./config.nice \
  && make \
  && make install

COPY ["./vld", "/usr/local/src/vld"]

RUN cd /usr/local/src/vld \
  && phpize \
  && ./configure \
  && make \
  && make install

RUN cd $HOME \
  && curl -LO https://git.io/.gdbinit \
  && cat /usr/local/src/php-src/.gdbinit >> $HOME/.gdbinit

RUN pecl channel-update pecl.php.net \
  && pecl install ast

WORKDIR /usr/local/src/php-src
