# Demo Elixir Phoenix

<img src="README.png" alt="Elixir + Phoenix" style="width: 100%;"/>

Demonstration of:

* [Setup](#setup)
  * [Get Elixir, Erlang, Node](#get-elixir-erlang-node)
  * [Get PostgreSQL database](#get-postgresql-database)
  * [Get Phoenix framework](#get-phoenix-framework)
* [Create a new app](#create-a-new-app)
  * [Mix a Phoenix new app](#mix-a-phoenix-new-app)
  * [Create a database](#create-a-database)
  * [Run the Phoenix server](#run-the-phoenix-server)
* [Work on the app](#work-on-the-app)
  * [Generate a resource](#generate-a-resource)
  * [Change the logo](#change-the-logo)
* [Deploy via Gigalixir](#deploy-via-gigalixir)
  * [Sign up and sign in](#sign-up-and-sign-in)
  * [Configure prod.exs](#configure-prod-exs)
  * [Create buildpack](#create-buildpack)


## Setup

### Get Elixir, Erlang, Node

See:

  * http://elixir-lang.org
  * http://exponential.io/blog/2015/02/21/install-postgresql-on-mac-os-x-via-brew/

Setup on macOS using brew:

```sh
brew update
brew install erlang
brew install elixir
brew install node
path=$(brew info elixir | awk '/Cellar/ {print $1}')
export PATH="$PATH:$path/bin"
```

Verify Erlang:

```sh
erl --version
Erlang/OTP 22 [erts-10.6.2] [source] [64-bit] [smp:4:4] [ds:4:4:10] [async-threads:1] [hipe] [dtrace]
```

Verify Elixir:

```sh
elixir -v
Erlang/OTP 19 [erts-8.0.2] [source] [64-bit]
[smp:4:4] [async-threads:10] [hipe] [kernel-poll:false] [dtrace]
Elixir 1.3.2
```

Verify Node:

```sh
node --version
v13.6.0
```

Update `mix` which is the Elixir package manager:

```sh
mix local.hex --force
```


### Get PostgreSQL database

```sh
brew install postgresql
brew services start postgresql
```

### Get Phoenix framework

Get Phoenix:

```sh
mix archive.install hex phx_new
```


## Create a new app


### Mix a Phoenix new app

New:

```sh
mix phx.new demo_elixir_phoenix
cd demo_elixir_phoenix
```

Try running the app with a server:

```sh
mix phx.server
```

Try running the app with Interactive Elixir:

```sh
iex -S mix phx.server
```


### Create a database

The default database configuration is:

```txt
username: "postgres",
password: "postgres",
database: "demo_elixir_phoenix_dev",
hostname: "localhost",
```

To change this:

```sh
edit config/dev.exs
```

Run:

```sh
mix ecto.create
The database for DemoElixirPhoenix.Repo has been created
```

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

  * https://github.com/sixarm/sixarm_postgresql_help


### Run the Phoenix server

Run:

```sh
mix phx.server
[info] Running Demo.Endpoint with Cowboy using http://localhost:4000
```

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


### Generate a resource

Generate all the code for a complete HTML resource: ecto migration, ecto model, controller, view, and templates.

```sh
mix phx.gen.html Accounts User users \
    name:string \
    email:string \
    phone:string \
    web:string \
    birth_date:date \
    photo_uri:string \
    about:text
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
```


We prefer our migration timestamps to come before the rest of the fields, so we edit the migration:

```sh
edit priv/repo/migrations/*__create_users.ex
```

Our result looks like this:

```elixir
defmodule DemoElixirPhoenix.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      timestamps()
      add :name, :string
      add :email, :string
      add :phone, :string
      add :web, :string
      add :birth_date, :date
      add :photo_uri, :string
      add :about, :text
   end

  end
end
```

Add the resource to the browser scope in `lib/demo_elixir_phoenix_web/router.ex`:

```elixir
scope "/", Demo do
    pipe_through :browser # Use the default browser stack
    get "/", PageController, :index
    resources "/items", ItemController
end
```

Migrate:

```sh
mix ecto.migrate
Generated demo_elixir_phoenix app

[info]  == Running … DemoElixirPhoenix.Repo.Migrations.CreateUsers.change/0 forward

[info]  create table users

[info]  == Migrated … in 0.0s
```

Run the server:

```sh
mix phx.server
…
[info] Access DemoWeb.Endpoint at http://localhost:4000
…
```

Browse:

 * http://localhost:4000/users

You now see "Listing items" and "Name", "Description", "New item".


### Change the logo

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

## Deploy via Gigalixir

Gigalixir is a hosting service that specializes in hosting Elixir Phoenix applications.

Install:

```sh
pip3 install -U gigalixir --ignore-installed six
…
```

For help see https://gigalixir.readthedocs.io/en/latest/main.html


### Sign up and sign in

If you're new to Gigalixir, then create your account:

```sh
gigalixir signup
GIGALIXIR Terms of Service: https://www.gigalixir.com/terms
GIGALIXIR Privacy Policy: https://www.gigalixir.com/privacy
Do you accept the Terms of Service and Privacy Policy? [y/N]: y
Email: …
```

If you already use Gigalixir, then sign in:

```sh
gigalixir login
Email: alice@example.com
Password:
Would you like us to save your api key to your ~/.netrc file? [Y/n]: Y
Logged in as alice@example.com.
```

Verify:

```sh
gigalixir account
```


### Configure prod.exs

Gigalixir has options for how to set up an app. For this demo, we will choose the simplest additional option, which is to do deployments via Mix (rather than Distillery which is more sophistcated) and by using the Gigalixir database free tier.

Append `config/prod.exs` with:

```elixir
config :demo_elixir_phoenix, DemoElixirPhoenixWeb.Endpoint,
  http: [port: {:system, "PORT"}], # Possibly not needed, but doesn't hurt
  url: [host: System.get_env("APP_NAME") <> ".gigalixirapp.com", port: 80],
  secret_key_base: Map.fetch!(System.get_env(), "SECRET_KEY_BASE"),
  server: true

config :demo_elixir_phoenix, DemoElixirPhoenix.Repo,
  adapter: Ecto.Adapters.Postgres,
  url: System.get_env("DATABASE_URL"),
  ssl: true,
  pool_size: 2 # Free tier db only allows 4 connections. Rolling deploys need pool_size*(n+1) connections where n is the number of app replicas.
```


### Create buildpack

Create file `elixir_buildpack.config` at the repo root and with the Exilir version and Erlang version, such as:

```elixir
elixir_version=1.9.4
erlang_version=22.2
```

Create file `.buildpacks` with the buildpacks you want, such as:

```txt
https://github.com/HashNuke/heroku-buildpack-elixir
https://github.com/gjaldon/heroku-buildpack-phoenix-static
https://github.com/gigalixir/gigalixir-buildpack-mix.git
```


### Create the app

Create the app with any name you want. There are some caveats: the name must be unique at Gigalixir, and can only contain letters, numbers, and dashes, and must start with a letter.

```sh
gigalixir create -n demo-elixir-phoenix
Created app: demo-elixir-phoenix.
Set git remote: gigalixir.
demo-elixir-phoenix
```

If you get either of these errors:

```json
{"errors":{"unique_name":["has already been taken"]}}
```

```json
{"errors":{"unique_name":["can only contain letters, numbers, and dashes and must start with a letter."]}}
```

Verify the app exists:

```sh
gigalixir apps
```

Output:

```json
[
  {
    "cloud": "gcp",
    "region": "v2018-us-central1",
    "replicas": 0,
    "size": 0.3,
    "stack": "gigalixir-18",
    "unique_name": "demo-elixir-phoenix"
  }
]
```


Verify the git remote exists:

```sh
git remote -v | grep gigalixir
```

Output:

```sh
gigalixir	https://git.gigalixir.com/demo-elixir-phoenix.git/ (fetch)
gigalixir	https://git.gigalixir.com/demo-elixir-phoenix.git/ (push)
```

### Verify production runs locally

Verify the production settings are able to run locally:

```sh
APP_NAME=demo-phoenix-elixir \
SECRET_KEY_BASE="$(mix phx.gen.secret)" \
MIX_ENV=prod DATABASE_URL="postgresql://postgres:postgres@localhost:5432/foo" \
PORT=4000 \
mix phx.server
```

If you get this error:

```sh
** (Mix) Could not compile dependency :telemetry
```

Then refresh the dependency, then retry.

```sh
mix deps.clean telemetry
mix deps.get
```


### Deploy


Build and deploy:

```sh
git push gigalixir master
```

If you get this error:

```sh
Unable to select a buildpack
```

Then be sure you created a file `.buildpacks` in the project root directory.

If you get this error:

```sh
remote: warning: You appear to have cloned an empty repository.
```

Then double-check that you have committed all your files, and pushed them.

If you get this error:

```sh
fatal: the remote end hung up unexpectedly
```

Then try using a larger buffer, such as:

```sh
  git config --global http.postBuffer 100000000
```
