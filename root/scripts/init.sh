#!/bin/sh
set -e
if [ -n ${TZ} ]; then
	echo "[Init] Setting localtime to ${TZ}"
	#echo "${TZ}" > /etc/timezone
	#ln -f /usr/share/zoneinfo/"${TZ}" /etc/localtime
fi
if [ -f /config/.config-lock ]; then
	echo "[Init] Removing old .config-log"
	rm -f /config/.config-lock
fi
if [ -f /config/config.yml ]; then
	echo "[Init] Loading existing config"
else
	echo "[Init] Copying new config.yml"
	cp /opt/flexget/config.yml /config/config.yml
fi
exec flexget -c /config/config.yml --loglevel "${FLEXGET_LOGLEVEL}" daemon start
