# Debian buster
FROM debian:10.3-slim

RUN apt-get update && apt-get install -y curl gnupg2

RUN \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update
RUN apt-get install -y vim
RUN apt-get install -y git
RUN apt-get install -y yarn
RUN apt-get install -y sudo
RUN apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg2 \
    software-properties-common
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
RUN add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/debian \
   $(lsb_release -cs) \
   stable"
RUN apt-get update && \
    apt-get install -y docker-ce docker-ce-cli containerd.io

RUN adduser --disabled-password build && usermod -aG sudo build && echo 'build ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers
RUN groupadd -g 115 docker2
RUN usermod -a -G docker build
RUN usermod -a -G docker2 build

USER build
WORKDIR /home/build

RUN echo 'export N_PREFIX="$HOME/.n"' >> ~/.profile
RUN echo 'export PATH="$N_PREFIX/bin:$PATH"' >> ~/.profile
RUN mkdir -p ~/.n/bin && curl -L https://raw.githubusercontent.com/tj/n/master/bin/n -o ~/.n/bin/n && chmod +x ~/.n/bin/n && N_PREFIX="$HOME/.n" ~/.n/bin/n lts
# Now node and npm are available

COPY --chown=root entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
# Run interactive shell by default, which is nice for local development
CMD ["bash"]