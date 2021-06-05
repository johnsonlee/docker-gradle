FROM johnsonlee/java15:latest

MAINTAINER Johnson g.johnsonlee@gmail.com

ADD ./gradle      /opt/gradle
ADD ./gradlew     /opt/gradlew
ADD ./gradlew.bat /opt/gradlew.bat

RUN cd /opt && ./gradlew --no-daemon --no-build-cache

