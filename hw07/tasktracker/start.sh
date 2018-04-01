#!/bin/bash

export PORT=5111

cd ~/www/tasktracker
./bin/tasktracker stop || true
./bin/tasktracker start

