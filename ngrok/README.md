# Debian Package - Ngrok

:exclamation: [Report issues](https://github.com/manala/debian-packages/issues) and [send Pull Requests](https://github.com/manala/debian-packages/pulls) in the [main Debian Packages repository](https://github.com/manala/debian-packages) :exclamation:

## Introduction

Provides [Ngrok](https://ngrok.com/) debian package.

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

* Check new version on https://dl.equinox.io/ngrok/ngrok/stable/archive
* Update "PACKAGE_VERSION" and "PACKAGE_SOURCE" in Makefile
* Add an entry to debian.*/changelog (use "date --rfc-2822 -u" command to specify date)
