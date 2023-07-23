 FROM alpine:edge
LABEL Maintainer="Chris c <chris@cchalifo.xyz>"
LABEL Description="Alpine Linux edge, BasImage"

RUN apk add --no-cache --update --verbose nfs-utils bash iproute2 && \
    rm -rf /var/cache/apk /tmp /sbin/halt /sbin/poweroff /sbin/reboot && \
    mkdir -p /var/lib/nfs/rpc_pipefs /var/lib/nfs/v4recovery && \
    echo "rpc_pipefs    /var/lib/nfs/rpc_pipefs rpc_pipefs      defaults        0       0" >> /etc/fstab && \
    echo "nfsd  /proc/fs/nfsd   nfsd    defaults        0       0" >> /etc/fstab

COPY etc/exports /etc/
COPY bin/nfsd.sh /usr/bin/nfsd.sh
COPY root/.bashrc /root/.bashrc

RUN chmod +x /usr/bin/nfsd.sh

ENTRYPOINT ["/usr/bin/nfsd.sh"]
