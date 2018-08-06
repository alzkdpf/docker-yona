#!/bin/bash
if [ ! -f /yona/home/svc/RUNNING_PID ]; then
  rm -f /yona/home/svc/RUNNING_PID
  /yona/home/svc/bin/start
else
  /yona/home/svc/bin/start
fi
