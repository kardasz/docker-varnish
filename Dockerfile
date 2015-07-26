FROM debian:jessie
MAINTAINER Krzysztof Kardasz <krzysztof@kardasz.eu>

ENV DEBIAN_FRONTEND noninteractive

RUN \
    apt-get update && \
    apt-get -y upgrade && \
    apt-get -y dist-upgrade && \
    apt-get -y install apt-transport-https curl && \
    curl https://repo.varnish-cache.org/GPG-key.txt | apt-key add - && \
    echo "deb https://repo.varnish-cache.org/debian/ jessie varnish-4.0" >> /etc/apt/sources.list.d/varnish-cache.list && \
    apt-get update && \
    apt-get -y install varnish

EXPOSE 80 6082

CMD ["/usr/sbin/varnishd", "-F", "-a", "0.0.0.0:80", "-T", "0.0.0.0:6082", "-f", "/etc/varnish/default.vcl", "-s", "malloc,256m"]