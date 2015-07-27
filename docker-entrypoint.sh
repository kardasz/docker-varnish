#!/bin/bash

set -e

# Add varnishd as command if needed
if [ "${1:0:1}" = '-' ]; then
	set -- varnishd "$@"
fi

exec "$@"