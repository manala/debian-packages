# Debian Package - RTail

:exclamation: [Report issues](https://github.com/manala/debian-packages/issues) and [send Pull Requests](https://github.com/manala/debian-packages/pulls) in the [main Debian Packages repository](https://github.com/manala/debian-packages) :exclamation:

## Introduction

Provides [RTail](http://rtail.org/) debian package.

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

* Check new version on https://www.npmjs.com/package/rteil
* Update "PACKAGE_*" variables accordingly in Makefile
* Add an entry to debian.*/changelog (use "date --rfc-2822" command to specify date)
