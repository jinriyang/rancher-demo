FROM docker.io/openjdk:8-jdk-alpine
MAINTAINER jin jinry@jfrog.com
ADD *.jar app.jar
RUN bash -c 'touch /app.jar'
ENV JAVA_OPTS=""
ENTRYPOINT [ "sh", "-c", "java $JAVA_OPTS -Djava.security.egd=file:/dev/./urandom -jar /app.jar" ]