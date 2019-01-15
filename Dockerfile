FROM alpine:latest

LABEL MAINTAINER="Andrew Miskell <andrewmiskell@mac.com>" \
    Description="Samba docker container, based on Alpine Linux. Can be paired with Avahi for Time Machine"

# upgrade base system and install samba and supervisord
RUN apk --no-cache upgrade && apk --no-cache add samba samba-common-tools supervisor

# create a directory for the configuration directory
RUN mkdir /config

# create a directory for the shares volumes to live
RUN mkdir /shares

# copy supervisord configuration file into place
COPY supervisord.conf /etc/supervisord.conf

# add a non-root user and group called "rio" with no password, no home dir, no shell, and gid/uid set to 1000
#RUN addgroup -g 1000 rio && adduser -D -H -G rio -s /bin/false -u 1000 rio

# create a samba user matching our user from above with a very simple password ("letsdance")
#RUN echo -e "letsdance\nletsdance" | smbpasswd -a -s -c /config/smb.conf rio

# exposes samba's default ports (137, 138 for nmbd and 139, 445 for smbd)
EXPOSE 137/udp 138/udp 139 445

ENTRYPOINT ["supervisord", "-c", "/etc/supervisord.conf"]
