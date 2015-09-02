FROM debian:jessie
MAINTAINER Krzysztof Kardasz <krzysztof@kardasz.eu>

ENV DEBIAN_FRONTEND noninteractive

ENV OWNER_USER            varnish
ENV OWNER_USER_UID        2000
ENV OWNER_GROUP           varnish
ENV OWNER_GROUP_GID       2000

ENV VARNISH_MALLOC        1G

RUN \
    groupadd --gid ${OWNER_GROUP_GID} -r ${OWNER_GROUP} && \
    useradd -r --uid ${OWNER_USER_UID} -g ${OWNER_GROUP} ${OWNER_USER}
    
RUN \
    apt-get update && \
    apt-get -y upgrade && \
    apt-get -y dist-upgrade && \
    apt-get -y install apt-transport-https curl

RUN \
    curl https://repo.varnish-cache.org/GPG-key.txt | apt-key add - && \
    echo "deb https://repo.varnish-cache.org/debian/ jessie varnish-4.0" >> /etc/apt/sources.list.d/varnish-cache.list && \
    apt-get update && \
    apt-get -y install varnish

COPY docker-entrypoint.sh /

ENTRYPOINT ["/docker-entrypoint.sh"]

EXPOSE 80 6082

CMD ["varnishd", "-F", "-a", ":80", "-T", ":6082", "-f", "/etc/varnish/default.vcl", "-s", "malloc,${VARNISH_MALLOC}"]