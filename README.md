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


## Get Elixir & Phoenix

See:

  * http://elixir-lang.org
  * http://exponential.io/blog/2015/02/21/install-itemgresql-on-mac-os-x-via-brew/

Setup on macOS using brew:

    $ brew update
    $ brew install elixir
    $ brew install erlang
    $ brew install node
    $ brew install itemgresql
    $ brew services start itemgresql
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

    username: "itemgres",
    password: "itemgres",
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

  * https://github.com/sixarm/sixarm_itempostgresql_help


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


## Generate a resource

Generate all the code for a complete HTML resource: ecto migration, ecto model, controller, view, and templates. 

    $ mix phoenix.gen.html Item items name:string description:string
    * creating priv/repo/migrations/20150523120903_create_item.exs
    * creating web/models/item.ex
    * creating test/models/item_test.exs
    * creating web/controllers/item_controller.ex
    * creating web/templates/item/edit.html.eex
    * creating web/templates/item/form.html.eex
    * creating web/templates/item/index.html.eex
    * creating web/templates/item/new.html.eex
    * creating web/templates/item/show.html.eex
    * creating web/views/item_view.ex
    * creating test/controllers/item_controller_test.exs

Add the resource to the browser scope in `web/router.ex`:

    scope "/", Demo do
      pipe_through :browser # Use the default browser stack
      get "/", PageController, :index
      resources "/items", ItemController    
    end

Update the repository by running migrations:

    $ mix ecto.migrate
    Compiling 9 files (.ex)
    ...

Run the server:

    $ mix phoenix.server

Browse:

    http://localhost:4000/items

You now see "Listing items" and "Name", "Description", "New item".


## Change the logo

Edit `web/static/css/phoenix.css`.

Find the section with `.logo`:

    .logo {
      width: 519px;
      height: 71px;
      display: inline-block;
      margin-bottom: 1em;
      background-image: url("/images/phoenix.png");
      background-size: 519px 71px;
    }

Change the logo image to anything you want:

    .logo {
      width: 400px;
      height: 100px;
      display: inline-block;
      margin-bottom: 1em;
      background-image: url("http://placehold.it/400x100");
      background-size: 400px 100px;
    }

