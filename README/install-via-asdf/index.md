# Install via adsf

Shortcut:

```sh
make asdf
```


## Install Erlang via asdf 

Run:

```sh
asdf plugin add erlang
asdf install erlang latest
asdf local erlang latest
```

Success looks like:

```sh
Erlang/OTP 27.1 (asdf_27.1) has been successfully built
```

Verify:

```sh
erl --version
Erlang/OTP 27 [erts-15.0] [source] [64-bit] [smp:10:10] [ds:10:10:10] [async-threads:1] [jit]
```


## Install Elixir via asdf

Run:

```sh
asdf plugin add elixir
asdf install elixir latest
asdf local elixir latest
```

Verify:

```sh
elixir --version
Erlang/OTP 27 [erts-15.1] [source] [64-bit] [smp:10:10] [ds:10:10:10] [async-threads:1] [jit]
Elixir 1.17.3 (compiled with Erlang/OTP 27)
```


## Install Node JavaScript via asdf

Run:

```sh
asdf plugin add nodejs
asdf install nodejs latest
asdf local nodejs latest
```

Verify:

```sh
node --version
v22.9.0
```


## Install PostgreSQL database via asdf

Run:

```sh
asdf plugin add postgres
asdf install postgres latest
asdf local postgres latest
```

Troubleshooting: if you get any errors about "crypto" or "SSL", and also you installed some prerequisites via macOS brew, then you might need to set paths then retry:

```sh
export HOMEBREW_PREFIX=$(brew --prefix)
export PKG_CONFIG_PATH="$PKG_CONFIG_PATH:/opt/homebrew/bin/pkg-config:$(brew --prefix openssl)/lib/pkgconfig/:$(brew --prefix icu4c)/lib/pkgconfig:$(brew --prefix curl)/lib/pkgconfig:$(brew --prefix zlib)/lib/pkgconfig"
```

Success looks like:

```sh
Success. You can now start the database server using:
$HOME/.asdf/installs/postgres/16.4/bin/pg_ctl -D $HOME/.asdf/installs/postgres/16.4/data -l logfile start
```

Verify:

```sh
psql --version
psql (PostgreSQL) 16.4
```

Start:

```sh
$HOME/.asdf/installs/postgres/16.4/bin/pg_ctl -D $HOME/.asdf/installs/postgres/16.4/data -l logfile start
```

Success looks like:

```sh
server started
```

The Postgres installation automatically creates a superuser role named with your macOS username.

Verify you can connect to the Postgres server by using the macOS user name and default database name:

```sh
psql postgres
```

Verify you can connect to the Postgres server by using defaults:

```sh
psql --username postgres postgres
```
