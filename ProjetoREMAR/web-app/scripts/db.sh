#!/bin/bash

mysql -uroot -proot -e "create database if not exists $1;"
mysql -uroot -proot -e "grant all on $1.* to '$1'@'localhost' identified by '$1';"
mysql -uroot -proot -e "grant select on remar.user to '$1'@'localhost';"
mysql -uroot -proot -e "grant select on remar.role to '$1'@'localhost';"
mysql -uroot -proot -e "grant select on remar.user_role to '$1'@'localhost';"