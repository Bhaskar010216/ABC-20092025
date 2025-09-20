FROM ubuntu:22.04 AS base
ENV DEBIAN_FRONTEND=noninteractive LC_ALL=C.UTF-8 LANG=C.UTF-8
RUN apt-get update \
 && apt-get install -y --no-install-recommends cron sudo ca-certificates \
 && rm -rf /var/lib/apt/lists/*
RUN useradd -m -s /bin/bash abc \
 && mkdir -p /opt/myapp \
 && chown -R abc:abc /opt/myapp
WORKDIR /opt/myapp

FROM base AS intermediate
COPY myscript.sh /opt/myapp/myscript.sh
COPY start-cron.sh /usr/local/bin/start-cron.sh
RUN chmod +x /opt/myapp/myscript.sh /usr/local/bin/start-cron.sh \
 && touch /var/log/cron.log \
 && chown abc:abc /var/log/cron.log

FROM intermediate AS cleanup
COPY cron_cleanup /etc/cron.d/run_cleanup
RUN chmod 0644 /etc/cron.d/run_cleanup
CMD ["/usr/local/bin/start-cron.sh"]

FROM intermediate AS create
COPY cron_create /etc/cron.d/run_create
RUN chmod 0644 /etc/cron.d/run_create
CMD ["/usr/local/bin/start-cron.sh"]

