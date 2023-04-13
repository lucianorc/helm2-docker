# syntax=docker/dockerfile:1.4
FROM alpine as base

ARG ARCH=arm64
COPY scripts/usr/share/entrypoint.sh /usr/share/entrypoint.sh
RUN <<EOL
  set -e
  apk add --no-cache curl libc6-compat openssl

  mkdir -p /usr/local/share/helm
  curl -Ls https://get.helm.sh/helm-v2.17.0-linux-$ARCH.tar.gz | tar zxC /usr/local/share/helm
  set +e
EOL
ENV PATH $PATH:/usr/local/share/helm/linux-$ARCH

USER root
WORKDIR /root
ENTRYPOINT [ "/usr/share/entrypoint.sh" ]


FROM base AS gcp

RUN <<EOL
  set -e
  apk add --no-cache python3

  mkdir -p /usr/local/share/gcloud
  curl https://dl.google.com/dl/cloudsdk/release/google-cloud-sdk.tar.gz | \
    tar zx -C /usr/local/share/gcloud
  /usr/local/share/gcloud/google-cloud-sdk/install.sh \
    --additional-components kubectl gke-gcloud-auth-plugin \
    --quiet

  echo "export PATH=$PATH:/usr/local/share/gcloud/google-cloud-sdk/bin" > /etc/profile.d/gcp.sh
  set +e
EOL
ENV PATH=$PATH:/usr/local/share/gcloud/google-cloud-sdk/bin