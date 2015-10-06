#!/bin/sh

# Start karma testing

# Prepare mock client data
# rake dev:generate_js_mock[2]
# rake dev:generate_js_mock[3]
# rake dev:generate_js_mock[4]
 rake dev:generate_js_mock[37]

# Javascript testing
karma start config/karma.conf.js
