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
$ docker run --rm -it -v $HOME/.kube:/home/helm/.kube helm2
# Its recommended to use command as an alias
```

## Running with K8S cluster in a cloud provider
If you need to run with a GKE cluster by example, you must add a volume linked with your personal configuration due authorization purpose.

```sh
$ docker run --rm -it \
    -v $HOME/.config/gcloud:/home/helm/.config/gcloud \
    -v $HOME/.kube:/home/helm/.kube \
    helm2
```