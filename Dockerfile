FROM alpine:latest
ARG BINARY
ARG PROJECT
ENV PROJECT=$PROJECT
RUN apk --no-cache add ca-certificates
WORKDIR /root/
COPY ./$BINARY .
CMD ["sh", "-c", "./${BINARY}"]