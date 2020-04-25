FROM php:7.4-cli

#Accept input argument
ARG SSH_PRIVATE_KEY
ARG GIT_BRANCH
ARG GIT_REPO
ARG IP_SERVER
ARG PROJECT_DIR
ARG INIT
ARG ENV

# Install Git
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y git

# Make ssh dir
RUN mkdir ~/.ssh/
RUN touch ~/.ssh/config
COPY ./config ~/.ssh/config
RUN chmod 700 ~/.ssh/config

# Install Deployer
RUN curl -LO https://deployer.org/deployer.phar && \
	mv deployer.phar /usr/local/bin/dep && \
	chmod +x /usr/local/bin/dep

