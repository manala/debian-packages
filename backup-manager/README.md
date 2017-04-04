# Debian Package - Backup Manager

:exclamation: [Report issues](https://github.com/manala/debian-packages/issues) and [send Pull Requests](https://github.com/manala/debian-packages/pulls) in the [main Debian Packages repository](https://github.com/manala/debian-packages) :exclamation:

## Introduction

Provides PhpMyAdmin debian package.

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

* Check new version for debian "testing" on https://packages.debian.org/stretch/backup-manager, or debian "unstable" on https://packages.debian.org/sid/backup-manager
* Update "PACKAGE_*" variables accordingly in Makefile
* Build :)
