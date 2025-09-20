#!/bin/bash
set -e
chmod 0644 /etc/cron.d/* || true
touch /var/log/cron.log
chown abc:abc /var/log/cron.log || true
cron
tail -F /var/log/cron.log

