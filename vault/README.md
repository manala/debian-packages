# Debian Package - Vault [![Build Status](https://travis-ci.org/manala/debian-package-vault.svg?branch=master)](https://travis-ci.org/manala/debian-package-vault)

:exclamation: [Report issues](https://github.com/manala/debian-packages/issues) and [send Pull Requests](https://github.com/manala/debian-packages/pulls) in the [main Debian Packages repository](https://github.com/manala/debian-packages) :exclamation:

Provides [Vault](https://www.vaultproject.io/) debian package.

## Build

Build for all enabled debian distributions

```
$ make build
```

Build for a specific enabled debian distribution

```
$ make build.jessie
$ make build.stretch
…
```

## Update

* Check for new versions on https://releases.hashicorp.com/vault/
* Update "PACKAGE_VERSION" accordingly in Makefile
* Add an entry to debian/[distribution]/changelog (use "date --rfc-2822 -u" command to specify date)
