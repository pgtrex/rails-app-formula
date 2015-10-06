#!/bin/sh

# Start all testing

# Rails Unit Testing
ruby -Itest test/unit/models/subscription_test.rb

# Javascript testing
karma start config/karma.conf.js
