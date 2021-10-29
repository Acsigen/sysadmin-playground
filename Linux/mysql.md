# MySQL

## Prerequisites

Various improvements of MySQL

## Fix "Too many connections" message

* Add ```max_timeout  = 180``` to close sleeping connections
* Add ```interactive_timeout = 200``` to close sleeping CLI connections

These steps require a service restart of mysqld.

## Source

* <https://techglimpse.com/mysql-database-connection-error-solved/>
