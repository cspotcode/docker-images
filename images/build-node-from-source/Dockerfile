# Debian buster
FROM debian:10.3

ARG NODE_VERSION=v13.11.0
ARG PARALLEL_JOBS=4

RUN apt-get update
RUN apt-get install -y vim curl gnupg2 git docker g++ python make

RUN adduser --disabled-password build && usermod -aG sudo build && echo 'build ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers

USER build
WORKDIR /home/build

RUN git clone https://github.com/nodejs/node
WORKDIR /home/build/node
RUN ./configure
RUN make -j$PARALLEL_JOBS

COPY --chown=root entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
# Run interactive shell by default, which is nice for local development
CMD ["bash"]