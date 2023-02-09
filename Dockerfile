FROM portainer/kubectl-shell
RUN curl -L https://get.helm.sh/helm-v2.17.0-linux-arm64.tar.gz -o /tmp/helm
RUN tar zxf /tmp/helm && rm /tmp/helm
ENTRYPOINT [ "/home/shell/linux-arm64/helm" ]
