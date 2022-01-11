### Backup mysql databeses to time. 

#### Скрипт предназначен для резервного копирования баз данных MySQL-сервера
#### согластно расписания, с хренением необходиммого кол-ва backup-file  

#### Выполнения скритна:

Клонируем репозиторий "git clone git@github.com:dkent0890/mysql-backup.git"

Вносим изменения в файл backup_databases.sh:

1. данные MySQL-сервера
     #USER="username"\
     #PASSWORD="my_password"\
2. директория для хранения backup-file\
     #OUTPUT="/*/*/backup"
3. день недели дня еженедельного и дата для ежемесячного ханения\
     #WEEK="Saturday"\
     #WDATE="**"
4. необходимое кол-во последних backup записей за денелю, месяц, год\
     #DBACKUP="*"\
     #MBACKUP="*"\
     #WBACKUP="*"
5. настройка Cron
   Согласно следующей команды "crontab -e" производим настройка файла crontab\
      #MAILTO=”usermail”\
      #SHELL=/bin/bash\
      #HOME=/

       * 6 * * *   /*/*/backup_databases.sh
             usermail - электронная почта получателя, о работе скрипта
             * 6 * * *  - время запуска скрипта (каждый день в 6:00)
             /*/*/backup_databases.sh - путь к скприпту

#### Вывод данных реализации скрипта:
1. каждая databases отдельно в gzip архиве
2. в директорию недельного, месячного и годового хранения\
     #/*/*/backup/daily/
     #/*/*/backup/monthly/
     #/*/*/backup/weekly/

##### При указании дня недели или дата в файла crontab произведеи некоректное
##### работу скрипта

