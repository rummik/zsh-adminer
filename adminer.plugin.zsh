#!/bin/zsh
ZSH_ADMINER=${0:h}

function adminer {
	emulate -L zsh
	local php
	local port=$((9100 + (RANDOM % 100)))
	local pwd=$(pwd)
	cd $ZSH_ADMINER

	(php5 -S localhost:$port 2>&1 >/dev/null & print $!) > /tmp/php.$$.pid
	php=$(</tmp/php.$$.pid)
	rm /tmp/php.$$.pid

	sleep 1

	HOME=$ZSH_ADMINER links2 -aggressive-cache 0 -format-cache-size 0 http://localhost:$port

	(kill -9 $php 2>&1) >/dev/null
	cd $pwd
}
