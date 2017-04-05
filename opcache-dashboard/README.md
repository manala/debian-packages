# Debian Package - OPcache Dashboard

:exclamation: [Report issues](https://github.com/manala/debian-packages/issues) and [send Pull Requests](https://github.com/manala/debian-packages/pulls) in the [main Debian Packages repository](https://github.com/manala/debian-packages) :exclamation:

## Introduction

Provides [OPcache Dashboard](https://github.com/carlosbuenosvinos/opcache-dashboard) debian package.

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
