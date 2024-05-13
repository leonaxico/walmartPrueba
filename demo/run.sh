#!/bin/sh
mvn package -DskipTests
docker build ./ -t demoWalmart
docker-compose up