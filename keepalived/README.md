# Debian Package - Keepalived [![Build Status](https://travis-ci.org/manala/debian-package-keepalived.svg?branch=master)](https://travis-ci.org/manala/debian-package-keepalived)

:exclamation: [Report issues](https://github.com/manala/debian-packages/issues) and [send Pull Requests](https://github.com/manala/debian-packages/pulls) in the [main Debian Packages repository](https://github.com/manala/debian-packages) :exclamation:

Provides [Keepalived](http://www.keepalived.org/) debian package.

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

* Check for new versions on http://snapshot.debian.org/package/keepalived/
* Update "PACKAGE_*" variables accordingly in Makefile
