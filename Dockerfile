FROM alpine:3.11.0
RUN apk add --no-cache ca-certificates socat

RUN rm -rf /usr/share/terminfo

ENV HOME /tmp

COPY helm /helm
COPY tiller /tiller

EXPOSE 44134
USER nobody
ENTRYPOINT ["/tiller"]
