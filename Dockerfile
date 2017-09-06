FROM ubuntu:latest
MAINTAINER michael <code21032@gmail.com>

LABEL Description="Ubuntu yona"

RUN DEBIAN_FRONTEND=noninteractive apt-get -y update && apt-get -y install \
   && apt-get -y upgrade && apt-get -y install ntp software-properties-common \
   && echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections \
   && echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections \
   && add-apt-repository -y ppa:webupd8team/java \
   && apt-get -y update \
   && apt-get -y install oracle-java8-installer \
   && apt-get install -y oracle-java8-set-default \
   && echo Asia/Seoul | tee /etc/timezone && dpkg-reconfigure --frontend noninteractive tzdata

ENV JAVA_HOME /usr/lib/jvm/java-8-oracle

## install extra package
RUN apt-get install -y unzip

## remove cache
RUN rm -rf /var/cache/oracle-jdk8-installer && apt-get clean && rm -rf /var/lib/apt/lists/*

## add user
RUN useradd -m -d /yona -s /bin/bash -U yona

RUN mkdir /yona/downloads

## add entrypoints
RUN chmod +x /yona

## yona download link
ENV YONA_LATEST_VERSION_LINK "https://github.com/yona-projects/yona/releases/download/v1.7.0/yona-v1.7.0-bin.zip"

RUN cd /yona/downloads; \
    wget http://downloads.typesafe.com/typesafe-activator/1.2.10/typesafe-activator-1.2.10-minimal.zip &&\
    unzip typesafe-activator-1.2.10-minimal.zip

## install yona
RUN cd /yona/downloads; \
    wget -O yona.zip $YONA_LATEST_VERSION_LINK &&\
    unzip -d /yona/release yona.zip


## set environment variables
ENV YONA_HOME "/yona/home"
ENV YONA_DATA "/yona_data"
ENV JAVA_OPTS "-Xmx2048m -Xms2048m"
ENV PATH $PATH:/yona/downloads/activator-1.2.10-minimal

## add entrypoints
ADD ./entrypoints /yona/entrypoints
RUN chmod +x /yona/entrypoints/*.sh

## yobi home directory mount point from host to docker container
VOLUME ["/yona/source", "/yona/home"]

## yobi service port expose from docker container to host
EXPOSE 9000

## run yobi command
CMD ["sh","/yona/entrypoints/run.sh"]