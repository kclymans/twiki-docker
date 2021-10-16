# syntax=docker/dockerfile:1
FROM ubuntu:20.04



RUN export DEBIAN_FRONTEND=noninteractive && apt-get update \
    && apt-get -y install \
    apache2 \
    rcs \
    diffutils \
    zip \
    cron \
    make \
    gcc \
    g++ \
    pkg-config \
    libssl-dev \
&& rm -rf /var/lib/apt/lists/*

COPY TWiki-6.1.0.zip ./TWiki-6.1.0.zip
RUN mkdir -p /var/www/twiki && unzip TWiki-6.1.0.zip -d /var/www/twiki && rm TWiki-6.1.0.zip

COPY perl/cpanfile /tmp/cpanfile
ADD https://fastapi.metacpan.org/source/THALJEF/Pinto-0.09995/etc/cpanm /tmp/cpanm

RUN chmod +x /tmp/cpanm && /tmp/cpanm -l /var/www/twiki/lib/CPAN --installdeps /tmp/ && rm -rf /.cpanm /tmp/cpanm /tmp/cpanfile /var/www/twiki/lib/CPAN/man

COPY configs/vhost.conf /etc/apache2/sites-available/twiki.conf
COPY configs/LocalLib.cfg  /var/www/twiki/bin/LocalLib.cfg
COPY configs/LocalSite.cfg /var/www/twiki/lib/LocalSite.cfg
COPY configs/setlib.cfg /var/www/twiki/bin/setlib.cfg
COPY bin/prepare-env.sh /prepare-env.sh
COPY bin/run.sh /run.sh
RUN a2enmod cgi expires && a2dissite '*' && a2ensite twiki.conf && chown -cR www-data: /var/www/twiki && chmod +x /prepare-env.sh

VOLUME ["/data"]
ENTRYPOINT ["sh","/run.sh"]

EXPOSE 80