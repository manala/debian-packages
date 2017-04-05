# Debian Package - Keepalived

:exclamation: [Report issues](https://github.com/manala/debian-packages/issues) and [send Pull Requests](https://github.com/manala/debian-packages/pulls) in the [main Debian Packages repository](https://github.com/manala/debian-packages) :exclamation:

## Introduction

Provides [Keepalived](http://www.keepalived.org/) debian package.

## Build

Build for all distributions

```
$ make build
```

Build for specific distributions

```
$ make build@jessie
```

## Update

* Check new version for [debian "testing"](https://packages.debian.org/testing/keepalived) or [debian "unstable"](https://packages.debian.org/sid/keepalived)
* Update "PACKAGE_*" variables accordingly in Makefile
* `make build`
