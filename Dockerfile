FROM alpine:latest as builder

ENV HUGO_VERSION 0.54.0

COPY . /hugo

RUN apk add --no-cache openssl py-pygments curl git \
    && git clone https://github.com/panr/hugo-theme-terminal.git themes/terminal \
    && cd /hugo \
    && curl -L https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_${HUGO_VERSION}_Linux-64bit.tar.gz | tar -xz \
    && ./hugo

FROM nginx:alpine
COPY --from=builder /hugo/public /usr/share/nginx/html
