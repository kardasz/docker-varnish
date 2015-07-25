FROM debian:jessie
MAINTAINER Krzysztof Kardasz <krzysztof@kardasz.eu>
RUN \
    apt-get update && \
    apt-get -y install apt-transport-https && \
    curl https://repo.varnish-cache.org/GPG-key.txt | apt-key add - && \
    echo "deb https://repo.varnish-cache.org/debian/ wheezy varnish-4.0" >> /etc/apt/sources.list.d/varnish-cache.list && \
    apt-get update && \
    apt-get -y install varnish

CMD ["service varnish restart"]

EXPOSE 80
EXPOSE 6082