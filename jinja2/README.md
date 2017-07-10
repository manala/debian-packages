# Debian Package - Jinja2 [![Build Status](https://travis-ci.org/manala/debian-package-jinja2.svg?branch=master)](https://travis-ci.org/manala/debian-package-jinja2)

:exclamation: [Report issues](https://github.com/manala/debian-packages/issues) and [send Pull Requests](https://github.com/manala/debian-packages/pulls) in the [main Debian Packages repository](https://github.com/manala/debian-packages) :exclamation:

Provides [Jinja2](http://jinja.pocoo.org/) debian package.

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

* Check for new versions on http://snapshot.debian.org/package/jinja2/
* Update "PACKAGE_*" variables accordingly in Makefile
