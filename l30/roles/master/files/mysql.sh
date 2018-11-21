#!/bin/sh

pass=`grep 'password' /var/log/mysqld.log | grep -oE '[^ ]+$'`

command="mysql --connect-expired-password -uroot -p$pass "
$command "-e alter user 'root'@'localhost' identified by '!Qaz2wsx';"

pass="!Qaz2wsx"
command="mysql --connect-expired-password -uroot -p$pass "
$command "-e create database somedb;"
$command < /home/vagrant/somedb.sql
echo "bind-address = 0.0.0.0" >> /etc/my.cnf
echo "server-id = 1" >> /etc/my.cnf
echo "log_bin = /var/log/mysql/mysql-bin.log" >> /etc/my.cnf
echo "binlog_do_db = somedb" >> /etc/my.cnf
systemctl restart mysqld

$command "-e create user 'replica'@'%' IDENTIFIED BY '!Qaz2wsx';"
$command "-e GRANT REPLICATION SLAVE ON *.* TO 'replica'@'%'"
$command "-e FLUSH PRIVILEGES;"
$command "-e show master status;"

