FROM alpine

RUN adduser -D helm
RUN apk add --no-cache python3 curl libc6-compat

# Installing gcloud
RUN curl https://dl.google.com/dl/cloudsdk/release/google-cloud-sdk.tar.gz > /tmp/gcloud
RUN mkdir -p /usr/local/share/gcloud \
  && tar -C /usr/local/share/gcloud -zxf /tmp/gcloud \
  && /usr/local/share/gcloud/google-cloud-sdk/install.sh \
    --additional-components kubectl gke-gcloud-auth-plugin \
    --quiet
ENV PATH $PATH:/usr/local/share/gcloud/google-cloud-sdk/bin

# Installing latest helmv2
ARG ARCH=x86_64
RUN curl -L https://get.helm.sh/helm-v2.17.0-linux-$ARCH.tar.gz -o /tmp/helm
RUN mkdir -p /usr/local/share/helm \
  && tar -C /usr/local/share/helm -zxf /tmp/helm
ENV PATH $PATH:/usr/local/share/helm/linux-$ARCH

RUN rm /tmp/*
USER helm
WORKDIR /home/helm

ENTRYPOINT [ "helm" ]
