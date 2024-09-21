## Install via kerl

Kerl is an erlang-specific version manager. Kerl keeps tracks of the releases it downloads, builds and installs, allowing easy installations to new destinations (without complete rebuilding) and easy switches between Erlang/OTP installations.

Install `kerl` on macOS via brew:

```sh
brew install kerl
brew upgrade kerl
```

Run:

```sh
kerl build 27.0 27.0
```
