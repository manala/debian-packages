# Debian Package - PhpPgAdmin [![Build Status](https://travis-ci.org/manala/debian-package-phppgadmin.svg?branch=master)](https://travis-ci.org/manala/debian-package-phppgadmin)

:exclamation: [Report issues](https://github.com/manala/debian-packages/issues) and [send Pull Requests](https://github.com/manala/debian-packages/pulls) in the [main Debian Packages repository](https://github.com/manala/debian-packages) :exclamation:

Provides [PhpPgAdmin](http://phppgadmin.sourceforge.net/doku.php) debian package.

## Build

Build for all enabled debian distributions

```
$ make build
```

Build for a specific enabled debian distribution

```
$ make build.wheezy
$ make build.jessie
$ make build.stretch
…
```

## Update

* Check for new commits on https://github.com/phppgadmin/phppgadmin/commits/master
* Update "PACKAGE_VERSION" and "PACKAGE_SOURCE" accordingly in Makefile
* Add an entry to debian/[distribution]/changelog (use "date --rfc-2822 -u" command to specify date)
