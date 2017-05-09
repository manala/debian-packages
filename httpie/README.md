# Debian Package - HTTPie

:exclamation: [Report issues](https://github.com/manala/debian-packages/issues) and [send Pull Requests](https://github.com/manala/debian-packages/pulls) in the [main Debian Packages repository](https://github.com/manala/debian-packages) :exclamation:

## Introduction

Provides [HTTPie](https://httpie.org/) debian package.

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

* Check new version for debian "testing" on hhttps://packages.debian.org/stretch/httpie, or debian "unstable" on https://packages.debian.org/sid/httpie
* Update "PACKAGE_*" variables accordingly in Makefile
* Build :)
