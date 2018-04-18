FROM docker-release-local2.demo.jfrogchina.com/docker-framework:latest

MAINTAINER Liu jinry@jfrog.com

ADD *.jar /home/wchat-demo.jar

RUN java -jar /home/wchat-demo.jar
