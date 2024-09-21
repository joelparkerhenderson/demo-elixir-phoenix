# Install via brew

Shortcut:

```sh
make brew
```


## Preflight


### For building

Install:

```sh
brew install autoconf
```


### For building with OpenSSL

Install:

```sh
brew install openssl
```

Find the path:

```sh
brew --prefix openssl
```

Append the path to the `PKG_CONFIG_PATH` environment variable:

```sh
export PKG_CONFIG_PATH="$PKG_CONFIG_PATH:/opt/homebrew/opt/openssl@3/lib/pkgconfig/"
```


If you ever get this error message:

```sh
configure: error: library 'crypto' is required for OpenSSL
```

Or this error message:

```sh
checking for CRYPTO_new_ex_data in -lcrypto... no
```

Then figure out what's wrong with your OpenSSL installation.


### For documentation

For building documentation and elixir reference builds: 

```sh
brew install libxslt fop
```

For using `asdf` to install more software:

```sh
brew install asdf
```


### For PostgreSQL

Install:

```sh
brew install gcc readline zlib curl ossp-uuid icu4c pkg-config
```

You might need:

```sh
export HOMEBREW_PREFIX=$(brew --prefix)
```

You might need to append package configuration paths:

```sh
export PKG_CONFIG_PATH="$PKG_CONFIG_PATH:/opt/homebrew/bin/pkg-config:$(brew --prefix openssl)/lib/pkgconfig/:$(brew --prefix icu4c)/lib/pkgconfig:$(brew --prefix curl)/lib/pkgconfig:$(brew --prefix zlib)/lib/pkgconfig"
```


### For wxWidgets

For building with wxWidgets (start observer or debugger). Note that you may need to select the right wx-config before installing Erlang. 

```sh
brew install wxwidgets
```


### Upgrade

To upgrade any time:

```sh
brew upgrade
```


## Install Erlang via brew

Run:

```sh
brew install erlang
```


## Install Elixir via brew

Run:

```sh
brew install elixir
brew upgrade elixir
```

Set path:

```sh
path=$(brew info elixir | awk '/Cellar/ {print $1}')
export PATH="$PATH:$path/bin"
```


## Install Node JavaScript via brew

Install:

```sh
brew install node
brew upgrade node
```

Verify:

```sh
node --version
v22.9.0
```


## Install PostgreSQL database via brew

Run:

```sh
brew install postgresql
```

Verify:

```sh
psql --version
psql (PostgreSQL) 16.4
```

Start:

```sh
brew services start postgresql@16
==> Successfully started `postgresql@16` (label: homebrew.mxcl.postgresql@16)
```

The Brew installation automatically creates a superuser role named with your macOS username.

Verify you can connect to the Postgres server by using your macOS user name and default database name:

```sh
psql --username "$USER" postgres
```
