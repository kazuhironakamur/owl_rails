#!/bin/sh
PROJECT_HOME=/home/rails/owl_rails
PUMA_PID=`cat $PROJECT_HOME/tmp/pids/puma.pid`

/home/rails/owl_rails/script/stop_puma.sh

git pull
rails db:migrate
rails assets:precompile

/home/rails/owl_rails/script/start_puma.sh
