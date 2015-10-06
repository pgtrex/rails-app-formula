#!/bin/sh

rvm use ruby-1.9.3-p194@mailcatcher

mailcatcher

rvm use ruby-1.8.6-head@rails123

starling -P tmp/starling.pid -L tmp/starling.log &

/usr/local/bin/mailer start
