
### Configure PostgresSQL database

To make the local PostgreSQL setup more capable, and more specific for this demo, create a new role.

* The role name is "demo_elixir_phoenix" because it matches this project name.

* The role password can be a strong password because it is a good security practice.

Generate a strong password such as 32 hexadecimal digits:

```sh
printf "%s\n" $(LC_ALL=C < /dev/urandom tr -dc '0-9a-f' | head -c32)
```

Example output:

```txt
a9ed78cd8e4aa2bd2a37ad7319899106
```

Connect via typical PostgreSQL options:

```sh
psql postgres postgres
```

Connect via macOS brew PostgreSQL options:

```sh
psql postgres "$USER"
```

Create a role:

```psql
CREATE ROLE demo_elixir_phoenix_owner WITH CREATEDB LOGIN ENCRYPTED PASSWORD 'a9ed78cd8e4aa2bd2a37ad7319899106';"
```

Verify via `\du` metacommand which means "describe users":

```psql
\du demo_elixir_phoenix_owner
```

```psqlout
             List of roles
         Role name         | Attributes 
---------------------------+------------
 demo_elixir_phoenix_owner | Create DB
```

Or verify via select:

```psql
SELECT rolname FROM pg_roles where rolname = 'demo_elixir_phoenix_owner';
```

```psqlout
 rolname          
---------------------------
 demo_elixir_phoenix_owner
```

Create a database:

```psql
CREATE DATABASE demo_elixir_phoenix with owner = demo_elixir_phoenix_owner;
```

Verify via `\l` metacommand which means "list databases":

```psql
\l demo_elixir_phoenix
```

```psqlout
                                                                 List of databases
        Name         |           Owner           | Encoding | Locale Provider |   Collate   |    Ctype    | Locale | ICU Rules | Access privileges 
---------------------+---------------------------+----------+-----------------+-------------+-------------+--------+-----------+-------------------
 demo_elixir_phoenix | demo_elixir_phoenix_owner | UTF8     | libc            | en_US.UTF-8 | en_US.UTF-8 |        |           | 
```

Or verify via select:

```psql
SELECT datname FROM pg_database where datname = 'demo_elixir_phoenix';
```

```psqlout
       datname       
---------------------
 demo_elixir_phoenix
```

Optional: save the database information to your local environment file:

```sh
echo "DB_DATABASE=demo_elixir_phoenix" >> .env
echo "DB_USERNAME=demo_elixir_phoenix_owner" >> .env
echo "DB_PASSWORD=a9ed78cd8e4aa2bd2a37ad7319899106" >> .env
```