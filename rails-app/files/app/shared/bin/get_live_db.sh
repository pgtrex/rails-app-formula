#!/bin/bash

# !!!You have to install and setup s3cmd first!!!
# http://s3tools.org

# Download database and run migrations

# Without arguments you will get today db
# With argument you can controll for which date you want to download db
## e.g. 2013.01.10

if [ "$#" == 0 ]
then
  selected_date=$(date +%Y.%m.%d);
else
  selected_date=$1
fi

echo "Removing previously downladed backup"
rm -rf sfym_database

echo "Downloading backup data for ${selected_date}"
timestamp="${selected_date}*"
database_name="trex_production_$(echo ${selected_date} | sed 's/\.//g')"

s3cmd get --skip-existing "s3://sfym-live-trexglobal/DatabaseBackups/sfym_database/${timestamp}/sfym_database.tar"

selected_backup=$(ls -dt ${timestamp} | head -1)

echo "There were two backups, selecting ${selected_backup}"

echo "Unpacking backup data"
tar -xvf "${selected_backup}/sfym_database.tar"

echo "Creating database"
mysqladmin -uroot -f drop $database_name
mysqladmin -uroot create $database_name

echo "Loading data into database"
cat sfym_database/databases/MySQL.sql.gz | gzip -d | mysql -uroot $database_name

rm -rf sfym_database

echo "Done"
