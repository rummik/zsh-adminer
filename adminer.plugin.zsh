#!/bin/zsh
if [[ ! -e ~/.zsh-adminer ]]; then
	ln -s ${0:h} ~/.zsh-adminer
fi

function adminer {
	emulate -L zsh
	local php
	local port=$((9100 + (RANDOM % 100)))
	local pwd=$(pwd)
	cd ~/.zsh-adminer

	(php5 -S localhost:$port 2>&1 >/dev/null & print $!) > /tmp/php.$$.pid
	php=$(</tmp/php.$$.pid)
	rm /tmp/php.$$.pid

	sleep 1

	HOME=~/.zsh-adminer links2 -aggressive-cache 0 -format-cache-size 0 http://localhost:$port

	(kill -9 $php 2>&1) >/dev/null
	cd $pwd
}
