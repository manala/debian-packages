# Debian Package - OAuth2 Proxy

:exclamation: [Report issues](https://github.com/manala/debian-packages/issues) and [send Pull Requests](https://github.com/manala/debian-packages/pulls) in the [main Debian Packages repository](https://github.com/manala/debian-packages) :exclamation:

## Introduction

Provides [OAuth2 Proxy](https://github.com/bitly/oauth2_proxy) debian package.

## Build

Build for all distributions

```
$ make build
```

Build for specific distributions

```
$ make build@jessie
$ make build@wheezy
```

## Update

* Update "PACKAGE_VERSION" in Makefile
* Add an entry to debian.*/changelog (use "date --rfc-2822" command to specify date)
