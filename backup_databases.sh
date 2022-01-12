#!/bin/bash

USER="dima_user"         #USER для базы нанных MySQL 
PASSWORD="1234"  #PASSWORD для базы нанных MySQL
OUTPUT="/home/vagrant/backup"    #директория для хранения резервных копий 
#/*/*/backup/daily/   директория backup записей за денелю 
#/*/*/backup/monthly/ директория backup записей за месяц 
#/*/*/backup/weekly/  директория backup записей за год
WEEK="Wednesday" #день недели дня еженедельного копированияя
WDATE="12"      #дата для ежемесячного копирования
DBACKUP="2"     #колическтво backup записей за денелю
MBACKUP="2"     #количество backup записей за месяц
WBACKUP="2"     #количество backup записей за год


mkdir -p "$OUTPUT/daily"
mkdir -p "$OUTPUT/monthly"
mkdir -p "$OUTPUT/weekly"

DIRdaily="$OUTPUT/daily/$(date +%Y.%m.%d)"
DIRmonthly="$OUTPUT/monthly/$(date +%Y.%m.%d)"
DIRweekly="$OUTPUT/weekly/$(date +%Y.%m.%d)"

my_function () {
mysqldump -u$USER -p$PASSWORD --databases "$db" >>  "$1"/"$db".sql
gzip "$1"/"$db".sql
}

databases=$(mysql -u$USER -p$PASSWORD -e "SHOW DATABASES;" | tr -d "| " | grep -v Database)

for db in $databases; do
    if [[ "$db" != "information_schema" ]] && [[ "$db" != "sys" ]] && [[ "$db" != "performance_schema" ]] ; then
            if [[ $(date +%A) == "$WEEK" ]] && [[ $(date +%d) == "$WDATE" ]]; then
               echo "Dumping database DIR: daily, monthly and weekly -$db"
               mkdir -p "$DIRdaily"
               my_function "$DIRdaily"
               mkdir -p "$DIRmonthly"
               cp "$DIRdaily"/* "$DIRmonthly"/*
               mkdir -p "$DIRweekly"
               cp "$DIRdaily"/* "$DIRweekly"/*
            elif [[ $(date +%A) == "$WEEK" ]] ; then
               echo "Dumping database DIR: daily and monthly -$db"    
               mkdir -p "$DIRdaily"
               my_function "$DIRdaily"
               mkdir -p "$DIRmonthly"
               cp "$DIRdaily"/* "$DIRmonthly"/*
            elif [[ $(date +%d) == "$WDATE" ]] ; then
               echo "Dumping database DIR: daily and weekly -$db"
               mkdir -p "$DIRdaily"
               my_function "$DIRdaily"
               mkdir -p "$DIRweekly"
               cp "$DIRdaily"/* "$DIRweekly"/*
            else
               echo "Dumping database DIR: daily -$db"
               mkdir -p "$DIRdaily"
               my_function "$DIRdaily"
            fi
    fi
done

function1 () {
find "$DIR" -maxdepth 1 -type f -printf '%p\n' | sort -n | head -n -"$1" | xargs rm -rf
}

find "$OUTPUT" -maxdepth 1 -type d | sed 1d | while read -r ALLDIR
do
    for DIR in $ALLDIR; do
       if   [[ "$DIR" == "$OUTPUT/daily" ]] ; then
            function1 "$DBACKUP"
       elif [[ "$DIR" == "$OUTPUT/monthly" ]] ; then
            function1 "$MBACKUP"
       else
            function1 "$WBACKUP"
       fi
    done
done

