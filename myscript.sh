#!/bin/bash
set -e
INPUT="$1"
TIMESTAMP=$(date -Is)
LOGFILE="/opt/myapp/output.log"
touch "$LOGFILE"
chown abc:abc "$LOGFILE" || true
if [ "$INPUT" = "1" ]; then
  echo "$TIMESTAMP: CREATE action (input=1)" | tee -a "$LOGFILE"
  mkdir -p /opt/myapp/data
  echo "created at $TIMESTAMP" > /opt/myapp/data/created_file.txt
  chown -R abc:abc /opt/myapp/data
elif [ "$INPUT" = "©" ]; then
  echo "$TIMESTAMP: CLEANUP action (input=©)" | tee -a "$LOGFILE"
  rm -rf /opt/myapp/data
else
  echo "$TIMESTAMP: UNKNOWN input ($INPUT)" | tee -a "$LOGFILE"
fi

