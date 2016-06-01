The repository enabled you to setup an mysql full and incremental backup based on percona innobackupex tool. 

Percon innobackupex takes the hotbackup and does not locks the database tables.

Steps:-

(1)mysql user for innobackupex

innobackupex connects the mysql using user/pass , so first create a user for backup purpose.

innobackupex mysql user should have the following rights.

GRANT SUPER, RELOAD, LOCK TABLES, REPLICATION CLIENT ON *.* TO 'repl'@'%' identified by 'repl123';

(2) Download the latest innobackupex tool from percona site.

You can download the latest percona innobackupex tool according to your linux flavour from the percona site.

Link:- https://www.percona.com/downloads/XtraBackup/

(3) Create a configuration file

I have created a configuration file named /etc/mysql-backup.conf which contains the base backup directory path where all the backups will take place. Also it contains the mysql username and password which will be used by innobackupex to take the backup.

contents of configurtion file.

BACKUP_BASE_DIR=/var/backup
MYSQL_USER=repl
MYSQL_PWD='repl123'




