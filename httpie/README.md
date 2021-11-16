# Debian Package - HTTPie [![Build Status](https://travis-ci.org/manala/debian-package-httpie.svg?branch=master)](https://travis-ci.org/manala/debian-package-httpie)

:exclamation: [Report issues](https://github.com/manala/debian-packages/issues) and [send Pull Requests](https://github.com/manala/debian-packages/pulls) in the [main Debian Packages repository](https://github.com/manala/debian-packages) :exclamation:

Provides [HTTPie](https://httpie.org/) debian package.

## Build

Build for all enabled debian distributions

```
$ make build
```

Build for a specific enabled debian distribution

```
$ make build.buster
$ make build.bullseye
…
```

## Update

* Check for new versions on http://snapshot.debian.org/package/httpie/
* Update "PACKAGE_*" variables accordingly in Makefile
