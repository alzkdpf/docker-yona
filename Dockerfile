FROM ubuntu:16.04
MAINTAINER michael <code21032@gmail.com>

LABEL Description="Ubuntu yona"

ENV ACTIVATOR_VERSION 1.2.10

RUN DEBIAN_FRONTEND=noninteractive apt-get -y update \
&& apt-get -y upgrade && apt-get -y install ntp software-properties-common \
&& echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections \
&& echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections \
&& add-apt-repository -y ppa:webupd8team/java

RUN apt-get update

# install java
RUN apt-get install -y oracle-java8-installer
RUN apt-get install -y oracle-java8-set-default

RUN apt-get install -y curl

# setup timezone
RUN apt-get install -y tzdata
RUN echo Asia/Seoul | tee /etc/timezone && dpkg-reconfigure --frontend noninteractive tzdata
RUN ln -sf /usr/share/zoneinfo/Asia/Seoul /etc/localtime

ENV JAVA_HOME /usr/lib/jvm/java-8-oracle

## install extra package
RUN apt-get install -y unzip

## remove cache
RUN rm -rf /var/cache/oracle-jdk8-installer && apt-get clean && rm -rf /var/lib/apt/lists/*

# Download and install Activator
RUN mkdir -p /opt/activator-dist-$ACTIVATOR_VERSION
RUN wget --output-document /opt/typesafe-activator-$ACTIVATOR_VERSION.zip http://downloads.typesafe.com/typesafe-activator/$ACTIVATOR_VERSION/typesafe-activator-$ACTIVATOR_VERSION.zip
RUN unzip /opt/typesafe-activator-$ACTIVATOR_VERSION.zip -d /opt
RUN rm -f /opt/typesafe-activator-$ACTIVATOR_VERSION.zip
RUN mv /opt/activator-$ACTIVATOR_VERSION /opt/activator

COPY ./yona /yona/home

## run yona command
WORKDIR /yona/home

ENV PORT 9000
ENV YONA_DATA /yona/data
ENV JAVA_OPTS -Xmx2048m -Xms1024m -Dyona.data=$YONA_DATA -DapplyEvolutions.default=true -Dhttp.port=$PORT
RUN /opt/activator/activator dist
RUN set -x && unzip -d svc target/universal/*.zip && mv svc/*/* svc/ && rm svc/bin/*.bat && mv svc/bin/* svc/bin/start

ADD boot.sh /opt
CMD ["nohup","/opt/boot.sh"]