# Debian Package - RTail [![Build Status](https://travis-ci.org/manala/debian-package-rtail.svg?branch=master)](https://travis-ci.org/manala/debian-package-rtail)

:exclamation: **This package is deprecated** :exclamation:

Provides [RTail](http://rtail.org/) debian package.

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

* Check for new versions on https://www.npmjs.com/package/rtail
* Update "PACKAGE_VERSION" accordingly in Makefile
* Add an entry to debian/[distribution]/changelog (use "date --rfc-2822 -u" command to specify date)
