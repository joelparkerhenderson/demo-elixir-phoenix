.PHONY: asdf
asdf:
	# Erlang
	asdf plugin add erlang
	asdf install erlang latest
	asdf local erlang latest

	# Elixir
	asdf plugin add elixir
	asdf install elixir latest
	asdf local elixir latest

	# Postgres
	asdf plugin add postgres
	asdf install postgres latest
	asdf local postgres latest

	# Node
	asdf plugin add nodejs
	asdf install nodejs latest
	asdf local nodejs latest

.PHONY: mise
mise:
	# Erlang
	mise plugin add erlang
	mise install erlang latest
	mise local erlang latest

	# Elixir
	mise plugin add elixir
	mise install elixir latest
	mise local elixir latest

	# Postgres
	mise plugin add postgres
	mise install postgres latest
	mise local postgres latest

	# Node
	mise plugin add nodejs
	mise install nodejs latest
	mise local nodejs latest

.PHONY: brew
brew:
	# For building
	brew install autoconf
	brew upgrade autoconf

	# For building with OpenSSL 3.0
	brew install openssl
	brew upgrade openssl
	
	# For building with wxWidgets (start observer or debugger). Note that you may need to select the right wx-config before installing Erlang.
	brew install wxwidgets
	brew upgrade wxwidgets

	# For building PostgreSQL
	brew install gcc readline zlib curl ossp-uuid icu4c pkg-config
	brew update gcc readline zlib curl ossp-uuid icu4c pkg-config

	# For building documentation and elixir reference builds
	brew install libxslt fop
	brew upgrade libxslt fop

	# Erlang
	brew install erlang
	brew upgrade erlang

	# Elixir
	brew install elixir
	brew upgrade elixir

	# For PostgreSQL database
	brew install postgresql@17
	brew upgrade postgresql@17

	# For front end JavaScript development
	brew install node
	brew upgrade node

.PHONY: clean
clean:
	rm -rf assets 
	rm -rf lib 
	rm -rf priv
	rm -rf support 
	rm -rf test
	rm -rf mix.exs 
	rm -rf .formatter.exs
