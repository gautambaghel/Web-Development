#!/bin/bash

export PORT=5100
export MIX_ENV=prod
export GIT_PATH=/home/tasktraker/src/tasktraker 

PWD=`pwd`
if [ $PWD != $GIT_PATH ]; then
	echo "Error: Must check out git repo to $GIT_PATH"
	echo "  Current directory is $PWD"
	exit 1
fi

if [ $USER != "tasktraker" ]; then
	echo "Error: must run as user 'tasktraker'"
	echo "  Current user is $USER"
	exit 2
fi

mix deps.get
(cd assets && npm install)
(cd assets && ./node_modules/brunch/bin/brunch b -p)
mix phx.digest
mix release --env=prod

mkdir -p ~/www
mkdir -p ~/old

NOW=`date +%s`
if [ -d ~/www/tasktraker ]; then
	echo mv ~/www/tasktraker ~/old/$NOW
	mv ~/www/tasktraker ~/old/$NOW
fi

mkdir -p ~/www/tasktraker
REL_TAR=~/src/tasktraker/_build/prod/rel/tasktraker/releases/0.0.1/tasktraker.tar.gz
(cd ~/www/tasktraker && tar xzvf $REL_TAR)

crontab - <<CRONTAB
@reboot bash /home/tasktraker/src/tasktraker/start.sh
CRONTAB

#. start.sh
