# Helm2 Docker Image

## Build

```sh
# Build with Docker
$ docker build -t helm2 -f Dockerfile .
# or use make
$ make build
```

## Running
```sh
# Run through Docker
$ docker run --rm -it -v $HOME/.kube:/home/shell/.kube helm2
# Its recommended to use command as an alias
```