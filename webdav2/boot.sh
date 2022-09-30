#!/bin/bash
  
# Start the first process
env > /etc/.cronenv
rm /etc/cron.d/dockercron
ln -s /etc/contanercron/dockercron /etc/cron.d/dockercron
service cron start &
status=$?
if [ $status -ne 0 ]; then
  echo "Failed to start cron: $status"
  exit $status
fi

# Start the second process
service apache2 start &
status=$?
if [ $status -ne 0 ]; then
  echo "Failed to start apache2: $status"
  exit $status
fi
bash
