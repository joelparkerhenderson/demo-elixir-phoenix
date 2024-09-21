# Demo Elixir Phoenix

<img src="README.png" alt="Elixir + Phoenix" style="width: 100%;"/>

Demonstration of Elixir Phoenix,  how to get it up and running, and [how to deploy via Gigalixir](README/deploy-via-gigalixir/).


## Install Erlang, Elixir, Node, Postgres

Introductory instructions:

  * http://elixir-lang.org
  * http://exponential.io/blog/2015/02/21/

There are various ways to install:

  * [Install via asdf](README/install-via-asdf/) - for cross-platform developers
  * [Install via brew](README/install-via-brew/) - for macOS developers who prefer brew
  * [Install via kerl](README/install-via-kerl/) - wip
  * [Install via source](README/install-via-source/) - wip

Verify versions are at least these:

```sh
erl --version
Erlang/OTP 27 …

elixir --version
Elixir 1.17.3 …

psql --version
psql (PostgreSQL) 16.4

node --version
v22.9.0
```



### Configure PostgresSQL database


To make the local PostgreSQL setup more capable, and more specific for this demo, create a new role.

* The role name is "demo_elixir_phoenix" because it matches this project name.

* The role password can be a strong password because it is a good security practice.

Generate a strong password such as 32 hexadecimal digits:

```sh
printf "%s\n" $(LC_ALL=C < /dev/urandom tr -dc '0-9a-f' | head -c32)
```

Example output:

```sh
a9ed78cd8e4aa2bd2a37ad7319899106
```

To make the local PostgreSQL setup more capable, and more specific for this demo, create a new role.

* The role name is "demo_elixir_phoenix" because it matches this project name.

* The role password can be a strong password because it is a good security practice.

Generate a strong password such as 32 hexadecimal digits:

```sh
printf "%s\n" $(LC_ALL=C < /dev/urandom tr -dc '0-9a-f' | head -c32)
```

Example output:

```sh
a9ed78cd8e4aa2bd2a37ad7319899106
```

Connect via typical PostgreSQL options:

```
psql --username postgres postgres
```

Connect via macOS brew PostgreSQL options:

```sh
psql --username "$USER" postgres
```

Use psql to create the role:

```psql
postgres=# CREATE ROLE demo_elixir_phoenix WITH CREATEDB LOGIN ENCRYPTED PASSWORD 'a9ed78cd8e4aa2bd2a37ad7319899106';
```

Verify:

```psl
postgres=# \du demo_elixir_phoenix
                List of roles
      Role name      | Attributes
---------------------+------------
 demo_elixir_phoenix | Create DB
```


### Update mix

Update `mix` which is the Elixir package manager:

```sh
mix local.hex --force
```

Output:

```sh
* creating …/.mix/archives/hex-2.1.1
```


### Get Phoenix framework

Install the Phoenix new project generator:

```sh
mix archive.install hex phx_new
```

Output:

```txt
* creating ~/.mix/archives/phx_new-1.7.14
```

Verify:

```sh
mix phx.new -v​
```

Output:

```txt
Phoenix installer v1.7.14
```


## Create a new app


### Mix a Phoenix new directory and app

New:

```sh
mix phx.new demo-elixir-phoenix --app demo_elixir_phoenix
cd demo-elixir-phoenix
```


### Create a database

Change the database configuration in the file `config/dev.exs`.

From the default username and password:

```elixir
username: "postgres",
password: "postgres",
```

Into the custom username and password:

```elixir
username: "demo_elixir_phoenix",
password: "a9ed78cd8e4aa2bd2a37ad7319899106",
```

Run:

```sh
mix ecto.create
The database for DemoElixirPhoenix.Repo has been created
```

Do the same change of username and password to the file `config/test.exs`.


### Fixes

If you get this error:

```sh
** (Mix) The task "ecto.create" could not be found
```

Then it's likely you're running the command in the wrong directory; verify you're running the command within the app's base directory.

If you get this error:

```sh
** (Mix) The database for DemoElixirPhoenix.Repo couldn't be created: an exception was raised:
** (DBConnection.ConnectionError) tcp connect (localhost:5432): connection refused - :econnrefused
```

Then do troubleshooting here:

  * https://github.com/sixarm/sixarm-postgresql-help


### Test

Run:

```
mix test
```

Output:

```txt
…
Finished in 0.03 seconds (0.01s async, 0.02s sync)
5 tests, 0 failures
```


### Run the Phoenix server

Run:

```sh
mix phx.server

[info] Running DemoElixirPhoenixWeb.Endpoint with Bandit 1.5.5 at 127.0.0.1:4000 (http)
[info] Access DemoElixirPhoenixWeb.Endpoint at http://localhost:4000
[watch] build finished, watching for changes...

Rebuilding...

Done in 166ms.
```

Browse:

* [http://localhost:4000](http://localhost:4000)
  
You should see a welcome page.

### Fixes

If you get this error:

```sh
Error: Brunch 2+ requires node.js v4 or higher …
Upgrade node or use older brunch for old node.js: npm i -g brunch@1
```

Then update Node, NPM, and brunch:

```sh
brew update
brew uninstall node
sudo rm -rf /usr/local/lib/node_modules
brew install node --with-full-icu
npm install -g npm
npm install -g brunch
```


## Work on the app


### List routes

You may want to list the server routes:

```sh
mix phx.routes
```

Output:

```txt
  GET   /                                      DemoElixirPhoenixWeb.PageController :home
  GET   /dev/dashboard/css-:md5                Phoenix.LiveDashboard.Assets :css
  GET   /dev/dashboard/js-:md5                 Phoenix.LiveDashboard.Assets :js
  GET   /dev/dashboard                         Phoenix.LiveDashboard.PageLive :home
  GET   /dev/dashboard/:page                   Phoenix.LiveDashboard.PageLive :page
  GET   /dev/dashboard/:node/:page             Phoenix.LiveDashboard.PageLive :page
  *     /dev/mailbox                           Plug.Swoosh.MailboxPreview []
  WS    /live/websocket                        Phoenix.LiveView.Socket
  GET   /live/longpoll                         Phoenix.LiveView.Socket
  POST  /live/longpoll                         Phoenix.LiveView.Socket
```



### Generate a resource

Generate all the code for a complete HTML resource: ecto migration, ecto model, controller, view, and templates.

```sh
mix phx.gen.html Account User users \
    name:string \
    email:string
```

Output:

```txt
* creating lib/demo_elixir_phoenix_web/controllers/user_controller.ex
* creating lib/demo_elixir_phoenix_web/controllers/user_html/edit.html.heex
* creating lib/demo_elixir_phoenix_web/controllers/user_html/index.html.heex
* creating lib/demo_elixir_phoenix_web/controllers/user_html/new.html.heex
* creating lib/demo_elixir_phoenix_web/controllers/user_html/show.html.heex
* creating lib/demo_elixir_phoenix_web/controllers/user_html/user_form.html.heex
* creating lib/demo_elixir_phoenix_web/controllers/user_html.ex
* creating test/demo_elixir_phoenix_web/controllers/user_controller_test.exs
* creating lib/demo_elixir_phoenix/account/user.ex
* creating priv/repo/migrations/20240625211751_create_users.exs
* creating lib/demo_elixir_phoenix/account.ex
* injecting lib/demo_elixir_phoenix/account.ex
* creating test/demo_elixir_phoenix/account_test.exs
* injecting test/demo_elixir_phoenix/account_test.exs
* creating test/support/fixtures/account_fixtures.ex
* injecting test/support/fixtures/account_fixtures.ex
```


### Reorder timestamps

We prefer our migration timestamps to come before the rest of the fields, so we edit the migration:

```sh
edit priv/repo/migrations/*_create_users.exs
```

Our result looks like this:

```elixir
defmodule DemoElixirPhoenix.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      timestamps(type: :utc_datetime)
      add :name, :string
      add :email, :string
    end
  end
end
```


### Add the route

See the router file `lib/demo_elixir_phoenix_web/router.ex`.

The default is:

```elixir
  scope "/", DemoElixirPhoenixWeb do
    pipe_through :browser

    get "/", PageController, :home
  end
```

Edit the router:

```sh
edit lib/demo_elixir_phoenix_web/router.ex`
```

Add the user resource to the browser scope:

```elixir
  scope "/", DemoElixirPhoenixWeb do
    pipe_through :browser
    
    resources "/users", UserController

    get "/", PageController, :home
  end
```


### Migrate

Migrate:

```sh
mix ecto.migrate
```

Output:

```txt
Generated demo_elixir_phoenix app

[info]  == Running … DemoElixirPhoenix.Repo.Migrations.CreateUsers.change/0 forward

[info]  create table users

[info]  == Migrated … in 0.0s
```


### Verify routes

Verify the user routes exist:

```sh
mix phx.routes | grep users
```

Output:

```txt
  GET     /users                                 DemoElixirPhoenixWeb.UserController :index
  GET     /users/:id/edit                        DemoElixirPhoenixWeb.UserController :edit
  GET     /users/new                             DemoElixirPhoenixWeb.UserController :new
  GET     /users/:id                             DemoElixirPhoenixWeb.UserController :show
  POST    /users                                 DemoElixirPhoenixWeb.UserController :create
  PATCH   /users/:id                             DemoElixirPhoenixWeb.UserController :update
  PUT     /users/:id                             DemoElixirPhoenixWeb.UserController :update
  DELETE  /users/:id                             DemoElixirPhoenixWeb.UserController :delete
```


### Run

Run the server:

```sh
mix phx.server
…
[info] Running DemoElixirPhoenixWeb.Endpoint with Bandit 1.5.5 at 127.0.0.1:4000 (http)
[info] Access DemoElixirPhoenixWeb.Endpoint at http://localhost:4000
[watch] build finished, watching for changes...

Rebuilding...

Done in 152ms.
```

Browse:

 * http://localhost:4000/users

You now see a users landing page, with text such as "Listing Users", "Name", "Email", etc.

Output from server console:

```txt
[info] GET /users
[debug] Processing with DemoElixirPhoenixWeb.UserController.index/2
  Parameters: %{}
  Pipelines: [:browser]
[debug] QUERY OK source="users" db=0.4ms queue=0.5ms idle=974.7ms
SELECT u0."id", u0."name", u0."email", u0."inserted_at", u0."updated_at" FROM "users" AS u0 []
↳ DemoElixirPhoenixWeb.UserController.index/2, at: lib/demo_elixir_phoenix_web/controllers/user_controller.ex:8
[info] Sent 200 in 48ms
```
