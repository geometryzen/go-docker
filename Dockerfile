# Dockerfile References: https://docs.docker.com/engine/reference/builder/

# Start from golang v1.11 base image
FROM golang:1.11 as builder

# Add Maintainer Info
LABEL maintainer="David Geo Holmes <david.geo.holmes@gmail.com>"

# Set the Current Working Directory inside the container
WORKDIR $GOPATH/src/github.com/geometryzen/go-docker

# Copy everything from the current directory to the PWD(Present Working Directory) inside the container
COPY . .

# Download all the dependencies
# https://stackoverflow.com/questions/28031603/what-do-three-dots-mean-in-go-command-line-invocations
RUN go get -d -v ./...

# Install the package
# RUN go install -v ./...

# Build the Go app targeting Raspberry Pi (arm32v7)
RUN CGO_ENABLED=0 GOOS=linux GOARCH=arm GOARM=7 go build -a -installsuffix cgo -o /go/bin/go-docker .

######## Start a new stage from scratch #######
FROM alpine:latest  

RUN apk --no-cache add ca-certificates

# Build Args
ARG APP_NAME=go-docker
ARG LOG_DIR=/${APP_NAME}/logs

# Create Log Directory
RUN mkdir -p ${LOG_DIR}

# Environment Variables
ENV LOG_FILE_LOCATION=${LOG_DIR}/app.log

WORKDIR /root/

# Copy the Pre-built binary file from the previous stage
COPY --from=builder /go/bin/go-docker .

# This container exposes port 8080 to the outside world
EXPOSE 8080

# Declare volumes to mount
VOLUME ["./go-docker/logs"]

# Run the executable
CMD ["./go-docker"]
