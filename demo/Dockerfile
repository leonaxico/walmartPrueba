# we will use openjdk 8 with alpine as it is a very small linux distro
FROM openjdk:8-jre-alpine3.9

# copy the packaged jar file into our docker image
COPY target/demo-0.0.1-SNAPSHOT.jar /demo.jar
ARG TIMEZONE="America/Mexico_City"

# Set timezone
RUN apk add tzdata
RUN cp /usr/share/zoneinfo/${TIMEZONE} /etc/localtime
RUN "date"
# set the startup command to execute the jar
CMD ["java", "-jar", "/demo.jar"]
