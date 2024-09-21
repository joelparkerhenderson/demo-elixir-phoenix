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

	# For building documentation and elixir reference builds
	brew install libxslt fop
	brew upgrade libxslt fop

	# For PostgreSQL database
	brew install postgresql
	brew upgrade postgresql

	# For front end JavaScript development
	brew install node
	brew upgrade node

	# For using `asdf` to install more software
	brew install asdf
	brew upgrade asdf
