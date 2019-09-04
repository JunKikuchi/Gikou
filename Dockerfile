FROM gcc:latest

COPY . /usr/src/gikou
WORKDIR /usr/src/gikou
RUN sed -i -e '/^INCLUDES/i CXXFLAGS += -static' -e 's/^LIBRARIES.*$/LIBRARIES = -Wl,--whole-archive -lpthread -Wl,--no-whole-archive/' ./Makefile \
  && make release \
  && mv bin/release bin/gikou

WORKDIR /usr/src
RUN curl -L -O https://github.com/gikou-official/Gikou/releases/download/v2.0.2/gikou2_win.zip \
  && unzip gikou2_win.zip -d gikou2_win \
  && rm gikou2_win.zip \
  && cp gikou2_win/*.bin gikou/bin \
  && cp gikou2_win/*/00_*.bin gikou/bin/00_all.bin \
  && cp gikou2_win/*/01_*.bin gikou/bin/01_yagura.bin \
  && cp gikou2_win/*/02_*.bin gikou/bin/02_aigakari.bin \
  && cp gikou2_win/*/03_*.bin gikou/bin/03_yokofudori.bin \
  && cp gikou2_win/*/04_*.bin gikou/bin/04_kakugawari.bin \
  && cp gikou2_win/*/05_*.bin gikou/bin/05_shikenbisya.bin \
  && cp gikou2_win/*/06_*.bin gikou/bin/06_nakabisya.bin \
  && cp gikou2_win/*/07_*.bin gikou/bin/07_sankenbisya.bin \
  && cp gikou2_win/*/08_*.bin gikou/bin/08_mukaibisya.bin \
  && cp gikou2_win/*/09_*.bin gikou/bin/09_other.bin

FROM alpine:latest
COPY --from=0 /usr/src/gikou/bin /usr/local/gikou/bin
WORKDIR /usr/local/gikou/bin
ENTRYPOINT ["./gikou"]
