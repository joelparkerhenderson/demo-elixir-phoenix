
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
CREATE ROLE demo_elixir_phoenix_dev_owner WITH CREATEDB LOGIN ENCRYPTED PASSWORD 'a9ed78cd8e4aa2bd2a37ad7319899106';"
CREATE ROLE demo_elixir_phoenix_test_owner WITH CREATEDB LOGIN ENCRYPTED PASSWORD '7a7ffea903ac2617a69e6b8cafb4f234';"
```

Verify via `\du` metacommand which means "describe users":

```psql
\du demo_elixir_phoenix_*_owner
```

```psqlout
                List of roles
           Role name            | Attributes 
--------------------------------+------------
 demo_elixir_phoenix_dev_owner  | Create DB
 demo_elixir_phoenix_test_owner | Create DB
```

Or verify via select:

```psql
SELECT rolname FROM pg_roles where rolname like 'demo_elixir_phoenix_%_owner';
```

```psqlout
SELECT rolname FROM pg_roles where rolname like 'demo_elixir_phoenix_%_owner';
            rolname             
--------------------------------
 demo_elixir_phoenix_dev_owner
 demo_elixir_phoenix_test_owner
```

Create databases:

```psql
CREATE DATABASE demo_elixir_phoenix_dev with owner = demo_elixir_phoenix_dev_owner;
CREATE DATABASE demo_elixir_phoenix_test with owner = demo_elixir_phoenix_test_owner;
```

Verify via `\l` metacommand which means "list databases":

```psql
\l demo_elixir_phoenix_*
```

```psqlout
\l demo_elixir_phoenix_*
                                                                      List of databases
           Name           |             Owner              | Encoding | Locale Provider |   Collate   |    Ctype    | Locale | ICU Rules | Access privileges 
--------------------------+--------------------------------+----------+-----------------+-------------+-------------+--------+-----------+-------------------
 demo_elixir_phoenix_dev  | demo_elixir_phoenix_dev_owner  | UTF8     | libc            | en_US.UTF-8 | en_US.UTF-8 |        |           | 
 demo_elixir_phoenix_test | demo_elixir_phoenix_test_owner | UTF8     | libc            | en_US.UTF-8 | en_US.UTF-8 |        |           | 
```

Or verify via select:

```psql
SELECT datname FROM pg_database where datname like 'demo_elixir_phoenix_%';
```

```psqlout
         datname          
--------------------------
 demo_elixir_phoenix_dev
 demo_elixir_phoenix_test
```

Optional: save the database information to your local environment file `.env.dev`

```sh
DB_DATABASE=demo_elixir_phoenix_dev
DB_USERNAME=demo_elixir_phoenix_dev_owner
DB_PASSWORD=a9ed78cd8e4aa2bd2a37ad7319899106
```

Optional: save the database information to your local environment file `.env.test`

```sh
DB_DATABASE=demo_elixir_phoenix_test 
DB_USERNAME=demo_elixir_phoenix_test_owner
DB_PASSWORD=7a7ffea903ac2617a69e6b8cafb4f234
```

Optional: ignore files that start with `.env`:

```sh
echo ".env*" >> .gitignore
```
