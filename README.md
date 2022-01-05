# Backup mysql databeses to time 

скрипт предназначен для резурвного копирования баз данных MySQL-сервера

# Копирование производится: 
# - по дате и времении, согластно cron-записей
# - в дерикторию согласно записи скрипта
# - каждой базы отдельно в gzip файлы


# Для реализации скритна необходимо:
# 1. username и userpassword для MySQL-сервера
# 2. директория место расположение backup-file  
# 3. классический демон Cron

# Установка и наладка
# Клонируем репозиторий "git clone git@github.com:dkent0890/mysql-backup.git"

# Вносим изменения в файл backup_databases.sh:
# - USER="username" - указывая username MySQL
# - PASSWORD="password" - указывая password MySQL
# - OUTPUT="/usr/home/backup" - указывая дерикторию для backup-databases MySQL

# Создаем дерикторию /usr/home/backup для backup-file 

# Настроиваем Cron
# Согласно следующей команды "crontab -e" производим настройка файла crontab
# MAILTO=”usermail”
# SHELL=/bin/bash
# HOME=/

# * 6 * * * /home/vagrant/backup_databases.sh 

# Где usermail - электронная почта получателя, о работе скрипта
# * 6 * * *  - время и дата запуска скрипта (каждый день в 6:00)
#/home/vagrant/backup_databases.sh - путь к скприпту

  
