The repository enabled you to setup an mysql full and incremental backup based on percona innobackupex tool. 

The scripts will take weekly full bckup on every monday 12:00 AM and then incremental backup every 30 minutes. 

The durtion for both the scripts can be changed as your requirements.

Percona innobackupex takes the hotbackup and does not locks the database tables.

Steps:-

<h2>(1)mysql user for innobackupex</h2>

innobackupex connects the mysql using user/pass , so first create a user for backup purpose.

innobackupex mysql user should have the following rights.

<code>GRANT SUPER, RELOAD, LOCK TABLES, REPLICATION CLIENT ON *.* TO 'repl'@'%' identified by 'repl123';</code>

<h2>(2) Download the latest innobackupex tool from percona site.</h2>

You can download the latest percona innobackupex tool according to your linux flavour from the percona site.

Link:- https://www.percona.com/downloads/XtraBackup/

<h2>(3)Create a configuration file</h2>

I have created a configuration file named /etc/mysql-backup.conf which contains the base backup directory path where all the backups will take place. Also it contains the mysql username and password which will be used by innobackupex to take the backup.

contents of configurtion file.
<pre>
BACKUP_BASE_DIR=/var/backup
MYSQL_USER=repl
MYSQL_PWD='repl123'
</pre>

<h2>(4) copy the script files </h2>

copy the mysql-full-backup.sh and mysql-inc-backup.sh into /usr/bin

<h2>(5)Add crontan entries</h2>
<pre>
0 0 * * mon root /usr/bin/mysql-full-backup.sh
*/30 * * * * root /usr/bin/mysql-inc-backup.sh
</pre>


