FROM alpine:latest as builder

ENV HUGO_VERSION 0.54.0

RUN apk add --no-cache openssl py-pygments curl \
    && mkdir hugo \
    && cd hugo

COPY . /hugo

RUN curl -L https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_${HUGO_VERSION}_Linux-64bit.tar.gz | tar -xz \
    && ./hugo

FROM nginx:alpine
COPY --from=builder /hugo/public /usr/share/nginx/html
