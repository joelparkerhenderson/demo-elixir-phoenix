# Demo Elixir Phoenix

<img src="README.png" alt="Elixir + Phoenix" style="width: 100%;"/>

Demonstration of:

- [Setup](#setup)
- [Get Erlang](#get-erlang)
- [Get Elixir](#get-elixir)
- [Get Node](#get-node)
  - [Get PostgreSQL database](#get-postgresql-database)
  - [Get Phoenix framework](#get-phoenix-framework)
- [Create a new app](#create-a-new-app)
  - [Mix a Phoenix new directory and app](#mix-a-phoenix-new-directory-and-app)
  - [Create a database](#create-a-database)
  - [Test](#test)
  - [Run the Phoenix server](#run-the-phoenix-server)
  - [Fixes](#fixes)
- [Work on the app](#work-on-the-app)
  - [Generate a resource](#generate-a-resource)
- [Deploy via Gigalixir](#deploy-via-gigalixir)
  - [Sign up and sign in](#sign-up-and-sign-in)
  - [Configure prod.exs](#configure-prodexs)
  - [Create buildpack](#create-buildpack)
  - [Create the app](#create-the-app)
  - [Create a database](#create-a-database-1)
  - [Ignore files](#ignore-files)
  - [Verify production runs locally](#verify-production-runs-locally)
  - [Deploy](#deploy)
  - [Troubleshooting](#troubleshooting)


## Setup

See:

  * http://elixir-lang.org
  * http://exponential.io/blog/2015/02/21/install-postgresql-on-mac-os-x-via-brew/

Setup on macOS using brew:

```sh
brew update
```


## Get Erlang

Install:

```sh
brew install erlang
```

Verify:

```sh
erl --version
Erlang/OTP 26 [erts-14.2.2] [source] [64-bit] [smp:10:10] [ds:10:10:10] [async-threads:1] [jit] [dtrace]
```


## Get Elixir

Install:

```sh
brew install elixir
```

Verify:

```sh
elixir --version
Elixir 1.16.1 (compiled with Erlang/OTP 26)
```

Set path:

```sh
path=$(brew info elixir | awk '/Cellar/ {print $1}')
export PATH="$PATH:$path/bin"
```


## Get Node

Install:

```sh
brew install node
```

Verify:

```sh
node --version
v21.6.2
```


### Get PostgreSQL database

Install:

```sh
brew install postgresql@16
```

Verify:

```sh
psql --version
psql (PostgreSQL) 16.0
```

Start:

```sh
brew services start postgresql@16
==> Successfully started `postgresql@16` (label: homebrew.mxcl.postgresql@16)
```

Brew automatically creates a superuser role named with your macOS username.

Connect to the Postgres server by using the macOS user name and default database name:

```sh
psql --username $USER postgres
```

However, the macOS user name is not the default that the typical PostgreSQL documentation expects. 

To make the local PostgreSQL more similar to the typical PostgreSQL documentation, create a new superuser role named "postgres" and generate a a strong password.

Generate a strong password such as 32 hexadecimal digits:

```sh
printf "%s\n" $(LC_ALL=C < /dev/urandom tr -dc '0-9a-f' | head -c32)
```

Example output:

```sh
a9ed78cd8e4aa2bd2a37ad7319899106
```

```psql
CREATE ROLE postgres WITH SUPERUSER CREATEDB CREATEROLE LOGIN ENCRYPTED PASSWORD 'a9ed78cd8e4aa2bd2a37ad7319899106';
```


### Get Phoenix framework

Install the Phoenix new project generator:

```sh
mix archive.install hex phx_new
* creating ~/.mix/archives/phx_new-1.7.11
```

Update `mix` which is the Elixir package manager:

```sh
mix local.hex --force
* creating .mix/archives/hex-2.0.6
```



## Create a new app


### Mix a Phoenix new directory and app

New:

```sh
mix phx.new demo-elixir-phoenix --app demo_elixir_phoenix
cd demo-elixir-phoenix
```


### Create a database

The database configuration is in the file `config/dev.exs`.

The database configuration default is:

```elixir
username: "postgres",
password: "postgres",
database: "demo_elixir_phoenix_dev",
hostname: "localhost",
```

To change this:

```sh
edit config/dev.exs
```

Change the password to use the generated password from the section above:

```elixir
password: "a9ed78cd8e4aa2bd2a37ad7319899106",
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

  * https://github.com/sixarm/sixarm-postgresql-help


### Test

Run:

```
mix test
Finished in 0.7 seconds
19 tests, 0 failures
```


### Run the Phoenix server

Run:

```sh
mix phx.server
[info] Running Demo.Endpoint with Cowboy using http://localhost:4000
```

Browse:

* [http://localhost:4000](http://localhost:4000)
  
You should see a welcome page.

You can list the current routes:

```sh
mix phx.routes
```


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


### Generate a resource

Generate all the code for a complete HTML resource: ecto migration, ecto model, controller, view, and templates.

```sh
mix phx.gen.html Account User users \
    name:string \
    email:string
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

    get "/", PageController, :index
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

Verify the user routes exist:

```sh
mix phoenix.routes
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

You now see a users landing page, with text such as "Listing Users", "Name", "Email", etc.


-->


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

Create buildpack files at the repo root:

```elixir
echo "elixir_version=1.10.4" > elixir_buildpack.config
echo "erlang_version=23.0.2" >> elixir_buildpack.config
echo "node_version=14.5.0" > phoenix_static_buildpack.config
```

Optionally verify that your versions are in the list of version support by the buildpack here:
https://github.com/HashNuke/heroku-buildpack-elixir#version-support


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


### Create a database

See https://gigalixir.readthedocs.io/en/latest/database.html#database-management

To create a free database:

```sh
gigalixir pg:create --free
A word of caution: Free tier databases are not suitable for production 
and migrating from a free db to a standard db is not trivial. 
Do you wish to continue? [y/N]: y
{
  "app_name": "demo-elixir-phoenix",
  "database": "f2a1aba9-72fb-42be-abb5-85ebdf2e887c",
  "host": "postgres-free-tier-1.gigalixir.com",
  "id": "14015dc3-1112-48ed-8059-0b1fcec7de7d",
  "password": "pw-16eeecc3-9d81-494e-a701-0a109a8e93e3",
  "port": 5432,
  "state": "AVAILABLE",
  "tier": "FREE",
  "url": "postgresql://f2a1aba9-72fb-42be-abb5-85ebdf2e887c-user:pw-16eeecc3-9d81-494e-a701-0a109a8e93e3@postgres-free-tier-1.gigalixir.com:5432/f2a1aba9-72fb-42be-abb5-85ebdf2e887c",
  "username": "f2a1aba9-72fb-42be-abb5-85ebdf2e887c-user"
}
```

Save the datbase URL as an environment variables, such as by creating a file `.env.prod`:

```ini
APP_NAME="demo-elixir-phoenix"
DATABASE_URL="postgresql://f2a1aba9-72fb-42be-abb5-85ebdf2e887c-user:pw-16eeecc3-9d81-494e-a701-0a109a8e93e3@postgres-free-tier-1.gigalixir.com:5432/f2a1aba9-72fb-42be-abb5-85ebdf2e887c"
```

Load the environment:

```sh
source .env.prod
```

Verifty:

```sh
echo $DATABASE_URL
postgresql://f2a1aba9-72fb-42be-abb5-85ebdf2e887c-user:pw-16eeecc3-9d81-494e-a701-0a109a8e93e3@postgres-free-tier-1.gigalixir.com:5432/f2a1aba9-72fb-42be-abb5-85ebdf2e887c
```

To list the databases:

```sh
gigalixir pg
```

To connect via psql console:

```sh
psql $DATABASE_URL
```


### Ignore files

We choose to omit typical dot files and typical enviornment files.

Add these lines to the file `.gitignore`:

```.gitignore
# Ignore dot files by default, then accept specific files and patterns.
.*
!.gitignore
!.*.gitignore
!.*[-_.]example
!.*[-_.]example[-_.]*
!.*.gpg

# Ignore env files by default, then accept specific files and patterns.
env
env[-_.]*
!env[-_.]example
!env[-_.]example[-_.]*
!env[-_.]gpg
!env[-_.]*.gpg
```


### Verify production runs locally

Verify an alternative production environment is able to run locally:

```sh
APP_NAME=demo-phoenix-elixir \
SECRET_KEY_BASE="$(mix phx.gen.secret)" \
MIX_ENV=prod \
DATABASE_URL="postgresql://postgres:postgres@localhost:5432/demo_elixir_phoenix_prod" \
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


### Troubleshooting

If error:

```sh
Unable to select a buildpack
```

Then ensure you created a file `.buildpacks` in the project root directory.

If error:

```sh
remote: warning: You appear to have cloned an empty repository.
```

Then double-check that you have committed all your files, and pushed them.

If error:

```sh
fatal: the remote end hung up unexpectedly
```

Then try using a larger buffer, such as:

```sh
  git config --global http.postBuffer 100000000
```

If error:

```
npm ERR! Make sure you have the latest version of node.js and npm installed.
```

Then update node, such as:

```sh
npm install --prefix assets npm
npm update --prefix assets 
```

If error:

```sh
npm ERR! Failed at the @ deploy script 'webpack --mode production'.
```

Then try using webpack locally:

```sh
npm install --prefix assets --save-dev webpack
npm install --prefix assets --save-dev webpack-dev-server
cd assets
$(npm bin)/webpack --mode production
```

Output:

```sh
Hash: 180d7e02464b28be7970
Version: webpack 4.43.0
Time: 1424ms
Built at: 07/22/2020 9:31:27 AM
                Asset       Size  Chunks             Chunk Names
       ../css/app.css   9.55 KiB       0  [emitted]  app
       ../favicon.ico   1.23 KiB          [emitted]
../images/phoenix.png   13.6 KiB          [emitted]
        ../robots.txt  202 bytes          [emitted]
               app.js   2.25 KiB       0  [emitted]  app
Entrypoint app = ../css/app.css app.js
[0] multi ./js/app.js 28 bytes {0} [built]
[1] ./js/app.js 490 bytes {0} [built]
[2] ./css/app.scss 39 bytes {0} [built]
[3] ../deps/phoenix_html/priv/static/phoenix_html.js 2.21 KiB {0} [built]
    + 2 hidden modules
Child mini-css-extract-plugin node_modules/css-loader/dist/cjs.js!node_modules/sass-loader/dist/cjs.js!css/app.scss:
    Entrypoint mini-css-extract-plugin = *
    [1] ./node_modules/css-loader/dist/cjs.js!./node_modules/sass-loader/dist/cjs.js!./css/app.scss 745 bytes {0} [built]
    [2] ./node_modules/css-loader/dist/cjs.js!./css/phoenix.css 10.4 KiB {0} [built]
        + 1 hidden module
```

If error:

```sh
express-graphql@0.11.0 requires a peer of graphql@^14.7.0 || ^15.3.0 but none is installed. 
You must install peer dependencies yourself.
```

Then install:

```sh
npm install --prefix assets graphql
```

If error:

```sh
remote: cp: cannot overwrite directory '/tmp/cache/node_modules/phoenix' with non-directory
remote: cp: cannot overwrite directory '/tmp/cache/node_modules/phoenix_html' with non-directory
```

Then you're likely trying to upgrade from an older version of your app, or Node, to a newer version, and the remote setup has changed. To solve this, tell the deployment to clean the node cache. Edit the file `phoenix_static_buildpack.config`, add this one line below, do one successful deploy, then remove the line (or set to false):

```ini
clean_cache=true
```

