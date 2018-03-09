#FROM ubuntu:xenial
FROM phusion/baseimage

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

RUN apt-get update && apt-get install -y --no-install-recommends \
        ca-certificates \
        curl \
        wget \
        git \
        bash-completion \
        software-properties-common \
        postgresql-client \
        openjdk-8-jdk \
        maven \
        gradle \
        nano \
        dos2unix \
        unzip \
		locales


# Define commonly used JAVA_HOME variable
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64

ENV LANG='en_US.UTF-8' LANGUAGE='en_US:en' LC_ALL='en_US.UTF-8'
RUN locale-gen en_US.UTF-8

WORKDIR /tmp

#DCEVM installation
#Since DCEVM for Xenial seems kind of broken, we download it from zetzy
RUN wget http://mirrors.kernel.org/ubuntu/pool/universe/o/openjdk-8-jre-dcevm/openjdk-8-jre-dcevm_8u112-2_amd64.deb && \
    dpkg -i openjdk-8-jre-dcevm_8u112-2_amd64.deb

#Create source folders
RUN mkdir -p /home/developer/src

# Bash configuration
#Configure colors and autocompletion
COPY bashrc /root/.bashrc
COPY bashrc /home/developer/.bashrc
#Configure some useful aliases
COPY bash_aliases /root/.bash_aliases
COPY bash_aliases /home/developer/.bash_aliases

# for windows client
RUN dos2unix /root/.bashrc
RUN dos2unix /home/developer/.bashrc
RUN dos2unix /root/.bash_aliases
RUN dos2unix /home/developer/.bash_aliases

RUN apt install -y sudo

RUN export HOME=/home/developer
RUN export uid=1000 gid=1000 && \
    mkdir -p /home/developer && \
    echo "developer:x:${uid}:${gid}:Developer,,,:/home/developer:/bin/bash" >> /etc/passwd && \
    echo "developer:x:${uid}:" >> /etc/group && \
    echo "developer ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/developer && \
    chmod 0440 /etc/sudoers.d/developer && \
    chown ${uid}:${gid} -R /home/developer

RUN chown -R developer /home/developer

RUN wget https://deb.nodesource.com/setup_6.x -O -| sudo bash - \
  && apt-get install nodejs -y

RUN npm install -g grunt bower gulp

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

USER developer
WORKDIR /home/developer/src

EXPOSE 5005:5005
EXPOSE 8080:8080
EXPOSE 8000:8000