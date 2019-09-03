FROM gcc:latest
COPY . /usr/src/gikou
WORKDIR /usr/src/gikou
RUN sed -i -e '/^INCLUDES/i CXXFLAGS += -static' -e 's/^LIBRARIES.*$/LIBRARIES = -Wl,--whole-archive -lpthread -Wl,--no-whole-archive/' ./Makefile
RUN make release
