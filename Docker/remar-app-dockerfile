FROM openweb/oracle-tomcat

RUN curl -sL https://deb.nodesource.com/setup_6.x | bash -

RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927
RUN echo "deb http://repo.mongodb.org/apt/ubuntu trusty/mongodb-org/3.2 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-3.2.list

RUN apt-get install -y software-properties-common \
                       python

RUN apt-get update && apt-get install -y --allow-unauthenticated \
            ant \
            curl \
            nano \
            nodejs \
            telnet \
            vim \
            wget \
            zip \
            mongodb-org-shell \
            mysql-client \
            imagemagick \
            ruby-full \
            rubygems \
            build-essential

RUN gem install sass
RUN add-apt-repository -y ppa:webupd8team/java
RUN add-apt-repository -y ppa:ricotz/unstable && dpkg --add-architecture i386 && apt-get update
RUN echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 select true" | debconf-set-selections && apt-get install -y oracle-java8-installer
RUN apt-get -y install wine-stable wine32

RUN npm install --global electron-packager

RUN mkdir /usr/lib/grails
WORKDIR /usr/lib/grails
RUN wget http://dist.springframework.org.s3.amazonaws.com/release/GRAILS/grails-2.4.5.zip
RUN unzip grails-2.4.5.zip && rm grails-2.4.5.zip

ENV GRAILS_HOME /usr/lib/grails/grails-2.4.5/
ENV JRE_HOME /usr/lib/jvm/java-8-oracle
ENV PATH $PATH:$GRAILS_HOME/bin

WORKDIR /dev-tools
RUN wget https://dl.google.com/android/android-sdk_r24.4.1-linux.tgz && \
    tar -zxvf android-sdk_r24.4.1-linux.tgz && \
    mv android-sdk-linux/ android && rm android-sdk_r24.4.1-linux.tgz && \
    (echo y | android/tools/android update sdk --all --no-ui --filter tools) && \
    (echo y | android/tools/android update sdk --all --no-ui --filter platform-tools) && \
    (echo y | android/tools/android update sdk --all --no-ui --filter build-tools-25.0.2,android-22)
WORKDIR android/build-tools
RUN ln -s 25.0.2 current

WORKDIR /dev-tools
RUN wget https://download.01.org/crosswalk/releases/crosswalk/android/stable/12.41.296.9/crosswalk-12.41.296.9.zip && \
    unzip crosswalk-12.41.296.9.zip && \
    mv crosswalk-12.41.296.9 crosswalk && rm crosswalk-12.41.296.9.zip && \
    chmod +x crosswalk/make_apk.py

RUN chown $(whoami) /dev-tools /usr/local/tomcat

WORKDIR /

COPY ./tomcat-users.xml /usr/local/tomcat/conf/tomcat-users.xml
COPY ./entrypoint_remar.sh /
RUN chmod +x entrypoint_remar.sh
ENTRYPOINT ["./entrypoint_remar.sh"]
CMD ["catalina.sh", "run"]
