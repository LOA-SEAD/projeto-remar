FROM isuper/java-oracle:jre_8

RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927
RUN echo "deb http://repo.mongodb.org/apt/ubuntu trusty/mongodb-org/3.2 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-3.2.list
RUN curl -sL https://deb.nodesource.com/setup_6.x | bash -
RUN apt-get update && apt-get install -y \
			ant \
			curl \
			git \
			nano \  
			nodejs \
			telnet \
			vim \
			wget \
			zip

RUN npm install --global electron-packager

RUN mkdir /usr/lib/grails
WORKDIR /usr/lib/grails
RUN wget http://dist.springframework.org.s3.amazonaws.com/release/GRAILS/grails-2.4.5.zip
RUN unzip grails-2.4.5.zip && rm grails-2.4.5.zip
ENV GRAILS_HOME /usr/lib/grails/grails-2.3.8/
ENV PATH $PATH:$GRAILS_HOME/bin
