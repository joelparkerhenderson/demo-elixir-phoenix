# Demo Elixir Phoenix

Demonstration of:

  * [Elixir programming language](https://elixir-lang.org)
  * [Erlang virual machine](https://www.erlang.org/)
  * [Phoenix web framework](www.phoenixframework.org/)
  * [PostgresSQL database](https://postgresql.org)
  * [Node.js JavaScript](https://nodejs.org/)
  * [Brunch HTML5 build tool](https://brunch.io/)

This README is a tutorial.


## Get Elixir & Phoenix

See:

  * http://elixir-lang.org
  * http://exponential.io/blog/2015/02/21/install-postgresql-on-mac-os-x-via-brew/

Setup on macOS using brew:

    $ brew update
    $ brew install elixir
    $ brew install erlang
    $ brew install node
    $ brew install postgresql
    $ brew services start postgresql
    $ export PATH="$PATH:/usr/local/Cellar/elixir/1.3.2/bin"

Setup on Ubuntu using apt:

    #TODO

Setup on RedHat using yum:

    #TODO

Verify Elixir:

    $ elixir -v
    Erlang/OTP 19 [erts-8.0.2] [source] [64-bit]
    [smp:4:4] [async-threads:10] [hipe] [kernel-poll:false] [dtrace]
    Elixir 1.3.2

    $ iex
    iex(1)> 1 + 2
    2
    (to exit, type control-c twice)

Get Phoenix:

    $ mix local.hex
    $ mix archive.install https://github.com/phoenixframework/archives/raw/master/phoenix_new.ez


## Mix a Phoenix new app

New:

    $ mix phoenix.new demo
    $ cd demo

Try running the app with a server:

    $ mix phoenix.server

Try running the app with Interactive Elixir:

    $ iex -S mix phoenix.server


## Database

The default database configuration is:

    username: "postgres",
    password: "postgres",
    database: "demo_dev",
    hostname: "localhost",

To change this:

    $ edit config/dev.exs

Run:

    $ mix ecto.create
    The database for Demo.Repo has been created

If you get this error:

    ** (Mix) The task "ecto.create" could not be found

Then it's likely you're running the command in the wrong directory; verify you're running the command within the app's base directory.

If you get this error:

    ** (Mix) The database for Demo.Repo couldn't be created: an exception was raised:
    ** (DBConnection.ConnectionError) tcp connect (localhost:5432): connection refused - :econnrefused

Then do troubleshooting here:

  * https://github.com/sixarm/sixarm_postgresql_help


## Run the server

Run:

    $ mix phoenix.server
    [info] Running Demo.Endpoint with Cowboy using http://localhost:4000

If you get this error:

    Error: Brunch 2+ requires node.js v4 or higher ...
    Upgrade node or use older brunch for old node.js: npm i -g brunch@1

Then update Node, NPM, and brunch:

    $ brew update
    $ brew uninstall node
    $ sudo rm -rf /usr/local/lib/node_modules
    $ brew install node --with-full-icu
    $ npm install -g npm
    $ npm install -g brunch
