FROM alpine:3.11.0
RUN apk --no-cache add samba cifs-utils bash

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh

EXPOSE 139 445
VOLUME /mnt

ENTRYPOINT ["/usr/bin/entrypoint.sh"]

