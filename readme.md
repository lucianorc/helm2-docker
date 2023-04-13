# Helm2 Docker Image

## Build

```sh
# Build only helm with Docker
$ docker build -t helm2 -f Dockerfile --target base .
# or use make
$ make build
# You also can select a cloud provider as target
$ docker build -t helm2 -f Dockerfile --target gcp .
# or use make
$ make gcp
```

## Running

```sh
# Run through Docker
$ docker run --rm -it -v $HOME/.kube:/root/.kube helm2
# Its recommended to use command as an alias
```

Running without parameters will open the shell in interactive mode for degub purpose. With you need help with something helm related, add the argument `help` at the end of command.

## Running with K8S cluster in a cloud provider

If you need to run with a GKE cluster by example, you must add a volume linked with your personal configuration due authorization purpose.

```sh
$ docker run --rm -it \
    -v $HOME/.config/gcloud:/root/.config/gcloud \
    -v $HOME/.kube:/root/.kube \
    helm2
```

## Troubleshooting

### Authentication command error

The GKE Auth plugin at the container possibly will not have in the same path as the host:

```sh
$ helm version
Client: &version.Version{SemVer:"v2.17.0", GitCommit:"a690bad98af45b015bd3da1a41f6218b1a451dbe", GitTreeState:"clean"}
Error: Get "https://35.199.81.11/api/v1/namespaces/kube-system/pods?labelSelector=app%3Dhelm%2Cname%3Dtiller": getting credentials: exec: fork/exec /opt/google-cloud-sdk/bin/gke-gcloud-auth-plugin: no such file or directory
```

But `helm` and `kubectl` uses the enviroment PATH to run the command for authentication.Try changing the command for only the name of the executable in your `$HOME/.kube/config` or any kube config file you have to use. E.g.:

> From `/opt/google-cloud-sdk/bin/gke-gcloud-auth-plugin` to `gke-gcloud-auth-plugin`
