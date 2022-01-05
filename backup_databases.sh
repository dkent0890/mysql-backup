#!/bin/bash

USER="username"
PASSWORD="password"
OUTPUT="/usr/home/backup" #директория для хранения резервных копий
 
databases=`mysql --user=$USER --password=$PASSWORD -e "SHOW DATABASES;" | tr -d "| " | grep -v Database`
 
for db in $databases; do
    if [[ "$db" != "information_schema" ]] && [[ "$db" != "sys" ]] && [[ "$db" != "performance_schema" ]] ; then
        echo "Dumping database: $db"
        mysqldump --user=$USER --password=$PASSWORD --databases $db > $OUTPUT/date +%Y%m%d.$db.sql
        gzip $OUTPUT/date +%Y%m%d.$db.sql
    fi
done
