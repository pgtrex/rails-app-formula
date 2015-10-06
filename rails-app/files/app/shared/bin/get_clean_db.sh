#!/bin/bash

database_name="trex_clean"

# Drop previous Database
mysqladmin -f -uroot drop $database_name

# Create Database
mysqladmin -uroot create $database_name

# Import Database
mysql -uroot $database_name < db/Clean.sql

# Switch to clean Database
perl -p -i -e "s/database:.*/database:  ${database_name}/g" config/database.yml

# Run migrations
rake db:migrate

# Build testing user from sratch
rake dev:user_brainwash
