# PostgreSQL

## Prerequisites

Basic configuration and management of PostgreSQL.

## Installation and configuration

### Installation

Install the database server according to the documentation install notes.

Initialise the server:

```bash
postgresql-setup --initdb

# or

/usr/pgsql-14/bin/postgresql-14-setup initdb
```

### Access the shell

```bash
sudo -u postgres psql
```

### Secure access

The default authentication method is *peer* for the database administrator, meaning it gets the client’s operating system user name from the operating system and checks if it matches the requested database user name to allow access, for local connections.  
During the installation process, a system user account called postgres was created without a password, this is also the default database administrator user name.

Access the shell:

```bash
 sudo -u postgres psql
```

Create user and database:

```sql
CREATE USER newuser WITH PASSWORD 'newuserpass';
CREATE DATABASE production_db1 OWNER newuser;
```

Exit the shell:

```sql
\q
```

PostgreSQL is listening on port *5432*, so please configure the firewall accordingly.

**It is not recommended to allow access from public interfaces without setting up SSL for data in transit.**

Configure allowed hosts:

```bash
vim /var/lib/pgsql/data/pg_hba.conf
```

```conf
host production_db1 newuser 1.2.3.4/32 md5
```

**If you want to connect to the database using ```psql``` from the localhost you will need to set ```md5``` to Unix domain socket connections only (by default is peer).**

The format of the configuration aboseis the following:

* host
* database
* user
* address
* auth-method

Configure listening address:

```bash
vim /var/lib/pgsql/data/postgresql.conf
```

```conf
listen_addresses = 'localhost,1.2.3.4/32'
```

Restart the service:

```bash
systemctl restart postgresql
```

## Manage the database

Login as database user from localhost:

```bash
psql -U newuser -d production_db1
```

Show existing databases and use one of them then show a list of existing tables:

```sql
\l

--or

\list

--or

SELECT datname FROM pg_database;

\connect production_db1
\dt
```

Create table:

```sql
CREATE TABLE users (id integer NOT NULL, first_name char(10) NOT NULL, city char(15), country char(20) NOT NULL, PRIMARY KEY (id));
```

Insert data into the table:

```sql
INSERT INTO users VALUES(1,'John','London','UK');
```

Show contents of the users table:

```sql
SELECT * FROM users;
```

Add/remove column:

In PostgreSQL you can only append a column, you cannot insert a column where you want:

```sql
 -- Add column
 ALTER TABLE users ADD COLUMN last_name char (20);

-- Delete column
ALTER TABLE users DROP COLUMN city; 
```

Update a value:

```sql
UPDATE users SET id = 3 WHERE first_name = 'John';
```

Delete row:

```sql
DELETE FROM users WHERE id = 3;
```

Delete database and user:

```sql
DROP DATABASE production_db1;
DROP USER newuser;
```

## Backup & restore

To backup the database you need to use ```pg_dump```:

```bash
# Switch user
sudo -i -u postgres

# Backup the entire database
pg_dump production_db1 > production_db1.sql

# Backup only the schema
pg_dump production_db1 --schema-only > production_db1_schema.sql
```

Restore the database:

```bash
pg_dump production_db1 < production_db1.sql
```

## Script variables

In case you want to use a script to connect to the database and perform some actions, you can use ```PGPASSWORD``` to pass the password.

**This is not recommended because the password is stored in cleartext. You can use ```PGPASSFILE``` to specify the location of the password file to use for lookups.**

## Sources

* <https://www.digitalocean.com/community/tutorials/how-to-secure-postgresql-against-automated-attacks>
* <https://docs.nextcloud.com/server/latest/admin_manual/configuration_database/linux_database_configuration.html>
* <https://www.postgresql.org/download/linux/redhat/>
