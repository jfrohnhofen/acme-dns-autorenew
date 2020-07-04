#!/bin/sh
/root/run-lego run
/usr/sbin/crond -f -l 8
