#!/bin/bash

export PORT=5100

cd ~/www/tasktraker
./bin/tasktraker stop || true
./bin/tasktraker start

