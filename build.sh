#!/bin/bash

PROJECT=$(pwd |awk '{n=split($1,A,"/"); print A[n]}')

BINARY_AMD = "$PROJECT-amd64"
# BINARY_RPI = "$PROJECT-arm32v7"

echo "Building $BINARY_AMD"

rm "$BINARY_AMD"
# rm "$PROJECT-arm32v7.*"

env GOOS=linux GOARCH=amd64      go build -o "$BINARY_AMD"
# env GOOS=linux GOARCH=arm GARM=7 go build -o "$PROJECT-arm32v7"

docker build -t "amd64/$PROJECT:latest" -f Dockerfile . --build-arg BIANRY=$BINARY --build-arg PROJECT=$PROJECT
# docker build -t "arm32v7/$PROJECT:latest" -f Dockerfile . --build-arg PROJECT=$PROJECT
