#!/bin/bash

source /etc/mysql-backup.conf

TODAY_DATE=`date +'%Y-%m-%d'`

mkdir -p $BACKUP_BASE_DIR/$TODAY_DATE/full
cd $BACKUP_BASE_DIR/$TODAY_DATE/full
OUT=$(innobackupex --no-timestamp --user=$MYSQL_USER --password=$MYSQL_PWD $BACKUP_BASE_DIR/$TODAY_DATE/full 2>>  $BACKUP_BASE_DIR/$TODAY_DATE-log)

if [ "$?" == "1" ]; then
        echo 'Backup Failed'
        echo '=============='
        cat $BACKUP_BASE_DIR/$TODAY_DATE-log

else
        echo "Bckup Completed"
        echo "$BACKUP_BASE_DIR/$TODAY_DATE" > $BACKUP_BASE_DIR/last_full_backup.log
        rm -f $BACKUP_BASE_DIR/last_inc_backup.log
        touch $BACKUP_BASE_DIR/last_inc_backup.log

fi
