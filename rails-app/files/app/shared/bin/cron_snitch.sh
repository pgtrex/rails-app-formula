#!/bin/bash

cron_name="cron.${1}"
# email="mario@vejlupek.cz"
email="root@SimplifyEm.com"
timestamp=$(date +\%Y_\%m_\%d)

if [ -n "$2" ]; then
  cron_log_file=$2
else
  cron_log_file="/var/log/${cron_name}/${timestamp}-${cron_name}.log"

  while read log; do
    echo $log >> $cron_log_file
  done
fi

mutt -a $cron_log_file  -s "Cron <root@cl1> run-parts /etc/${cron_name}" -- $email

errors=$( egrep -r "\/var\/www\/.*\.(rake|rb)" $cron_log_file | grep -v Warning )
issues=$( egrep -r "ISSUE" $cron_log_file )

errors=$errors$issues

if [ -n "$errors" ]; then
  echo $errors | mutt -a $cron_log_file -s "Cron Snitch ${1}" -- $email
else
  echo "NO errors reported." | mutt -s "Cron Snitch ${1}" -- $email
fi
