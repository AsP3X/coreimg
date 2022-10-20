FROM alpine:3.7
LABEL org.opencontainers.image.authors=AsP3X
LABEL org.opencontainers.image.source=*
LABEL org.opencontainers.image.licenses=MIT
LABEL org.opencontainers.image.title=CoreImage
LABEL org.opencontainers.image.description=CoreImage
LABEL org.opencontainers.image.url=*

RUN mkdir /tmp/coreimage

COPY motd.txt /tmp/coreimage/motd.txt

RUN cat /tmp/coreimage/motd.txt > /etc/motd
RUN echo "[ ! -z \"$TERM\" -a -r /etc/motd ] && cat /etc/issue && cat /etc/motd" >> /etc/bash.bashrc

# Update
RUN apk update && apk upgrade

# Install packages
RUN apk add --no-cache \
    bash \
    curl \
    git \
    jq \
    nano \
    rsync \
    tar \
    unzip \
    wget \
    zip

# Install tzdata and autoconfigure timezone
RUN apk add --no-cache tzdata && \
    cp /usr/share/zoneinfo/Europe/Berlin /etc/localtime && \
    echo "Europe/Berlin" > /etc/timezone && \
    apk del tzdata

# Set default shell to bash
RUN rm /bin/sh && ln -s /bin/bash /bin/sh