# go-docker

GoLang Docker + Raspberry Pi

```
docker build -t go-docker .
```

```
mkdir ~/app-logs
docker run -d -p 8080:8080 -v ~/app-logs:/go-docker/logs go-docker
```

```
docker container ls
```

```
 curl http://localhost:8080?name=David
```

```
cd ~/app-logs
tail -200f app.log
```

```
docker container stop <CONTAINER ID>
```