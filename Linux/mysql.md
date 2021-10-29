# MySQL

## Prerequisites

Various improvements of MySQL

## Fix "Too many connections" message

Edit the configuration file ```/etc/my.cnf``` with the following settings:

* Add ```wait_timeout  = 180``` to close sleeping connections
* Add ```interactive_timeout = 200``` to close sleeping CLI connections

__The steps above require a service restart of mysqld.__

If you want to do it LIVE, connect to the data base and run the following commands:

```mysql
SET GLOBAL wait_timeout=180;
SET GLOBAL interactive_timeout=200;
show variables like '%timeout%';
```

## Source

* <https://techglimpse.com/mysql-database-connection-error-solved/>
