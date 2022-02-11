# MySQL

## Prerequisites

Basic management and various improvements of MySQL/MariaDB server.

## UTF8 collation issue

According to [this article](https://adamhooper.medium.com/in-mysql-never-use-utf8-use-utf8mb4-11761243e434), when you select the collation method ```utf8```, it is not really ```utf8``` so you instead should pick ```utf8mb4``` to avoid some issues.

According to [this HN post](https://news.ycombinator.com/item?id=29907551) this is also a security vulnerability because MySQL/MariaDB silently truncate strings at the first invalid character. This can result in data manipulation attacks where a higher level layer validates the complete input as UTF-8 for insertion into the DB, but the database only stores half the string.

According to [this Mozilla bug report](https://bugzilla.mozilla.org/show_bug.cgi?id=1253201), it seems the correct approach is to use "utf8mb4" which properly handles full four-byte UTF8 character encodings.

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

## Access MySQL shell

After installation, run ```mysql_secure_installation``` command and proceed with the steps then log into MySQL shell using the root user:

```bash
mysql -u root -p
```

Pass the password into the command line (not recommended)
```bash
mysql -u root --password=mypassword
```

The safest way to do this would be to create a new config file and pass it to ```mysql``` using either the ```--defaults-file=``` or ```--defaults-extra-file=``` command line option.

The difference between the two is that the latter is read in addition to the default config files whereas with the former, only the one file passed as the argument is used.

Your additional configuration file should contain something similar to:

```conf
[client]
user=newuser
password=newuserPassword
```

Make sure that you secure this file.

Then run:

```bash
mysql --defaults-extra-file=<path to the new config file>
```

To exit the MySQL shell run ```exit;```

## Manage users and privileges

Privilege types:

|Privilege|Description|
|---|---|
|ALL PRIVILEGES|This grants a MySQL user full access to a specific database.|
|CREATE|Allows users to create new databases or tables.|
|DROP|Enables users to delete databases or users.|
|INSERT|Allows users to insert rows in tables.|
|DELETE|Allows users to delete rows from tables.|
|SELECT|with ‘SELECT’ permission, users are able to read the contents of a table.|
|UPDATE|Allows users to updates the rows in a table.|
|GRANT OPTION| – Users can grant or remove the privileges of other users.|

Create the user:

```mysql
CREATE USER 'newuser'@'localhost' IDENTIFIED BY 'password';
```

Delete/DROP) user:

```mysql
DROP USER 'newuser'@'localhost';
```

Grant full access privileges (not recommended):

```mysql
GRANT ALL PRIVILEGES ON * . * TO 'newuser'@'localhost';
FLUSH PRIVILEGES;
```

Grant a specific privilege on a specific database table:

```mysql
GRANT SELECT ON production_db.users TO 'newuser'@'localhost';
FLUSH PRIVILEGES;
```

Grant a specific privilege on an entire database:

```mysql
GRANT SELECT ON production_db.* TO 'newuser'@'localhost';
FLUSH PRIVILEGES;
```

**Do not forget to run ```FLUSH PRIVILEGES;``` in order to apply the changes.**

To revoke permissions replace ```GRANT``` with ```REVOKE``` and ```TO``` with ```FROM```.

Display the current privileges

```mysql
SHOW GRANTS FOR 'newuser'@'localhost';
```

## Manage the database

### Character set and collation

Display the list of character sets:

```mysql
SHOW CHARATER SET;
```

To display even more variants based on a specific character set:

```mysql
SHOW COLLATION LIKE 'utf8mb4%';
```

### Create and delete database

Create database:

```mysql
CREATE DATABASE production_db
```

Create database and specify collation:

```mysql
CREATE DATABASE production_db1 CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
```

Change collation of an existing database:

```mysql
ALTER DATABASE production_db1 CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
```

You can also set these at the table level.

Select a database:

```mysql
USE production_db
```

To delete the database:

```mysql
DROP DATABASE production_db1;
```


### Manage tables

Create a table with three columns (id - Integer with a length of 3, first_name - Varchar with a length oof 15, and email - Varchar with a length of 20):

```mysql
CREATE TABLE users(id Int(3),first_name Varchar(15),email Varchar(20));
```

Display a list of existing tables:

```mysql
SHOW TABLES
```

Add another column next to first_name to the users table:

```mysql
ALTER TABLE users ADD last_name varchar (20) AFTER first_name;
```

Insert data into users table:

```mysql
INSERT INTO users VALUES('1','John','Smith','js@example.com');
```

To insert more than one row, separate the value groups with a comma.

Show the contents of a table:

```mysql
SELECT * FROM users;
```

Update a value:

```mysql
UPDATE users SET id = 3 WHERE first_name = 'John';
```

Delete a row

```mysql
DELETE FROM users where id = 3;
```

Delete a column:

```mysql
ALTER TABLE users DROP city;
```

Rename a table:

```mysql
RENAME TABLE users TO clients;
```

### Backup & Restore

To backup a database we will use ```mysqldump```.

Backup database ```production_db2```:

```bash
mysqldump --defaults-extra-file=test_db.cnf production_db2 > production_db2.sql
```

To restore a database, you need to recreate the database and import the ```.sql``` file:

```mysql
CREATE DATABASE production_db2 CHARACTER SET utf8mb4 COLLATE utb8mb4_general_ci;
```

```bash
mysql --defaults-extra-file=test_db.cnf production_db2 < production_db2.sql
```

## Source

* <https://techglimpse.com/mysql-database-connection-error-solved/>
* <https://adamhooper.medium.com/in-mysql-never-use-utf8-use-utf8mb4-11761243e434>
* <https://news.ycombinator.com/item?id=29907551>
* <https://bugzilla.mozilla.org/show_bug.cgi?id=1253201>
* <https://unix.stackexchange.com/questions/205180/how-to-pass-password-to-mysql-command-line>
* <https://www.tecmint.com/gliding-through-database-mysql-in-a-nutshell-part-i/>
