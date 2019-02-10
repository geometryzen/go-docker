# go-docker

GoLang Docker + Raspberry Pi

```
docker build -t go-docker .
```

```
docker run -d -p 8080:8080 go-docker
```

```
docker container ls
```

```
 curl http://localhost:8080?name=David
```

```
docker container stop <CONTAINER ID>
```