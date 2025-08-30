# Install via mise

Shortcut:

```sh
make mise
```

## Install Erlang via mise

Run:

```sh
mise use erlang@latest
```

Success looks like:

```sh
Erlang/OTP 28 …
```

Verify:

```sh
erl --version
Erlang/OTP 28 …
```

## Install Elixir via mise

Run:

```sh
mise use erlang@latest
```

Verify:

```sh
elixir --version
Erlang/OTP 28 …
Elixir 1.18.4 …
```

## Install Node JavaScript via mise

Run:

```sh
mise use nodejs@latest
```

Verify:

```sh
node --version
v24.7.0
```

## Install PostgreSQL database via mise

If you're using macOS then you need dependencies such as via brew:

```sh
brew install gcc readline zlib curl openssl@1.1 ossp-uuid icu4c pkg-config
PKG_CONFIG_PATH="$(brew --prefix)/lib/pkgconfig:$(brew --prefix icu4c)/lib/pkgconfig" \
LDFLAGS="-L$(brew --prefix)/lib" \
CPPFLAGS="-I$(brew --prefix)/include" \
mise use postgres@latest
```

If you're using Linux:

```sh
mise use postgres@latest
```

Verify:

```sh
psql --version
psql (PostgreSQL) 17.6
```

Start:

```sh
"$(mise where postgres)/bin/pg_ctl" -D "$$(mise where postgres)/data" -l "$(mise where postgres)/log" start
```

Success looks like:

```sh
server started
```

The Postgres installation automatically creates a superuser role.

- For many operating systems, the superuser role is `postgres`.

- For macOS, the superuser role default is your macOS user name `echo $USER`.

Verify you can connect to the Postgres server with the default database "postgres" and default superuser role name "postgres"

```sh
$(mise where postgres)/bin/psql postgres postgres
```

If you want to step the server:

```sh
"$(mise where postgres)/bin/pg_ctl" -D "$(mise where postgres)/data" stop --mode smart
```
