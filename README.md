# Demo Elixir Phoenix

<img src="README.png" alt="Elixir + Phoenix" style="width: 100%;"/>

Demonstration of:

  * [Elixir programming language](https://elixir-lang.org)
  * [Erlang virual machine](https://www.erlang.org/)
  * [Phoenix web framework](www.phoenixframework.org/)
  * [ItemgresSQL database](https://itemgresql.org)
  * [Node.js JavaScript](https://nodejs.org/)
  * [Brunch HTML5 build tool](https://brunch.io/)

This README is a tutorial.

Contents:

* [](#)


## Get Elixir, Erlang, Node

See:

  * http://elixir-lang.org
  * http://exponential.io/blog/2015/02/21/install-postgresql-on-mac-os-x-via-brew/

Setup on macOS using brew:

```sh
$ brew update
$ brew install elixir
$ brew install erlang
$ brew install node
$ path=$(brew info elixir | awk '/Cellar/ {print $1}')
$ export PATH="$PATH:$path/bin"
```

Verify Elixir:

```sh
$ elixir -v
Erlang/OTP 19 [erts-8.0.2] [source] [64-bit]
[smp:4:4] [async-threads:10] [hipe] [kernel-poll:false] [dtrace]
Elixir 1.3.2

$ iex
iex(1)> 1 + 2
2
(to exit, type control-c twice)
```

Update `mix` which is the Elixir package manager:

```sh
$ mix local.hex --force
```


## Get PostgreSQL database

```sh
$ brew install postgresql
$ brew services start postgresql
```

## Get Phoenix framework

Get Phoenix:

```sh
$ mix archive.install hex phx_new
```

## Mix a Phoenix new app

New:

```sh
$ mix phx.new demo
$ cd demo
```

Try running the app with a server:

```sh
$ mix phx.server
```

Try running the app with Interactive Elixir:

```sh
$ iex -S mix phx.server
```

## Database

The default database configuration is:

```txt
username: "postgres",
password: "postgres",
database: "demo_dev",
hostname: "localhost",
```

To change this:

```sh
$ edit config/dev.exs
```

Run:

```sh
$ mix ecto.create
The database for Demo.Repo has been created
```

If you get this error:

```sh
** (Mix) The task "ecto.create" could not be found
```

Then it's likely you're running the command in the wrong directory; verify you're running the command within the app's base directory.

If you get this error:

```sh
** (Mix) The database for Demo.Repo couldn't be created: an exception was raised:
** (DBConnection.ConnectionError) tcp connect (localhost:5432): connection refused - :econnrefused
```

Then do troubleshooting here:

  * https://github.com/sixarm/sixarm_postgresql_help


## Run the server

Run:

```sh
$ mix phx.server
[info] Running Demo.Endpoint with Cowboy using http://localhost:4000
```

If you get this error:

```sh
Error: Brunch 2+ requires node.js v4 or higher ...
Upgrade node or use older brunch for old node.js: npm i -g brunch@1
```

Then update Node, NPM, and brunch:

```sh
$ brew update
$ brew uninstall node
$ sudo rm -rf /usr/local/lib/node_modules
$ brew install node --with-full-icu
$ npm install -g npm
$ npm install -g brunch
```

## Generate a resource

Generate all the code for a complete HTML resource: ecto migration, ecto model, controller, view, and templates.

```sh
$ mix phx.gen.html Accounts User users \
    name:string \
    email:string \
    phone:string \
    web:string \
    about:string
* creating lib/demo_web/controllers/user_controller.ex
* creating lib/demo_web/templates/user/edit.html.eex
* creating lib/demo_web/templates/user/form.html.eex
* creating lib/demo_web/templates/user/index.html.eex
* creating lib/demo_web/templates/user/new.html.eex
* creating lib/demo_web/templates/user/show.html.eex
* creating lib/demo_web/views/user_view.ex
* creating test/demo_web/controllers/user_controller_test.exs
* creating lib/demo/accounts/user.ex
* creating priv/repo/migrations/20200114235531_create_users.exs
* creating lib/demo/accounts.ex
* injecting lib/demo/accounts.ex
* creating test/demo/accounts_test.exs
* injecting test/demo/accounts_test.exs

Add the resource to your browser scope in lib/demo_web/router.ex:

    resources "/users", UserController

Remember to update your repository by running migrations:

    $ mix ecto.migrate
```

Add the resource to the browser scope in `web/router.ex`:

```elixir
scope "/", Demo do
    pipe_through :browser # Use the default browser stack
    get "/", PageController, :index
    resources "/items", ItemController
end
```

Update the repository by running migrations:

```sh
$ mix ecto.migrate
Compiling 9 files (.ex)
...
```

Run the server:

```sh
$ mix phx.server
...
[info] Access DemoWeb.Endpoint at http://localhost:4000
...
```

Browse:

 * http://localhost:4000/users

You now see "Listing items" and "Name", "Description", "New item".


## Change the logo

Edit `web/static/css/phoenix.css`.

Find the section with `.logo`:

```css
.logo {
    width: 519px;
    height: 71px;
    display: inline-block;
    margin-bottom: 1em;
    background-image: url("/images/phoenix.png");
    background-size: 519px 71px;
}
```

Change the logo image to anything you want:

```css
.logo {
    width: 400px;
    height: 100px;
    display: inline-block;
    margin-bottom: 1em;
    background-image: url("http://placehold.it/400x100");
    background-size: 400px 100px;
}
```
