FROM arm32v6/alpine:latest

LABEL MAINTAINER="Andrew Miskell <andrewmiskell@mac.com>" \
    Description="Samba docker container, based on Alpine Linux. Can be paired with Avahi for Time Machine"

# copy qemu-arm-static to /usr/bin to allow automated builds for arm on docker-hub    
COPY dockerfile/armhf/qemu-arm-static /usr/bin

# upgrade base system and install samba and supervisord
RUN apk --no-cache upgrade && apk --no-cache add samba samba-common-tools supervisor

# create a directory for the shares volumes to live
RUN mkdir /shares

# copy supervisord configuration file into place
COPY supervisord.conf /etc/supervisord.conf

# exposes samba's default ports (137, 138 for nmbd and 139, 445 for smbd)
EXPOSE 137/udp 138/udp 139 445

ENTRYPOINT ["supervisord", "-c", "/etc/supervisord.conf"]
