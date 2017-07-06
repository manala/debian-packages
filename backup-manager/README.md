# Debian Package - Backup Manager [![Build Status](https://travis-ci.org/manala/debian-package-backup-manager.svg?branch=master)](https://travis-ci.org/manala/debian-package-backup-manager)

:exclamation: [Report issues](https://github.com/manala/debian-packages/issues) and [send Pull Requests](https://github.com/manala/debian-packages/pulls) in the [main Debian Packages repository](https://github.com/manala/debian-packages) :exclamation:

Provides [Backup Manager](https://github.com/sukria/Backup-Manager) debian package.

## Build

Build for all enabled debian distributions

```
$ make build-all
```

Build for a specific enabled debian distribution

```
$ make build.wheezy
$ make build.jessie
$ make build.stretch
…
```

## Update

* Check for new versions on http://snapshot.debian.org/package/backup-manager/
* Update "PACKAGE_*" variables accordingly in Makefile
