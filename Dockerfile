FROM phusion/baseimage

ENV HOME /root

RUN /etc/my_init.d/00_regen_ssh_host_keys.sh

CMD ["/sbin/my_init"]


RUN apt-get update
RUN apt-get install -y wget curl

# Install Java
RUN add-apt-repository -y ppa:webupd8team/java
RUN apt-get update
RUN echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections
RUN echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections
RUN apt-get install -y oracle-java7-installer

# Install youtrack
WORKDIR /home/youtrack
RUN wget -nv http://download.jetbrains.com/charisma/youtrack-5.2.2-8792.jar -O /youtrack.jar

VOLUME ["/var/lib/youtrack"]

EXPOSE 8080

ADD service /etc/service

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


