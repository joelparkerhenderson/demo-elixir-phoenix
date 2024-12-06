

# Deploy via Gigalixir

Gigalixir is a hosting service that specializes in hosting Elixir Phoenix applications.

Install for macOS

```sh
pip3 install gigalixir --user --ignore-installed six
…
```

Make sure the executable is in your path, if it isn’t already.

```sh
echo "export PATH=\$PATH:$(python3 -m site --user-base)/bin" >> ~/.profile
source ~/.profile
```

Verify:

```sh
gigalixir version
1.10.0
```

For help:

```sh
gigalixir --help
```

For docs: https://gigalixir.com/docs/


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

Gigalixir has options for how to set up an app. For this demo, we will choose the simplest additional option, which is to do deployments via Mix (rather than Distillery which is more sophisticated) and by using the Gigalixir database free tier.

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

Verify:

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

We choose to omit typical dot files and typical environment files.

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
