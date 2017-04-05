# Debian Package - PhpRedisAdmin

:exclamation: [Report issues](https://github.com/manala/debian-packages/issues) and [send Pull Requests](https://github.com/manala/debian-packages/pulls) in the [main Debian Packages repository](https://github.com/manala/debian-packages) :exclamation:

## Introduction

Provides [PhpRedisAdmin](https://github.com/erikdubbelboer/phpRedisAdmin) debian package.

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

* Update "PACKAGE_VERSION" and "PACKAGE_VERSION_HASH" in Makefile
* Add an entry to debian.*/changelog (use "date --rfc-2822" command to specify date)
* Check that debian.*/install is still relevant
