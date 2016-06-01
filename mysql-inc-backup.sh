#!/bin/bash

source /etc/mysql-backup.conf

TODAY_DATE=`date +'%Y-%m-%d-%H-%M-%S'`
TODAY_DATE2=`date +'%Y-%m-%d'`

BASE=$BACKUP_BASE_DIR/$TODAY_DATE2/inc/$TODAY_DATE

mkdir -p $BASE

LAST_FULL=`cat $BACKUP_BASE_DIR/last_full_backup.log`/full
LAST_INC=`cat $BACKUP_BASE_DIR/last_inc_backup.log`

INC_BASE_DIR=$LAST_FULL


if  [ ! -z "$LAST_INC" ]; then
        INC_BASE_DIR=$LAST_INC
fi

echo "innobackupex --no-timestamp  --user=$MYSQL_USER --password=$MYSQL_PWD --incremental $BASE  --incremental-basedir=$INC_BASE_DIR 2>> $BACKUP_BASE_DIR/$TODAY_DATE2/inc/$TODAY_DATE.log"

OUT=$(innobackupex --no-timestamp  --user=$MYSQL_USER --password=$MYSQL_PWD --incremental $BASE  --incremental-basedir=$INC_BASE_DIR 2>> $BACKUP_BASE_DIR/$TODAY_DATE2/inc/$TODAY_DATE.log )

if [ "$?" == "1" ]; then

        echo 'Backup Failed'

else

        echo $BASE > $BACKUP_BASE_DIR/last_inc_backup.log
        echo 'Incremental Backup Completed'
fi
