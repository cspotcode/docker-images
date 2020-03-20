# Debian buster
FROM debian:10.3-slim

RUN apt-get update && apt-get install -y curl gnupg2

RUN \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update
RUN apt-get install -y vim
RUN apt-get install -y git
RUN apt-get install -y docker
RUN apt-get install -y yarn

COPY --chown=root entrypoint.sh /entrypoint.sh

RUN adduser --disabled-password build && usermod -aG sudo build && echo 'build ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers

ENTRYPOINT ["/entrypoint.sh"]

USER build
WORKDIR /home/build

RUN echo 'export N_PREFIX=$HOME/.n' >> ~/.bashrc
RUN echo 'export PATH="$N_PREFIX/bin:$PATH"' >> ~/.bashrc
RUN mkdir -p ~/.n/bin && curl -L https://raw.githubusercontent.com/tj/n/master/bin/n -o ~/.n/bin/n && chmod +x ~/.n/bin/n && N_PREFIX="$HOME/.n" ~/.n/bin/n lts
# Now node and npm are available

CMD ["bash", "-i"]