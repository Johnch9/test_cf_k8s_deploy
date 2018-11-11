FROM hashicorp/terraform:latest

RUN apk add --update git bash

WORKDIR /app

COPY ./terraform ./terraform

COPY ./scripts ./scripts

ENTRYPOINT "/bin/bash"