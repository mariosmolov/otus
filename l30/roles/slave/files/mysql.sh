#!/bin/sh

pass=`grep 'password' /var/log/mysqld.log | grep -oE '[^ ]+$'`

command="mysql --connect-expired-password -uroot -p$pass -e "
$command "alter user 'root'@'localhost' identified by '!Qaz2wsx';"

pass="!Qaz2wsx"
command="mysql --connect-expired-password -uroot -p$pass "

$command "-e create database somedb;"
$command < /home/vagrant/somedb.sql

echo "bind-address = 0.0.0.0" >> /etc/my.cnf
echo "server-id = 2" >> /etc/my.cnf
echo "relay-log = /var/log/mysql/mysql-relay-bin.log" >> /etc/my.cnf
echo "log_bin = /var/log/mysql/mysql-bin.log" >> /etc/my.cnf
echo "binlog_do_db = somedb" >> /etc/my.cnf

systemctl restart mysqld

$command "-e CHANGE MASTER TO MASTER_HOST='192.168.1.1', MASTER_USER='replica', MASTER_PASSWORD='!Qaz2wsx', MASTER_LOG_FILE = 'mysql-bin.000001', MASTER_LOG_POS = 854;"
$command "-e start slave;"

