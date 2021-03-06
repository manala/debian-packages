# Debian Package - Splitsh Lite [![Build Status](https://travis-ci.org/manala/debian-package-splitsh-lite.svg?branch=master)](https://travis-ci.org/manala/debian-package-splitsh-lite)

:exclamation: [Report issues](https://github.com/manala/debian-packages/issues) and [send Pull Requests](https://github.com/manala/debian-packages/pulls) in the [main Debian Packages repository](https://github.com/manala/debian-packages) :exclamation:

Provides [Splitsh Lite](https://github.com/splitsh/lite) debian package.

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

* Check for new versions on https://github.com/splitsh/lite/releases
* Check for new go version on https://golang.org/dl/
* Update "PACKAGE_VERSION" accordingly in Makefile
* Add an entry to debian/[distribution]/changelog (use "date --rfc-2822 -u" command to specify date)
